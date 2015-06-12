Immutable = require 'immutable'
Record = Immutable.Record
List = Immutable.List

STATUS = {PLAY: 0, STOP: 1}

GolState = Record
    cells: List(List())
    status: STATUS.PLAY
    saves: List()


LIVE = 1
DEAD = 0


findNeighbors = ([y, x], matrix) ->
    [[y-1, x-1], [y, x-1], [y+1, x-1], [y-1, x],
     [y+1, x], [y-1, x+1], [y, x+1], [y+1, x+1]]
    .filter(([y, x]) -> y >= 0 and x >= 0) # immutable js returns last element instead of undefined if negative index
    .map(([y, x]) -> matrix.get(y)?.get(x))
    .filter((value) -> value?)


calcNewState = (state) ->
    currentCells = state.get("cells")
    currentCells.forEach((row, rowNum) ->
        row.forEach((cell, cellNum) ->
            neighbors = findNeighbors([rowNum, cellNum], currentCells)
            live_count = neighbors.filter((n) -> n is LIVE).length
            dead_count = neighbors.length - live_count

            cell_value = if cell is LIVE
                if live_count < 2 or live_count > 3
                    DEAD
                else
                    LIVE
            else    # dead
                if live_count is 3
                    LIVE
                else
                    DEAD
            state = state.setIn(["cells", rowNum, cellNum], cell_value)
        )
    )
    state


addPoint = ([y, x]) -> (state) -> state.setIn(["cells", y, x], LIVE)


delPoint = ([y, x]) -> (state) -> state.setIn(["cells", y, x], DEAD)


addRow = (state) ->
    currentCells = state.get("cells")
    rowLength = currentCells.get(0).size
    new_row = List((DEAD for i in [0..rowLength]))
    state.set("cells", currentCells.push(new_row))


addCol = (state) ->
    currentCells = state.get("cells")
    newCells = currentCells.map((row) ->
        row.push(DEAD))
    state.set("cells", newCells)


addCols = (n) -> (state) ->
    [0..n].reduce(((s, i) -> addCol(s)), state)


addRows = (n) -> (state) ->
    [0..n].reduce(((s, i) -> addRow(s)), state)


stop = (state) -> state.set("status", STATUS.STOP)


play = (state) -> state.set("status", STATUS.PLAY)


saveSate = (state) ->
    console.log JSON.stringify(state.get("cells").toJS())
    state.set("saves", state.get("saves").push(state.get("cells")))


module.exports = {
    GolState, calcNewState, addPoint,
    addRow, addCol, addCols, addRows, STATUS,
    stop, play, delPoint, saveSate
}