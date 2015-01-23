Rx = require 'rx'
React = require 'react'
HelloView = React.createFactory(require './view')
HelloStorage = require './storage'
dispatchActions = require './dispatcher'


initApp = (mountNode) ->
    subject = new Rx.Subject()
    store = new HelloStorage()
    view = React.render HelloView({eventStream: subject}), mountNode
    dispatchActions(view, subject, store)


module.exports = initApp