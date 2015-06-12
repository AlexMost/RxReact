Rx = require 'rx'
React = require 'react'
MainView = React.createFactory(require './view')
{GolState, addCols, addRows, STATUS} = require './gol_state'
dispatchActions = require './dispatcher'
Immutable = require 'immutable'
List = Immutable.List

initialData = require './initial_data'

getViewState = (state) ->
    cells: state.get("cells")
    isPlay: state.get("status") == STATUS.PLAY


initApp = (mountNode) ->
    eventStream = new Rx.Subject()

    initialState = GolState(cells: Immutable.fromJS(initialData))

    view = React.render MainView({eventStream}), mountNode

    stateStream = dispatchActions(initialState, eventStream)

    stateStream.subscribe(
        (newState) -> view.setProps getViewState(newState)
        (err) -> throw new Error err.stack)

    eventStream.onNext {action: "play"}


module.exports = initApp