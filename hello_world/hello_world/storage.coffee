class HelloStorage
    constructor: ->
        @clicksCount = 0

    getClicksCount: -> @clicksCount

    incrementClicksCount: ->
        @clicksCount += 1

module.exports = HelloStorage