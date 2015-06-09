Rx = require 'rx'
React = require 'react'
{createFactory} = React
TodoComponent = createFactory(require './views/todo_list')
{TodoStorage} = require './todo_storage'
dispatchActions = require './dispatcher'


initApp = (mountNode) ->
    eventStream = new Rx.Subject()

    state = TodoStorage()

    view = React.render TodoComponent({eventStream}), mountNode
    dispatchActions(view, eventStream, state)

module.exports = initApp

