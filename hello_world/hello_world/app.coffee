Rx = require 'rx'
React = require 'react'
HelloView = React.createFactory(require './view')
HelloStorage = require './storage'
dispatchActions = require './dispatcher'


initApp = (mountNode) ->
    eventStream = new Rx.Subject()
    store = new HelloStorage()
    view = React.render HelloView({eventStream}), mountNode
    dispatchActions(view, eventStream, store)


module.exports = initApp