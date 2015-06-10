Rx = require 'rx'
React = require 'react'
{createFactory} = React
TodoComponent = createFactory(require './views/todo_list')
{TodoListState} = require './todo_state'
dispatchActions = require './dispatcher'


getViewState = (state) ->
    todoText: state.get("todoText")
    todoItems: state.get("todoItems")

initApp = (mountNode, state, history) ->
    eventStream = new Rx.Subject()
    history or= []

    state or= TodoListState()

    props = getViewState(state)
    props.eventStream = eventStream
    view = React.render TodoComponent(props), mountNode

    stateStream = dispatchActions(eventStream, state).share()

    subscribtion = stateStream.subscribe(
        (state) ->
        	history.push(state)
        	view.setProps getViewState(state)
        (err) -> throw new Error(err.stack))


    history_back = eventStream.filter(({action}) -> action is "history_back")
    .subscribe(
    	->
    		subscribtion.dispose()
    		history_back.dispose()
    		history.pop()
    		initApp(mountNode, history[history.length - 1], history))
    

module.exports = initApp

