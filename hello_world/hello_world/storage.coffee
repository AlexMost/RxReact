class HelloStorage
    constructor: ->
        @clicksCount = 0

    incrementClicksCount: ->
        @clicksCount += 1

    getViewState: ->
        {@clicksCount}

module.exports = HelloStorage