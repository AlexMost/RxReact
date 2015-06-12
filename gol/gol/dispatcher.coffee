Rx = require 'rx'
{calcNewState, addPoint, addRow, addCol, play, stop, delPoint, saveSate} = require './gol_state'


dispatchActions = (initialState, eventStream) ->    
    pauser = new Rx.Subject

    playStream = eventStream.filter(({action}) -> action is "play")
    .map(-> play)
    .do(-> pauser.onNext(true))

    stopStream = eventStream.filter(({action}) -> action is "stop")
    .map(-> stop)
    .do(-> pauser.onNext(false))

    gameLoopStream = Rx.Observable.interval(50).pausable(pauser).map(-> calcNewState)

    addRowStream = eventStream.filter(({action}) -> action is "add_row")
    .map(-> addRow)

    addColStream = eventStream.filter(({action}) -> action is "add_col")
    .map(-> addCol)

    mouseDown = eventStream.filter(({action}) -> action is "on_cell_mouse_down")
    mouseMove = eventStream.filter(({action}) -> action is "on_hover")
    mouseUp = eventStream.filter(({action}) -> action is "on_cell_mouse_up")

    addPointStream = eventStream.filter(({action}) -> action is "add_point")
    .map(({point}) -> addPoint(point))

    delPointStream = eventStream.filter(({action}) -> action is "del_point")
    .map(({point}) -> delPoint(point))

    saveState = eventStream.filter(({action}) -> action is "save")
    .map(-> saveSate)

    Rx.Observable.merge(
        gameLoopStream, addPointStream, addRowStream,
        addColStream, playStream, stopStream, delPointStream,
        saveState)
    .scan(initialState, (state, action) -> action(state))
    .startWith(initialState)


module.exports = dispatchActions