Rx = require 'rx'
React = require 'react'
{createFactory} = React
TodoComponent = createFactory(require './views/todo_list')
TodoStorage = require './todo_storage'
dispatchActions = require './dispatcher'


initApp = (mountNode) ->
    subject = new Rx.Subject()

    store = new TodoStorage()

    componentProps = store.getViewState()
    componentProps.eventStream = subject
    view = React.render TodoComponent(componentProps), mountNode
    dispatchActions(view, subject, store)

module.exports = initApp

