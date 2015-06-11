Rx = require 'rx'
{calcNewState, addPoint} = require './gol_state'


dispatchActions = (initialState, eventStream) ->    
    gameLoopStream = Rx.Observable.interval(500).map(-> calcNewState)

    addPointStream = eventStream.filter(({action}) -> action is "add_point")
    .map(({point}) -> addPoint(point))

    Rx.Observable.merge(gameLoopStream, addPointStream)
    .scan(initialState, (state, action) -> action(state))


module.exports = dispatchActions