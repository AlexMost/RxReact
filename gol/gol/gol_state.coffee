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
    .map(([y, x]) -> matrix[y]?[x])
    .filter((value) -> value?)


calcNewState = (state) ->
    currentCells = state.get("cells")
    newCells = currentCells.map((row, rowNum) ->
        row.map((cell, cellNum) ->
            neighbors = findNeighbors([rowNum, cellNum], currentCells.toJS())
            live_count = neighbors.filter((n) -> n is LIVE).length
            dead_count = neighbors.length - live_count

            if cell is LIVE
                if live_count < 2 or live_count > 3
                    DEAD
                else
                    LIVE
            else    # dead
                if live_count is 3 then LIVE else DEAD
        )
    )

    state.set("cells", newCells)


module.exports = {GolState, calcNewState}