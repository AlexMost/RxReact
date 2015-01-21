Rx = require 'rx'
React = require 'react'
{createFactory} = React
TodoComponent = createFactory(require './views/todo_list')
TodoStorage = require './todo_storage'
dispatchActions = require './dispatcher'


init_app = ->
    subject = new Rx.Subject()

    store = new TodoStorage()

    initialProps = store.getViewState()
    initialProps.eventStream = subject

    view = React.render(
        TodoComponent(initialProps),
        document.getElementById("todoapp"))

    dispatchActions(view, subject, store)


init_app()

