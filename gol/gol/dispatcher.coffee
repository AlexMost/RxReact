Rx = require 'rx'
{calcNewState} = require './gol_state'


dispatchActions = (initialState, eventStream) ->    
    gameLoopStream = Rx.Observable.interval(100).map(-> calcNewState)
    Rx.Observable.merge(gameLoopStream)
    .scan(initialState, (state, action) -> action(state))


module.exports = dispatchActions