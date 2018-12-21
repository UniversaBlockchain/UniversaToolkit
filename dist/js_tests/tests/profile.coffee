dec64 = Universa.utils.decode64
enc64 = Universa.utils.encode64

Unitest.addTestModule ->

   TEST_APP_TOKEN = "ehUEdnfhDqhBAWK77Rndam0d+L6NVhGDGm/ma3SHHZQA4kgs4uf1AnYJKqKHU2qQZchSeieZyquGOuCHeUtULw=="
   privKey = dec64 '''JgAcAQABxAEBAOsjhh8HIil0hBrXLwsro+OaOkV4F38vjMGGPiTqgSVDpg0VW1smBEcH8YkmZ8V0gwCkqAjfk0HzBAJLJ5mGpVNgrtu1cqAYnslZYEaEbTrSAKTlBJRb4vZbB8dxkO1cbq07G3eSd9bw6bw+rpf589PJNO0UxlyFKuSV+ybRqTGGGm1RK4weqlVFBCyVpl9mFeJ2BrlR/3KC8zF6FMrjQGcqGaSNiljkVI3yw9Olz7RCzaj1fXyf8XmAwhSpRiRMv8n3CTRpnfBLGUuKeI4yt5bg7y+9lINpM3u9yf+/1GP7g7gj0FUlEu0pYBpPljaT7FXlMHynA4jUuvFlli/y7c/EAQEAx0QToND4exRXju5Rcg1HIgJji0e+uT94h3JhDnkwQun3zp0W4LM0jMNykjblBKcr7pEmacIdJNzgC/zOZudbnIVMxlulbeGGScNF9srCPbCZp7X60BNaeDqDR/IYSPm6Qympl/5aGHq7kJDbt82doj/WTi8RCbxUY4CbAe9e16B/Me0MSLniZJmprj9Vz7NgnxGNNsPH1TtFJQbHd20dtyfSCcoVV054WyoQC7KFgpEEH7r733fb/eJyzJDv+zkPmF/JkdX1JgrjVSAGrPOqvcc+K4zmjJ3v9gJMEAPIGwK8xK/f8FtAsGaEphSUzlyQFvh06FrbWc8LWuL944Inew=='''


   Unitest.addTest 'import profile test', ->


        chatleApi = await CryptoCloud.connect(TEST_APP_TOKEN, privKey)

        #res = await Universa.Profile.FromCloud(chatleApi, '')
        #@assert !res

        profile = Universa.Profile.create('first', 'last', true)
        clId = await profile.toCloud(chatleApi)
        #console.log(clId)

        #prof = await chatleApi.loadItems({ tags: ['profile'], limit: 1 })
        #console.log(prof)

        res2 = await Universa.Profile.FromCloud(chatleApi, '')
        console.log(res2)
        profile.deleteFromCloud(chatleApi)

        @assertEquals res2.firstName, 'first'
        @assertEquals res2.lastName, 'last'
        @assertEquals res2.isPublic, true

    Unitest.addTest 'import contact test', ->

        chatleApi = await CryptoCloud.connect(TEST_APP_TOKEN, privKey)

        contacts = await chatleApi.loadItems({ tags: ['contact'], limit: 5 })
        console.log(contacts)

        res = await Universa.Import.Contacts(chatleApi)
        console.log(res)

        tocloudid = await res[0].contact.toCloud(chatleApi)
        console.log(tocloudid)

        contact = await Universa.Contact.fromCloud(tocloudid, chatleApi)
        console.log(contact)

        all = await Universa.Contact.allFromCloud(chatleApi)
        console.log(all)

        contact.deleteFromCloud(chatleApi)

        @assertEquals all.length, 2

    Unitest.addTest 'contact: toJsObject, fromJsObject', ->

        chatleApi = await CryptoCloud.connect(TEST_APP_TOKEN, privKey)

        contacts = await chatleApi.loadItems({ tags: ['contact'], limit: 5 })
        console.log(contacts)

        res = await Universa.Import.Contacts(chatleApi)
        console.log(res)
        console.log(res[0])

        jso = res[0].contact.toJsObject()
        res0 = Universa.Contact.fromJsObject(jso)


        tocloudid = await res[0].contact.toCloud(chatleApi)
        console.log(tocloudid)

        contact = await Universa.Contact.fromCloud(tocloudid, chatleApi)
        console.log(contact)

        jso = contact.toJsObject()
        contact = Universa.Contact.fromJsObject(jso)
        console.log(jso)

        all = await Universa.Contact.allFromCloud(chatleApi)
        console.log(all)

        contact.deleteFromCloud(chatleApi)

        @assertEquals all.length, 2