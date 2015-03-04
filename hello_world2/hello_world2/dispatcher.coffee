Rx = require 'rx'
{saveToDb} = require './transport'

getViewState = (store) ->
    clicksCount: store.getClicksCount()
    showSavedMessage: store.getShowSavedMessage()


dispatchActions = (view, eventStream, store) ->
    incrementClickStream = eventStream
        .filter(({action}) -> action is "increment_click_count")
        .do(-> store.incrementClicksCount())
        .share()

    decrementClickStream = eventStream
        .filter(({action}) -> action is "decrement_click_count")
        .do(-> store.decrementClickscount())
        .share()

    countClicksStream = Rx.Observable
        .merge(incrementClickStream, decrementClickStream)

    showSavedMessageStream = countClicksStream
        .throttle(1000)
        .distinct(-> store.getClicksCount())
        .flatMap(-> saveToDb store.getClicksCount())
        .do(-> store.enableSavedMessage())

    hideSavedMessageStream = showSavedMessageStream.delay(2000)
    .do(-> store.disableSavedMessage())

    Rx.Observable.merge(
        countClicksStream
        showSavedMessageStream
        hideSavedMessageStream
        # some more actions here for updating view ...

    ).subscribe(
        -> view.setProps getViewState(store)
        (err) ->
            console.error? err)


module.exports = dispatchActions