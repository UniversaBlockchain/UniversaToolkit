package cloud

import models.PublicKeyExported

import tools.universa.ImplicitConverters._

import scala.collection.mutable.HashMap
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent._
import scala.scalajs.js
import scala.scalajs.js.JSConverters._
import scala.scalajs.js.annotation.{JSExport, JSExportTopLevel}

/** Represents party for data exchange
  *
  * @constructor creates instance of party
  * @param service   - cloud access API provider
  * @param connector - connector to use data transmitting
  * @param partyData - party info
  */
@JSExportTopLevel("CryptoCloud.Party")
class Party(
             val service: Api,
             var connector: Connector,
             var partyData: HashMap[String, Any]
           ) {
  var id: Option[Int] = partyData.get("id").asInstanceOf[Option[Int]]
  var profile: Option[Item] = None
  var _publicKey: Option[models.PublicKey] = None

  /** Updates party profile info with given profile item
    *
    * @param givenProfile - profile item
    */
  def updateProfile(givenProfile: Item): Unit = {
    profile = Some(profile match {
      case None => givenProfile

      case Some(originalProfile) =>
        val originalSerial = originalProfile.record.get("serial").asInstanceOf[Int]
        val givenSerial = givenProfile.record.get("serial").asInstanceOf[Int]

        if (originalSerial > givenSerial) originalProfile
        else givenProfile
    })
  }

  /** Creates new message from current service API user to this party
    *
    * @param text - text to send
    */
  @JSExport("newMessage")
  def newMessageJS(
                    text: String,
                    data: js.Dictionary[Any] = js.Dictionary[Any]()
                  ): Message = {
    newMessage(text, data)
  }

  def newMessage(
                  text: String,
                  data: HashMap[String, Any] = HashMap[String, Any]()
                ): Message = {
    val msg = new Message(service)
    msg.privateData = Some(HashMap(
      ("type", "p2pchat"),
      ("text", text),
      ("from_party_id", service.partyId),
      ("connector_id", connector.id),
      ("payload", data)
    ))
    msg._from = Some(service.me)
    msg._to = Some(this)
    msg
  }

  @JSExport
  def newProfileMessage(
                         text: String,
                         contactData: js.Dictionary[Any]
                       ): Message = {
    val msg = new Message(service)
    val defaultMap = HashMap(
      ("type", "profile"),
      ("text", text),
      ("from_party_id", service.partyId),
      ("connector_id", connector.id),
    )

    msg.privateData = Some(defaultMap ++= contactData)
    msg._from = Some(service.me)
    msg._to = Some(this)
    msg
  }

  /** Check other party for equality
    *
    * @param otherParty - party to check
    */
  def equals(otherParty: Party): Boolean = id.get == otherParty.id.get

  /** Checks if this party represents current service API user */
  def isMe: Boolean = id.get == service.partyId

  /** Checks if this party already accepted by current service API user */
  @JSExport("isAccepted")
  def isAccepted: Boolean = isMe || connector.state == 1

  /** Checks if this party can be accepted by current service API user */
  def canBeAccepted: Boolean =
    !isMe && !isAccepted && !partyData("is_owner").asInstanceOf[Boolean]

  /** Returns publicKey of party */
  def publicKey: Option[models.PublicKey] = {
    if (!_publicKey.isEmpty) return _publicKey

    if (isMe) _publicKey = Some(service.privateKey.publicKey)
    else {
      _publicKey = partyData.get("public_key") map {
        pubk => new models.PublicKey(pubk.asInstanceOf[Seq[Byte]])
      }
    }

    _publicKey
  }

  @JSExport("id")
  def idJS: js.UndefOr[Int] = id.orUndefined

  @JSExport("publicKey")
  def publicKeyJS: js.UndefOr[models.PublicKeyExported] = {
    val exported = publicKey map { pub => new models.PublicKeyExported(pub) }
    exported.orUndefined
  }

  @JSExport("canBeAccepted")
  def canBeAcceptedJS: js.UndefOr[Boolean] = {
    val exported = partyData.get("is_owner") map { isOwner =>
      !isMe && !isAccepted && !isOwner.asInstanceOf[Boolean]
    }

    exported.orUndefined
  }

  /** Accepts this party by current service API user */
  def accept: Future[Any] = {
    if (isMe) Future.failed(throw new ApiError("can't accept self"))
    else if (!canBeAccepted) Future.failed(throw new ApiError("can't be accepted"))
    else {
      val acceptance = service.execute("connectors_accept", HashMap(("connector_id", connector.id)))
      acceptance map { response =>
        connector.update(response("connector").asInstanceOf[HashMap[String, Any]])
      }
    }
  }

  @JSExport("accept")
  def acceptJS(): js.Promise[Any] = accept.toJSPromise
}
