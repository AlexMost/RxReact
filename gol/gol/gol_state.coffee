Immutable = require 'immutable'
Record = Immutable.Record
List = Immutable.List


GolState = Record
    cells: List(List())


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


module.exports = {GolState, calcNewState, addPoint}