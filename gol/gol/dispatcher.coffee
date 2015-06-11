Rx = require 'rx'
{calcNewState, addPoint, addRow, addCol} = require './gol_state'


dispatchActions = (initialState, eventStream) ->    
    gameLoopStream = Rx.Observable.interval(50).map(-> calcNewState)

    addRowStream = eventStream.filter(({action}) -> action is "add_row")
    .map(-> addRow)

    addColStream = eventStream.filter(({action}) -> action is "add_col")
    .map(-> addCol)

    mouseDown = eventStream.filter(({action}) -> action is "on_cell_mouse_down")
    mouseMove = eventStream.filter(({action}) -> action is "on_hover")
    mouseUp = eventStream.filter(({action}) -> action is "on_cell_mouse_up")

    addPointOnCellClick = eventStream.filter(({action}) -> action is "add_point")

    addPointsOnHover = mouseDown.flatMap(
        mouseMove.distinctUntilChanged().takeUntil(mouseUp))

    addPointStream = Rx.Observable
    .merge(addPointOnCellClick)
    .map(({point}) -> addPoint(point))

    Rx.Observable.merge(
        gameLoopStream, addPointStream, addRowStream, addColStream)
    .scan(initialState, (state, action) -> action(state))
    .startWith(initialState)


module.exports = dispatchActions