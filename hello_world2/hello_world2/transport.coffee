Rx = require 'rx'

# Mock for some async operation
saveToDb = (value) ->
    Rx.Observable.create (observer) ->
        setTimeout(
            ->
                observer.onNext value
                observer.onCompleted()
            2000
        )

module.exports = {saveToDb}
