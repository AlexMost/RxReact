class HelloStorage
    constructor: ->
        @clicksCount = 0
        @showSavedMessage = false

    getClicksCount: -> @clicksCount

    incrementClicksCount: ->
        @clicksCount += 1

    decrementClickscount: ->
        @clicksCount -= 1

    getShowSavedMessage: -> @showSavedMessage

    enableSavedMessage: ->
        @showSavedMessage = true

    disableSavedMessage: ->
        @showSavedMessage = false


module.exports = HelloStorage