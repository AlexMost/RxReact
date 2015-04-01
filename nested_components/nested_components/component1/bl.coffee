Immutable = require 'immutable'
Rx = require 'rx'
Record = Immutable.Record

Storage = Record {clicksCount: 0}
incClick = (storage) ->
    storage.set("clicksCount", storage.get("clicksCount") + 1)


init_component = (name) ->
    eventStream = new Rx.Subject

    storage = new Storage

    clicksStream = eventStream
        .filter(({action}) -> action is "click")
        .map(->
            storage = incClick(storage)
            {storage})

    observeUpdates = -> [
        Rx.Observable.return({storage})
        clicksStream
    ]

    getComponents = -> []

    bubbleUpdates = ->
        selfUpdates = Rx.Observable
        .merge(observeUpdates())
        .map(({storage}) -> {name: [name], storage, eventStream})

    observeUpdates: observeUpdates

    bubbleUpdates: bubbleUpdates

    getEventStream: -> eventStream

    getStorage: -> storage

    getName: -> name


module.exports = init_component
