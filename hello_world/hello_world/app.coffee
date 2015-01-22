Rx = require 'rx'
React = require 'react'
HelloView = React.createFactory(require './view')
HelloStorage = require './storage'
dispatchActions = require './dispatcher'


initApp = (mountNode) ->
    subject = new Rx.Subject()
    store = new HelloStorage()

    componentProps = store.getViewState()
    componentProps.eventStream = subject

    view = React.render HelloView(componentProps), mountNode

    dispatchActions(view, subject, store)


module.exports = initApp