package models

import boss.jsany._
import boss.{Boss, BossCase, BossSerializable}
import cloud.{Api, Item}
import models.KeyTypes._
// import storage.Storage
import tools.universa.UniversaTools
import tools.universa.UniversaTools._
import xchange.XChangeAPI

import scala.collection.mutable
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.Future
import scala.scalajs.js
import scala.scalajs.js.JSConverters._
import scala.scalajs.js.annotation.{JSExportStatic, JSExportTopLevel}

object KeyTypes {
  val PublicKeyType = "PublicKey"
  val PrivateKeyType = "PrivateKey"
}

case class PairJS(
                   name: String,
                   keyType: String,
                   key: Seq[Byte],
                   size: Int,
                   createdAt: js.Date,
                   cloudId: String
                 ) extends BossCase

/**
  * Key pair (with or without private key)
  */

class Pair(val publicKey: PublicKey,
           var privateKey: Option[PrivateKey] = None,
           var name: String = s"pair${UniversaTools.dateTimeStringNow}",
           val createdAt: js.Date = XChangeAPI.getNetworkJsDate(),
           var cloudId: Option[Double] = None)
  extends BossSerializable {

  var uuid: String = encode64(publicKey.fingerprint)

  def show: Unit = println("Has private ?" + privateKey)

  def toJS: PairJS = {
    val keyType = privateKey.fold(PublicKeyType)(_ => PrivateKeyType)
    val key = privateKey.fold(publicKey.toBOSS)(_.pack)
    val nameJS = name

    PairJS(nameJS, keyType, key, publicKey.bits, createdAt, cloudId.map(_.toString).orNull)
  }

}

@JSExportTopLevel("Universa.Pair")
class PairExported(val pair: Pair) extends CloudElement {
  def name: String = pair.name

  def setName(newName: String) = {
    pair.name = newName
  }

  def setPrivateKey(privateKey: PrivateKey) = {
    pair.privateKey = Some(privateKey)
  }

  def toBOSS(): js.Array[Byte] = {
    Boss.dump(pair).toJSArray
  }

  var privateKey: PrivateKeyExported = pair.privateKey.map(pk => new PrivateKeyExported(pk)).orNull
  var publicKey: PublicKeyExported = new PublicKeyExported(pair.publicKey)

  def deleteFromCloud(api: Api): js.Promise[Boolean] = {
    val cloudId = pair.cloudId.getOrElse(throw new RuntimeException("Not known cloud id"))
    val loaded = api.getItem({ api => new Item(api) }, mutable.HashMap[String, Any]("id" -> cloudId))
    loaded.flatMap(_.destroy).toJSPromise
  }

  def toCloud(api: Api): js.Promise[Double] = {
    val itemF = pair.cloudId.map { cloudId =>
      api.getItem({ api => new Item(api) }, mutable.HashMap[String, Any]("id" -> cloudId))
    }.getOrElse {
      var item: Item = null
      item = new Item(api)
      item.setTag(PairExported.ItemTag)
      Future.successful(item)
    }
    itemF.flatMap { item =>
      item.setPrivateData("pair", UniversaTools.encode64(Boss.dump(pair)))
      item.setPrivateData("version", 2)
      item.save.map { _ =>
        val itemId = item.id.get.toDouble
        pair.cloudId = Option(itemId)
        itemId
      }
    }.toJSPromise
  }
}

object PairExported extends CloudFunc[PairExported] {
  val ItemTag: String = "pair"

  @JSExportStatic("fromBOSS")
  def fromBOSS(bytes: js.Array[Byte]): PairExported = {
    val pair = Boss.load(bytes).asInstanceOf[Pair]
    new PairExported(pair)
  }

  @JSExportStatic("FromPrivateKey")
  def apply(privK: PrivateKeyExported): PairExported = {

    new PairExported(new Pair(privK.publicKey.publicKey, Some(privK.privateKey)))
  }

  @JSExportStatic("FromPublicKey")
  def apply(publicKey: PublicKeyExported): PairExported = {
    new PairExported(new Pair(publicKey.publicKey))
  }

  def apply(pairJs: PairJS): Pair = {
    val pair =
      if (pairJs.keyType == PublicKeyType) {
        val publicKey = PublicKeyExported.fromBOSS(pairJs.key.toJSArray)

        new Pair(publicKey.publicKey, None, pairJs.name, pairJs.createdAt)
      } else { //pairJs.keyType == private key
        val privateKey = new PrivateKey(pairJs.key)
        val pair = new Pair(privateKey.publicKey, Some(privateKey), pairJs.name, pairJs.createdAt)
        pair.cloudId = Option(pairJs.cloudId).map(_.toDouble)
        pair
      }
    pair
  }

  def fromItemOpt(item: Item): Option[PairExported] = {
    val version = item.priv.get("version").map(_.asInstanceOf[Int]).getOrElse(1)
    version match {
      case 2 =>
        val tr = item.priv("pair").asInstanceOf[String]
        val loaded = Boss.load(decode64(tr))
        val p = loaded.asInstanceOf[Pair]
        p.cloudId = item.id.map(_.toDouble)
        Some(new PairExported(p))
      case _ => None
    }
  }

  def fromJS(serialized: BossCase): BossSerializable = {
    apply(serialized.asInstanceOf[PairJS])
  }

  ////////cloud storage
  @JSExportStatic("AllFromCloud")
  def downloadAllFromCloud(api: Api): js.Promise[js.Array[PairExported]] = {
    cloud.Tools.importAllObjects(api, ItemTag, fromItemOpt).toJSPromise
  }

  @JSExportStatic("FromCloud")
  def downloadFromCloudJS(cloudId: Double, api: Api): js.Promise[PairExported] = {
    val loaded = api.getItem({ api => new Item(api) }, mutable.HashMap[String, Any]("id" -> cloudId))
    loaded
      .map(item => fromItemOpt(item).orNull)
      .toJSPromise
  }

  @JSExportStatic("ToCloud")
  def uploadToCloudJS(pairExp: PairExported, api: Api): js.Promise[Double] = {
    val pair = pairExp.pair
    val itemF = pair.cloudId.map { cloudId =>
      api.getItem({ api => new Item(api) }, mutable.HashMap[String, Any]("id" -> cloudId))
    }.getOrElse {
      var item: Item = null
      item = new Item(api)
      item.setTag(ItemTag)
      Future.successful(item)
    }
    itemF.flatMap { item =>
      item.setPrivateData("pair", UniversaTools.encode64(Boss.dump(pair)))
      item.setPrivateData("version", 2)
      item.save.map { _ =>
        val itemId = item.id.get.toDouble
        pair.cloudId = Option(itemId)
        itemId
      }
    }.toJSPromise
  }
}
