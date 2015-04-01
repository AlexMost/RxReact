React = require 'react'
Immutable = require('immutable')
Map = Immutable.Map

{init, WrapperView} = require './wrapper_component'
WrapperViewEl = React.createFactory WrapperView

initApp = (node) ->
    app_state = {}
    wrapper_comp = init("wrapper_component")
    view = null

    wrapper_comp.bubbleUpdates()
    .subscribe(
        (data) ->
            console.log ">>>> message >>>>", data
            [comp1, comp2] = data.name

            if comp2
                app_state[comp1][comp2] = data
            else
                app_state[comp1] = data

            React.render(WrapperViewEl(app_state.wrapper_component), node)

        (error) ->
            console.log error
    )



module.exports = initApp