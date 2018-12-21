dec64 = Universa.tools.decode64
enc64 = Universa.tools.encode64
Contract = Universa.Contract
APP_TOKEN = "ehUEdnfhDqhBAWK77Rndam0d+L6NVhGDGm/ma3SHHZQA4kgs4uf1AnYJKqKHU2qQZchSeieZyquGOuCHeUtULw=="

Unitest.addTestModule ->
  PACKED_PRIVATE_KEY_2 = dec64 'JgAcAQABvIEA96FWTEq/Wjmd7kYbx04I/Ax3OQV+6e4YWu7xBr8k/SexvYvFEE3c9dRsZSsEj7KzYrNpIXezCsxO+j1sHADmeojwuveDdQQM6M6fbvygHq/mxKGllDoJTpzX/CnkuXDwC+lpRkkMTIF48GaYDM525951HYW1pAIYaVr+V5ctVQW8gQDGM71OC1yBLv6n23dEuu9Vqna2lvDpEWNO7MgKY0Ri9vUPwp+F+dUiKsRTbjnukDFqiYiNj+jkcWgiXqnjqdAGf9LUWHfF80W1PwUhkFw7torLJfaAr6bZ6FRzGcxTMad0x7Rz+5lkBjliKqOt8AUAIvMVe45G0c0StJSoqdqc4Q=='
  EXISTING_PRODUCT_ORDER_CODE = "SHvzc8A8zBAa9RE9ebzNUucpLGuinzFiRYuI_emhuk4IsHjDqUVGMQfiU"
  EXISTING_CONVERSION_ORDER_CODE = "tglH5Omec4hZfFvlA8FTeP0AiboyttkNg23_yWy4rwk84qZ6_R9qLpgUv"

  Unitest.addTest 'get utn-u limits', ->
    response = await XChange.utn.u.getLimits()

    console.log(response)

    @assertEquals response.status, 'OK'

  Unitest.addTest 'create custom utn-u order', ->
    cryptoCloudAPI = await CryptoCloud.connectWithPassword APP_TOKEN, 'output', 'adminadmin'
    nodeApi = await Node.connect(cryptoCloudAPI.privateKey)

    UTNcontract = dec64 "J1NzaWduYXR1cmVzDsSnAhcjZXh0c8SWAScba2V5vCEHXflUpTHWBiY8LzghkB4wjglXZjTWGAEj+VVEAThhzgMzc2hhNTEyvEBkZlLFO0UW8oK2iC7GrfO+Ge61ibd/uqkMz2OGH7oDzaobcNIvq1IIhsdlzYCtmme309ZuwDH8Mcxz/IHBP5vyU2NyZWF0ZWRfYXR5WUgdXoU7cHViX2tlecQJAR4IHAEAAcQAAbf++ZrdhYfNVUcCnEVbsc5KNYhHDEEGxCzxMzk1CGP7vtK9ktgLw1FKE+VAhoRfthTerpr+y1HhxV3laCjBOFZ32Wnhrrgb9OnGvG6mp+wQc1CvzNWb4LDcQwa87O9vB5Z7+r897DMHnJrZlESBKDlSr0CUI6SS8eWyXzUB5pdXdA6fV2obyQ82vax5rVII6zPvXSugLOvWKpM/2Xiwt+G8S+jS0B2n2aFZeoGsZF6zO8xhcdEGSXlzXiJwfNivjhWQt5RTDejJkrcn9fzd6frY6VU/IRKHpwLE27qUCbfj2YImKqDEctVsFEqpyyPNljTMYRBa7OnIJskA0gvH6ycjc2lnbsQAAVQPSDiXhamRhzS/Q3R2vca/ad11cuTs5SW6dC1rM/4MSqVrnMQ9mX1iZNpvRvmv8lcflkscdpVEEzeLo2oHYzDE/VrG1OFag5awqUpua6CpSbo2fOi/+n3z9QzyNd4DSLAb1QZOcW/xTerZz1I7bB0jI7pKKnK24alpyAwyRiqCKpk0LMPJ89o+S2yC0bCNfvFIp+WLMPWuf3EN0svUIzM0X4HipVONCnkdv6AdEzaVWzdfcd+oUOv/oNZoIOGdbfW8mhtzUz919LC4j4hcxMR04mhdWZFaEkSBtEzh6CR/U2A0+hF5iNZu1Qal0CdCSZx1raDAo0QdLuxq40lyGfMjdHlwZVN1bmljYXBzdWxlI2RhdGHEzw0fQ3Jldm9raW5nFhdTY29tcG9zaXRlM7xg4QR8z/drr21yeWyeSr7GT6nXKYTxdamtp6JKdXuXaCOZ5jdiLc69EiInowrH3tmPM3WDhevQPuQfEODlaI7QLls+Ru7etM7rjn0N0IkT/JlHDvtrGOInGbsh0CJwTzOtM19fdHlwZTNIYXNoSWQXLbxg2lWl/i/rZ3LwAnDF4lNzBpyzu9P3+iKLVu95EFm52wQ40FgyWOK3C3OeRGmOJvizJDkXNv1qVit2K8a+Yj2HWTZdfouNOcBBgp4NywsrRUYA5RmLuJpyiSllgeOtJVm6PUVDY29udHJhY3QvS2FwaV9sZXZlbBhTZGVmaW5pdGlvbi9bcGVybWlzc2lvbnMfM3ZiNUt5QR8jbmFtZWNjaGFuZ2Vfb3duZXIjcm9sZR+lM0Bvd25lclt0YXJnZXRfbmFtZStvd25lcj1DUm9sZUxpbms9q0NoYW5nZU93bmVyUGVybWlzc2lvbjNhMkRMUDM/pVNzcGxpdF9qb2lutb0XU2ZpZWxkX25hbWUzYW1vdW50S21pbl92YWx1ZaMwLjAwMDAwMDAwMDAwMDAwMDAwMUNtaW5fdW5pdL0ji2pvaW5fbWF0Y2hfZmllbGRzDmNzdGF0ZS5vcmlnaW49m1NwbGl0Sm9pblBlcm1pc3Npb24zdzNDMHNmH6UzcmV2b2tltb0XPYNSZXZva2VQZXJtaXNzaW9uU3JlZmVyZW5jZXMGI2RhdGFHq2NvbnRyYWN0X293bmVyX2VudGl0ebsZVW5pdmVyc2EgQ29ycG9yYXRpb24gTHRkLlNzaG9ydF9uYW1lG1VUTmtFUkMyMF9hZGRyZXNzuyoweDllMzMxOTYzNmUyMTI2ZTNjMGJjOWUzMTM0QUVDNWUxNTA4QTQ2YzczdGlja2VyvTRbZGVzY3JpcHRpb267PDQsOTk3LDg5MSw5NTIgVVROIHdlcmUgY3JlYXRlZCBvbiBKdW5lIDEzdGggMjAxOCBhdCAxMzoxMzoxM6WjVVROIC0gVW5pdmVyc2EgVG9rZW51wzMEVVROIGlzIGRpZ2l0YWxpc2VkIGNvdXBvbiBhbGxvd2luZyB5b3UgdG8gdXRpbGlzZSBhbnkgVW5pdmVyc2EuaW8gdHJhbnNhY3Rpb24gKGkuZS4gdG8gcmVjZWl2ZSBhbnkK4oCcc2VydmljZXPigJ0gaW1wbGllZCBieSB0aGUgcGFydGljdWxhciB0cmFuc2FjdGlvbikgYXQgdGhlIHByaWNlIGF0IHRoZSBVdGlsaXNhdGlvbiBEYXRlLgpUaHVzLCBmcm9tIGxlZ2FsIHByb3NwZWN0aXZlLCB0aGVzZSBUb2tlbnMgYXJlIHlvdXIgcHJvcHJpZXRhcnkgcmlnaHRzIHRvIHJlY2VpdmUgcGFydGljdWxhciB2YWx1ZXMKKFVuaXZlcnNhLmlvIOKAnHNlcnZpY2Vz4oCdKS4gVXRpbGlzYXRpb24g4oCTIFVzZSBvZiBUb2tlbiBmb3IgcGF5aW5nIHRoZSBwYXJ0aWN1bGFyIHRyYW5zYWN0aW9uIHJlbmRlcmVkIGJ5ClVuaXZlcnNhLmlvIHBsYXRmb3JtLiBPd25lcnNoaXAgb2YgVG9rZW5zIGNhcnJpZXMgbm8gcmlnaHRzLCBleHByZXNzIG9yIGltcGxpZWQsIG90aGVyIHRoYW4gaXQgaXMgZGVmaW5lZAppbiBwcmV2aW91cyBzZW50ZW5jZXMuIEluIHBhcnRpY3VsYXIsIHlvdSB1bmRlcnN0YW5kIGFuZCBhY2NlcHQgdGhhdCBUb2tlbnMgZG8gbm90IHJlcHJlc2VudCBvciBjb25mZXIKYW55IG93bmVyc2hpcCByaWdodCBvciBzdGFrZSwgc2hhcmUgb3Igc2VjdXJpdHkgb3IgZXF1aXZhbGVudCByaWdodHMsIG9yIGFueSByaWdodCB0byByZWNlaXZlIGZ1dHVyZQpyZXZlbnVlIHNoYXJlcywgaW50ZWxsZWN0dWFsIHByb3BlcnR5IHJpZ2h0cyBvciBhbnkgb3RoZXIgZm9ybSBvZiBwYXJ0aWNpcGF0aW9uIGluIG9yIHJlbGF0aW5nIHRvIHRoZQpOZXR3b3JrIGFuZC9vciBDb21wYW55IGFuZCBpdHMgY29ycG9yYXRlIGFmZmlsaWF0ZXMsIG90aGVyIHRoYW4gcmlnaHRzIHJlbGF0aW5nIHRvIHRoZSBwcm92aXNpb24gYW5kIHJlY2VpcHQKb2YgU2VydmljZXMgaW4gdGhlIFVuaXZlcnNhIE5ldHdvcmsuIFRoZSBUb2tlbnMgYXJlIG5vdCBpbnRlbmRlZCB0byBiZSBhIGRpZ2l0YWwgY3VycmVuY3ksIHNlY3VyaXR5LApjb21tb2RpdHkgb3IgYW55IG90aGVyIGtpbmQgb2YgZmluYW5jaWFsIGluc3RydW1lbnQuCnNjb250cmFjdF9vd25lcrshVW5pdmVyc2EuaW8gLSBVbml2ZXJzYSBCbG9ja2NoYWluU2NyZWF0ZWRfYXR5HjIJWYUzaXNzdWVyJ6W9PyNrZXlzFhcba2V5FzNwYWNrZWTECQIeCBwBAAHEAAKk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"

    UTNcontract = Universa.Contract.fromBOSS(UTNcontract)

    console.log('UTN amount', UTNcontract.original.getAmount())

    console.log('UTN state', (await UTNcontract.checkOriginal(nodeApi)).itemResult.state)

    order = XChange.Order.createExport({
      type: "UTN-U",
      amount: "1",
      compound: UTNcontract.original.currentBinary
    })

    console.log(order)

  Unitest.addTest 'create utn-u order', ->
    privateKeyBIN = dec64 'JgAcAQABvIEA6SuftXE92bKbHwHUvpZAVrz8FUOxKo48x6yOCNZgIBFXbJ3fzQtZQODNdkHGe3q8SIF2sj8Bpd0MimQ7ofdl8T7rjwu4VNqmtEzKd8EhC57jIv1FBQNtKRv/rjBkBuycmTqBJRyAdMPnEivg1rUDJHPFhj0T4MMdZndI/04FNL28gQDCTWOb5cFzQIU0wqZDb1ZU89CZqy41od955VX8fNuSBTOShT/m2wecn6yJ0nnOU/K09YIA4JZ250u+3U8RS8MnbQeJBeKy8yXogp58j79hIbvZTkN9pwS5lpjCxtg/CCXUYwDXdHQsxaqnMJk9dFrx0lpHdluDoV/zA9hzX4Vliw=='
    utnBIN = dec64 'JyNkYXRhxP4MHxtuZXcGQ3Jldm9raW5nDhczX190eXBlM0hhc2hJZFNjb21wb3NpdGUzvGAP99DEMXudpfJf6G0lVa2oAx/yymkhX836eFDHLLvwlebtTkx6IpWMqNftMnaE8teb2AP5nDeJj8reNou0n1yeVpw8eTOXjF7UHBnF1osJ39g+dn92+6M7NxwOT/6ZSylDY29udHJhY3QvS2FwaV9sZXZlbBg9g1VuaXZlcnNhQ29udHJhY3RTZGVmaW5pdGlvbjcjZGF0YUczdGlja2VyG1VUTnNjb250cmFjdF9vd25lcrshVW5pdmVyc2EuaW8gLSBVbml2ZXJzYSBCbG9ja2NoYWluq2NvbnRyYWN0X293bmVyX2VudGl0ebsZVW5pdmVyc2EgQ29ycG9yYXRpb24gTHRkLiNuYW1lo1VUTiAtIFVuaXZlcnNhIFRva2VuW2Rlc2NyaXB0aW9uuzw0LDk5Nyw4OTEsOTUyIFVUTiB3ZXJlIGNyZWF0ZWQgb24gSnVuZSAxM3RoIDIwMTggYXQgMTM6MTM6MTNTc2hvcnRfbmFtZaV9wzMEVVROIGlzIGRpZ2l0YWxpc2VkIGNvdXBvbiBhbGxvd2luZyB5b3UgdG8gdXRpbGlzZSBhbnkgVW5pdmVyc2EuaW8gdHJhbnNhY3Rpb24gKGkuZS4gdG8gcmVjZWl2ZSBhbnkK4oCcc2VydmljZXPigJ0gaW1wbGllZCBieSB0aGUgcGFydGljdWxhciB0cmFuc2FjdGlvbikgYXQgdGhlIHByaWNlIGF0IHRoZSBVdGlsaXNhdGlvbiBEYXRlLgpUaHVzLCBmcm9tIGxlZ2FsIHByb3NwZWN0aXZlLCB0aGVzZSBUb2tlbnMgYXJlIHlvdXIgcHJvcHJpZXRhcnkgcmlnaHRzIHRvIHJlY2VpdmUgcGFydGljdWxhciB2YWx1ZXMKKFVuaXZlcnNhLmlvIOKAnHNlcnZpY2Vz4oCdKS4gVXRpbGlzYXRpb24g4oCTIFVzZSBvZiBUb2tlbiBmb3IgcGF5aW5nIHRoZSBwYXJ0aWN1bGFyIHRyYW5zYWN0aW9uIHJlbmRlcmVkIGJ5ClVuaXZlcnNhLmlvIHBsYXRmb3JtLiBPd25lcnNoaXAgb2YgVG9rZW5zIGNhcnJpZXMgbm8gcmlnaHRzLCBleHByZXNzIG9yIGltcGxpZWQsIG90aGVyIHRoYW4gaXQgaXMgZGVmaW5lZAppbiBwcmV2aW91cyBzZW50ZW5jZXMuIEluIHBhcnRpY3VsYXIsIHlvdSB1bmRlcnN0YW5kIGFuZCBhY2NlcHQgdGhhdCBUb2tlbnMgZG8gbm90IHJlcHJlc2VudCBvciBjb25mZXIKYW55IG93bmVyc2hpcCByaWdodCBvciBzdGFrZSwgc2hhcmUgb3Igc2VjdXJpdHkgb3IgZXF1aXZhbGVudCByaWdodHMsIG9yIGFueSByaWdodCB0byByZWNlaXZlIGZ1dHVyZQpyZXZlbnVlIHNoYXJlcywgaW50ZWxsZWN0dWFsIHByb3BlcnR5IHJpZ2h0cyBvciBhbnkgb3RoZXIgZm9ybSBvZiBwYXJ0aWNpcGF0aW9uIGluIG9yIHJlbGF0aW5nIHRvIHRoZQpOZXR3b3JrIGFuZC9vciBDb21wYW55IGFuZCBpdHMgY29ycG9yYXRlIGFmZmlsaWF0ZXMsIG90aGVyIHRoYW4gcmlnaHRzIHJlbGF0aW5nIHRvIHRoZSBwcm92aXNpb24gYW5kIHJlY2VpcHQKb2YgU2VydmljZXMgaW4gdGhlIFVuaXZlcnNhIE5ldHdvcmsuIFRoZSBUb2tlbnMgYXJlIG5vdCBpbnRlbmRlZCB0byBiZSBhIGRpZ2l0YWwgY3VycmVuY3ksIHNlY3VyaXR5LApjb21tb2RpdHkgb3IgYW55IG90aGVyIGtpbmQgb2YgZmluYW5jaWFsIGluc3RydW1lbnQuCmtFUkMyMF9hZGRyZXNzuyoweDllMzMxOTYzNmUyMTI2ZTNjMGJjOWUzMTM0QUVDNWUxNTA4QTQ2YzdTcmVmZXJlbmNlcx1bcGVybWlzc2lvbnMfM3ZiNUt5QR+9GWNjaGFuZ2Vfb3duZXIjcm9sZR9bdGFyZ2V0X25hbWUrb3duZXI9Q1JvbGVMaW5rvRkzQG93bmVyPatDaGFuZ2VPd25lclBlcm1pc3Npb24zdzNDMHNmH70ZM3Jldm9rZb0nvSg9g1Jldm9rZVBlcm1pc3Npb24zYTJETFAzP4tqb2luX21hdGNoX2ZpZWxkcw5jc3RhdGUub3JpZ2luS21pbl92YWx1ZaMwLjAwMDAwMDAwMDAwMDAwMDAwMb0nvShDbWluX3Vu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'
    uPackBIN = dec64 'JyNkYXRhxA0DHxtuZXcGQ3Jldm9raW5nHUNjb250cmFjdCdLYXBpX2xldmVsGDNfX3R5cGWDVW5pdmVyc2FDb250cmFjdFNkZWZpbml0aW9uLyNkYXRhF1Npc3N1ZXJOYW1luxdVbml2ZXJzYSBSZXNlcnZlIFN5c3RlbSNuYW1ls3RyYW5zYWN0aW9uIHVuaXRzIHBhY2tTcmVmZXJlbmNlcx1bcGVybWlzc2lvbnMvM045MExqSC+Fo2RlY3JlbWVudF9wZXJtaXNzaW9uS21pbl92YWx1ZQAjcm9sZR9bdGFyZ2V0X25hbWUzaXNzdWVyRUNSb2xlTGlua4U7QGlzc3VlclNmaWVsZF9uYW1li3RyYW5zYWN0aW9uX3VuaXRzRbNDaGFuZ2VOdW1iZXJQZXJtaXNzaW9uM3NEVFlOcy+FvRe9GAC9Gb0avR+zdGVzdF90cmFuc2FjdGlvbl91bml0c0W9ITNlaW9LR3A3hb0XvRgAvRkfvRsrb3duZXJFvR2FM0Bvd25lckNtYXhfc3RlcAq9H70gRb0hM0xKcXpodx+9Gb0aRYNSZXZva2VQZXJtaXNzaW9uhTNyZXZva2UzZnRUOG1iN4W9F70YAL0ZvSe9Kgq9H70kRb0hU2NyZWF0ZWRfYXR5GgNqXYW9HC9LYWRkcmVzc2VzDhdFU0tleUFkZHJlc3NDdWFkZHJlc3O8NRAXzdKDoWpm+j2Lw1TPbko+ja9ZB/G4Mlww7b7zPvNwAuZCPPsFPqJwQtorTOmXTdNtRxNkI2tleXMdRVNTaW1wbGVSb2xlhb0cO2Fub25JZHMdK3N0YXRlV70oL70zDhdFvTa9N7wlECFoJHTOgMrp/dzwbr3HYBO3KZjluJa/8LE2lcNY4uuhl70NJr05HUW9OoW9KL07HTNwYXJlbnQFU2V4cGlyZXNfYXR5GmpubIVlF70gUL0kwBAnlR1LYnJhbmNoX2lkBTNvcmlnaW4FvTF5GgNqXYVTY3JlYXRlZF9ieR+9G70cRb0dhTtjcmVhdG9yQ3JldmlzaW9uCCN0eXBlU3VuaWNhcHN1bGU7dmVyc2lvbhhTc2lnbmF0dXJlcwY='

    privateKey = Universa.PrivateKey.fromBOSS(privateKeyBIN)
    type = "UTN-U"
    compound = utnBIN
    paymentContract = uPackBIN
    amount = "10"

    order = XChange.Order.createExport({ type, amount, compound, paymentContract })

    response = await order.prepare()

    # after order.send this tpack will be registered by API, you can import it as always, and check state
    tpack = order.sign(privateKey)

    response = await order.send()

    @assertEquals response.status, 'OK'


  Unitest.addTest 'get utn-utnp limits', ->
    console.log("RUN")
    response = await XChange.utn.getLimits()
    # response.limits.min, response.limits.max

    @assertEquals response.status, 'OK'

  Unitest.addTest 'create utn-utnp conversion', ->
    privateKeyBIN = dec64 'JgAcAQABvIEA6SuftXE92bKbHwHUvpZAVrz8FUOxKo48x6yOCNZgIBFXbJ3fzQtZQODNdkHGe3q8SIF2sj8Bpd0MimQ7ofdl8T7rjwu4VNqmtEzKd8EhC57jIv1FBQNtKRv/rjBkBuycmTqBJRyAdMPnEivg1rUDJHPFhj0T4MMdZndI/04FNL28gQDCTWOb5cFzQIU0wqZDb1ZU89CZqy41od955VX8fNuSBTOShT/m2wecn6yJ0nnOU/K09YIA4JZ250u+3U8RS8MnbQeJBeKy8yXogp58j79hIbvZTkN9pwS5lpjCxtg/CCXUYwDXdHQsxaqnMJk9dFrx0lpHdluDoV/zA9hzX4Vliw=='
    utnBIN = dec64 'JyNkYXRhxBsOHxtuZXcOFzNfX3R5cGUzSGFzaElkU2NvbXBvc2l0ZTO8YIsinUnDZ+u7TT+awU2DEKWoXPUyqpbkRCcGaeUsFjqAkc50BmUHUgSANm1LXptx60xr2KyO2hZ6CqOYL+HgU7VEmsE/FtWn0GqImm1V5dRgJqd6iF+WMikaro9SEMsA6kNyZXZva2luZw4XLTU9vGBTh3Oh7lfszQS6hlw5fC+uxGuRCsjK5+226/bWxKQCk6F7ahUnpWgP2jBy4pbD19fGDb9eOQ7aERZDGUm/Yg3MZbLw+gAbcp4v05r6BN7/9T0CGgy9+1YOtRBsurpdgNtDY29udHJhY3QvS2FwaV9sZXZlbBgtg1VuaXZlcnNhQ29udHJhY3RTZGVmaW5pdGlvbjcjZGF0YUczdGlja2VyG1VUTnNjb250cmFjdF9vd25lcrshVW5pdmVyc2EuaW8gLSBVbml2ZXJzYSBCbG9ja2NoYWluq2NvbnRyYWN0X293bmVyX2VudGl0ebsZVW5pdmVyc2EgQ29ycG9yYXRpb24gTHRkLiNuYW1lo1VUTiAtIFVuaXZlcnNhIFRva2VuW2Rlc2NyaXB0aW9uuzw0LDk5Nyw4OTEsOTUyIFVUTiB3ZXJlIGNyZWF0ZWQgb24gSnVuZSAxM3RoIDIwMTggYXQgMTM6MTM6MTNTc2hvcnRfbmFtZbWNwzMEVVROIGlzIGRpZ2l0YWxpc2VkIGNvdXBvbiBhbGxvd2luZyB5b3UgdG8gdXRpbGlzZSBhbnkgVW5pdmVyc2EuaW8gdHJhbnNhY3Rpb24gKGkuZS4gdG8gcmVjZWl2ZSBhbnkK4oCcc2VydmljZXPigJ0gaW1wbGllZCBieSB0aGUgcGFydGljdWxhciB0cmFuc2FjdGlvbikgYXQgdGhlIHByaWNlIGF0IHRoZSBVdGlsaXNhdGlvbiBEYXRlLgpUaHVzLCBmcm9tIGxlZ2FsIHByb3NwZWN0aXZlLCB0aGVzZSBUb2tlbnMgYXJlIHlvdXIgcHJvcHJpZXRhcnkgcmlnaHRzIHRvIHJlY2VpdmUgcGFydGljdWxhciB2YWx1ZXMKKFVuaXZlcnNhLmlvIOKAnHNlcnZpY2Vz4oCdKS4gVXRpbGlzYXRpb24g4oCTIFVzZSBvZiBUb2tlbiBmb3IgcGF5aW5nIHRoZSBwYXJ0aWN1bGFyIHRyYW5zYWN0aW9uIHJlbmRlcmVkIGJ5ClVuaXZlcnNhLmlvIHBsYXRmb3JtLiBPd25lcnNoaXAgb2YgVG9rZW5zIGNhcnJpZXMgbm8gcmlnaHRzLCBleHByZXNzIG9yIGltcGxpZWQsIG90aGVyIHRoYW4gaXQgaXMgZGVmaW5lZAppbiBwcmV2aW91cyBzZW50ZW5jZXMuIEluIHBhcnRpY3VsYXIsIHlvdSB1bmRlcnN0YW5kIGFuZCBhY2NlcHQgdGhhdCBUb2tlbnMgZG8gbm90IHJlcHJlc2VudCBvciBjb25mZXIKYW55IG93bmVyc2hpcCByaWdodCBvciBzdGFrZSwgc2hhcmUgb3Igc2VjdXJpdHkgb3IgZXF1aXZhbGVudCByaWdodHMsIG9yIGFueSByaWdodCB0byByZWNlaXZlIGZ1dHVyZQpyZXZlbnVlIHNoYXJlcywgaW50ZWxsZWN0dWFsIHByb3BlcnR5IHJpZ2h0cyBvciBhbnkgb3RoZXIgZm9ybSBvZiBwYXJ0aWNpcGF0aW9uIGluIG9yIHJlbGF0aW5nIHRvIHRoZQpOZXR3b3JrIGFuZC9vciBDb21wYW55IGFuZCBpdHMgY29ycG9yYXRlIGFmZmlsaWF0ZXMsIG90aGVyIHRoYW4gcmlnaHRzIHJlbGF0aW5nIHRvIHRoZSBwcm92aXNpb24gYW5kIHJlY2VpcHQKb2YgU2VydmljZXMgaW4gdGhlIFVuaXZlcnNhIE5ldHdvcmsuIFRoZSBUb2tlbnMgYXJlIG5vdCBpbnRlbmRlZCB0byBiZSBhIGRpZ2l0YWwgY3VycmVuY3ksIHNlY3VyaXR5LApjb21tb2RpdHkgb3IgYW55IG90aGVyIGtpbmQgb2YgZmluYW5jaWFsIGluc3RydW1lbnQuCmtFUkMyMF9hZGRyZXNzuyoweDllMzMxOTYzNmUyMTI2ZTNjMGJjOWUzMTM0QUVDNWUxNTA4QTQ2YzdTcmVmZXJlbmNlcwZbcGVybWlzc2lvbnMfM3ZiNUt5QR+9G2NjaGFuZ2Vfb3duZXIjcm9sZR9bdGFyZ2V0X25hbWUrb3duZXItQ1JvbGVMaW5rvRszQG93bmVyLatDaGFuZ2VPd25lclBlcm1pc3Npb24zdzNDMHNmH70bM3Jldm9rZb0q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'
    uPackBIN = dec64 'JyNkYXRhxAIEHxtuZXcGQ3Jldm9raW5nDhczX190eXBlM0hhc2hJZFNjb21wb3NpdGUzvGBbMtNIooEMY7eHpRFeb74Ah1nXkGCCpHFMIWYSFQu6YfO0yRnTu+VAH08GY6Xil7qn/U/7/EN7ABBwKGQIrVyu0sRb4pMLCuwSRSjPeIRZ4wHITsrqphOg5L5etrLDKG5DY29udHJhY3QvS2FwaV9sZXZlbBg9g1VuaXZlcnNhQ29udHJhY3RTZGVmaW5pdGlvbjcjZGF0YRdTaXNzdWVyTmFtZbsXVW5pdmVyc2EgUmVzZXJ2ZSBTeXN0ZW0jbmFtZbN0cmFuc2FjdGlvbiB1bml0cyBwYWNrU3JlZmVyZW5jZXMdW3Blcm1pc3Npb25zLzNlR2swZjA3raNkZWNyZW1lbnRfcGVybWlzc2lvbkttaW5fdmFsdWUAI3JvbGUfW3RhcmdldF9uYW1lK293bmVyPUNSb2xlTGlua60zQG93bmVyQ21heF9zdGVwClNmaWVsZF9uYW1li3RyYW5zYWN0aW9uX3VuaXRzPbNDaGFuZ2VOdW1iZXJQZXJtaXNzaW9uM2poZjRNSS+tvRy9HQC9Hh+9IDNpc3N1ZXI9vSKtO0Bpc3N1ZXK9Jb0mPb0nM2NXODhLTS+tvRy9HQC9Hr0qvSWzdGVzdF90cmFuc2FjdGlvbl91bml0cz29JzNWNV9HY283rb0cvR0AvR69H70kCr0lvS89vSczbmx3b1h3H70evSo9g1Jldm9rZVBlcm1pc3Npb26tM3Jldm9rZVNjcmVhdGVkX2F0eVtUFVyFvSsvS2FkZHJlc3Nlcw4XPVNLZXlBZGRyZXNzQ3VhZGRyZXNzvDUQF83Sg6FqZvo9i8NUz25KPo2vWQfxuDJcMO2+8z7zcALmQjz7BT6icELaK0zpl03TbUcTZCNrZXlzHT1TU2ltcGxlUm9sZa29Kzthbm9uSWRzHStyb2xlcx0rc3RhdGVfvSEvvTgOFz29O708vCUQIWgkdM6Ayun93PBuvcdgE7cpmOW4lr/wsTaVw1ji66GXvQ0mvT4dPb0/rb0hvUAdM3BhcmVudDVTZXhwaXJlc19hdHlbOxprhY0XvSY4vS/AECe9Fx1LYnJhbmNoX2lkBTNvcmlnaW4XPUVNvGD6ztvHc61cdk7hxLt6/g0uIm0QHCLNusG8lbqVCrabHdycrs6Z6G+5cOmQSfUNGNDGdmlAjByqEf0Nofwu4nsfJd2dqM2ZfwjbL2aq7DjM7/EkdKyFOPhv/h/4kiVenz29NnlaZBVchVNjcmVhdGVkX2J5Hz29P607Y3JlYXRvcr04vUVDcmV2aXNpb24YvUEda3RyYW5zYWN0aW9uYWwFI3R5cGVTdW5pY2Fwc3VsZTt2ZXJzaW9uGFNzaWduYXR1cmVzDsSoAhcjZXh0c8SXAScba2V5vCEHWBUts5VJ4zjuqh1Q2FETGEjr6S4rQd9pEbe7yfrpZpwzc2hhNTEyvECJIZTJafTRKTGWyBFNr6BBekM9yRp6ooKTYfbP/chvTyIOHFrwX4NVboCvR0orI9C21SDqMospO7cgqnS6o50lU2NyZWF0ZWRfYXR5WGQVXIU7cHViX2tlecQKAR4IHAEAAcQBAQCw+YvgZtUE9GL545De/u5LDuesKeAqIKSthY/hF5NyK6XZEneJo1vRiw9IYzXTqC3Wfu2Ytf2n59ysVtDYjQCYnb8QfmdynEWDLAIUE3u3cL9Og0fa1wukcJ2Y5yvbupO37sDN8wWlmCmnA1TnvnXgFmfhKJgeZrT5W7/s8ZpEbJFS79jz6JF7FJ0TP0FPWyhYit/QOVeYdqKLa3CfsoGXI5y8e0VtGLY6FEu0lHO9Mba3LK2pIsDp2HKjweLA7BRiXNiAb6ecuyMz7p+Y7AqgKrL1gLcrfLheDgFmq9Yo45PFx7x98sCcT6CNxgOn7qEZi8HfBFuJOdM1/JTz0zOfI3NpZ27EAAEfafTm6mfPD5ho4iqioukwBYx6jYgrv2bmKboLCVDNjUw0RXH04HdwkJnrKTmBv5jCi/ENLqHI7EVmnfuagT5QI+OJ55Lkm5ghKgFenItSosfXb+uitJvIljq0M0ofS1GuK7NPxcQXRSWYSA0/b2uDvVP6lEUWA0R3GbO5AAkAmn6zlFdtqfHBs2rpRPgwMg1/feNR5VaIEcOIJgqFkuiIOrNy1d10Jw17DUy5Dm85kzlzkSBQf8HGuh1So/XEcpbZwlP0l5+wT+3v77jkX4wHuVSBbOSL2hWv0cDYRrZ0UxspKXOPoD02QBDrTgVQQvX3/H8DfzCIzKPrqdwohSK8'

    type = "UTN-UTNP"
    returnAddress = "0x8A5A90415Fea7f4ECfC2eF37d1873Ca0B239C0aD"
    compound = utnBIN

    privateKey = Universa.PrivateKey.fromBOSS(privateKeyBIN)

    order = XChange.Order.createExport({ type, returnAddress, compound })

    console.log("1")

    response = await order.prepare()

    # if no errors, sign and register

    tpack = order.sign(privateKey)

    # save tpack!!! encode64(tpack.toBOSS)
    # register tpack!
    # Universa.Parcel.create(tpack, UPack, 1, [U_PrivateKey], false, false)

    # after approved registration
    response = await order.send() # {"conversion":{"id":7,"status":"in_progress"},"status":"OK"}
    response = await order.getState() # {"conversion":{"id":7,"status":"in_progress"},"status":"OK"}

    @assertEquals 'OK', 'OK'


  Unitest.addTest 'get products list', ->
    response = await XChange.store.getProducts()
    @assertEquals response.status, 'OK'

  Unitest.addTest 'get conversions list', ->
    response = await XChange.store.getConversions()
    console.log(response)
    @assertEquals response.status, 'OK'

  Unitest.addTest 'make product order', ->
    response = await XChange.store.getProducts()

    console.log("got products")
    console.log(response)

    returnAddress = "0x8A5A90415Fea7f4ECfC2eF37d1873Ca0B239C0aD"
    product = response.products[0]
    productCode = product.productId
    currency = product.prices[0].currency
    privateKey = Universa.PrivateKey.fromBOSS(PACKED_PRIVATE_KEY_2)
    publicKey = privateKey.publicKey

    quantity = 1

    order = XChange.Order.create(publicKey, { productCode, currency, quantity, returnAddress })

    response = await order.send()

    @assertEquals response.status, "OK"
    @assertTruthy order.orderCode

    stateResponse = await order.getState()
    @assertEquals stateResponse.status, "OK"
    @assertEquals stateResponse.orderState.status, "awaits_payment"

    downloaded = await order.download()
    @assertEquals downloaded.status, "error"

  Unitest.addTest 'make conversion order', ->
    response = await XChange.store.getConversions()

    returnAddress = "0x8A5A90415Fea7f4ECfC2eF37d1873Ca0B239C0aD"
    currency = response.hypertokens[0].name
    privateKey = Universa.PrivateKey.fromBOSS(PACKED_PRIVATE_KEY_2)
    publicKey = privateKey.publicKey

    amount = "0.01"
    type = "conversion"

    order = XChange.Order.create(publicKey, { currency, amount, returnAddress, type })

    response = await order.send()

    @assertEquals response.status, "OK"
    console.log(order.orderCode)
    @assertTruthy order.orderCode

    stateResponse = await order.getState()
    @assertEquals stateResponse.status, "OK"
    @assertEquals stateResponse.orderState.status, "awaits_payment"

    downloaded = await order.download()
    @assertEquals downloaded.status, "error"

  Unitest.addTest 'make utnp-utn conversion order', ->
    response = await XChange.utnp.getCommission()

    console.log("AMOUNTS AND COMMISSION", response)

    privateKey = Universa.PrivateKey.fromBOSS(PACKED_PRIVATE_KEY_2)
    publicKey = privateKey.publicKey

    amount = "100"
    type = "UTNP-UTN"

    order = XChange.Order.create(publicKey, { amount, type })

    response = await order.send()

    @assertEquals response.status, "OK"
    console.log(order.orderCode, response)
    @assertTruthy order.orderCode

    state = await order.getState()

    console.log(state)

    @assertEquals state.utnpImport.status, "wait_payment"

    # when state is "ready", here will be utn_contract_base64 key



  Unitest.addTest 'find product order', ->
    productCode = '1'
    privateKey = Universa.PrivateKey.fromBOSS(PACKED_PRIVATE_KEY_2)
    publicKey = privateKey.publicKey

    quantity = 1
    currency = "UTNP"
    returnAddress = "0x8A5A90415Fea7f4ECfC2eF37d1873Ca0B239C0aD"

    order = XChange.Order.create(publicKey, { productCode, currency, quantity, returnAddress })

    stateResponse = await order.send()
    @assertTruthy order.orderCode

    orderCode = order.orderCode
    order.save()

    foundOrder = XChange.Order.find(orderCode)

    @assertEquals foundOrder.productCode, "1"

    ## cloud operations
    APP_TOKEN = "ehUEdnfhDqhBAWK77Rndam0d+L6NVhGDGm/ma3SHHZQA4kgs4uf1AnYJKqKHU2qQZchSeieZyquGOuCHeUtULw=="
    api = await CryptoCloud.connect APP_TOKEN, PACKED_PRIVATE_KEY_2

    itemId = await XChange.Order.ToCloud(order, api);
    console.log(itemId)
    @assert itemId > 0

    order2 = await XChange.Order.FromCloud(itemId, api);
    @assertEquals order2.productCode, "1"

  Unitest.addTest 'check product order (static)', ->
    response = await XChange.Order.getState(EXISTING_PRODUCT_ORDER_CODE, "product")
    console.log(response)
    @assertEquals response.status, 'OK'

  Unitest.addTest 'download product order (static)', ->
    response = await XChange.Order.download(EXISTING_PRODUCT_ORDER_CODE, "product")
    @assertEquals response.status, 'error'

  Unitest.addTest 'check conversion order (static)', ->
    response = await XChange.Order.getState(EXISTING_CONVERSION_ORDER_CODE, "conversion")
    console.log(response)
    @assertEquals response.status, 'OK'

  Unitest.addTest 'download conversion order (static)', ->
    response = await XChange.Order.download(EXISTING_CONVERSION_ORDER_CODE, "conversion")
    console.log(response)
    @assertEquals response.status, 'error'