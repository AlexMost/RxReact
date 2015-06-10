Rx = require 'rx'
React = require 'react'
MainView = React.createFactory(require './view')
{GolState} = require './gol_state'
dispatchActions = require './dispatcher'
Immutable = require 'immutable'
List = Immutable.List


initialData = [
    [0, 0, 0, 0, 0]
    [0, 0, 0, 0, 0]
    [0, 1, 1, 1, 0]
    [0, 0, 1, 1, 1]
    [0, 0, 0, 0, 0]
]

getViewState = (state) ->
    cells: state.get("cells")


initApp = (mountNode) ->
    eventStream = new Rx.Subject()

    initialState = GolState(cells: Immutable.fromJS(initialData))

    view = React.render MainView({eventStream}), mountNode

    stateStream = dispatchActions(initialState, eventStream)

    stateStream.subscribe(
        (newState) -> view.setProps getViewState(newState)
        (err) -> throw new Error err.stack)


module.exports = initApp