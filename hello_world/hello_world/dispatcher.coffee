Rx = require 'rx'


dispatch_actions = (view, subject, store) ->
    incrementClickCountAction = subject
        .filter(({action}) -> action is "increment_click_count")
        .do(-> store.incrementClicksCount())

    Rx.Observable.merge(
        incrementClickCountAction
        # some more actions here for updating view ...

    ).subscribe(
        -> view.setProps store.getViewState()
        (err) ->
            console.error? err)


module.exports = dispatch_actions