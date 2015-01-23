Rx = require 'rx'
{saveToDb} = require './transport'

getViewState = (store) ->
    clicksCount: store.getClicksCount()
    showSavedMessage: store.getShowSavedMessage()


dispatchActions = (view, subject, store) ->
    incrementClickCountSource = subject
        .filter(({action}) -> action is "increment_click_count")
        .do(-> store.incrementClicksCount())
        .share()

    decrementClickCountSource = subject
        .filter(({action}) -> action is "decrement_click_count")
        .do(-> store.decrementClickscount())
        .share()

    countClicks = Rx.Observable
        .merge(incrementClickCountSource, decrementClickCountSource)

    showSavedMessageSource = countClicks
        .throttle(1000)
        .distinct(-> store.getClicksCount())
        .flatMap(-> saveToDb store.getClicksCount())
        .do(-> store.enableSavedMessage())

    hideSavedMessage = showSavedMessageSource.delay(2000)
    .do(-> store.disableSavedMessage())

    Rx.Observable.merge(
        countClicks
        showSavedMessageSource
        hideSavedMessage
        # some more actions here for updating view ...

    ).subscribe(
        -> view.setProps getViewState(store)
        (err) ->
            console.error? err)


module.exports = dispatchActions