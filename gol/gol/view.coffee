React = require 'react'
createFactory = React.createFactory
{div, button, table, tbody, tr, td} = React.DOM
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'
List = Immutable.List


BlackCellClass = React.createClass
    render: ->
        td 
            className: "live"
            onMouseUp: @props.onMouseUp


WhiteCellClass = React.createClass
    render: ->
        td 
            className: "dead"
            onClick: @props.onSelect
            onMouseOver: @props.onHover
            onMouseDown: @props.onMouseDown
            onMouseUp: @props.onMouseUp


BlackCell = createFactory(BlackCellClass)
WhiteCell = createFactory(WhiteCellClass)


MainView = React.createClass
    mixins: [PureRenderMixin]

    getDefaultProps: ->
        cells: List(List())

    render: ->
        div null,

            button
                onClick: => @props.eventStream.onNext
                    action: "add_row"

                "stop"

            button
                onClick: => @props.eventStream.onNext
                    action: "add_col"
                    
                "addCol"
            table
                style: {border: "1px solid gray"}
                cellPadding: 0
                cellSpacing: 0
                tbody null,
                    @props.cells.toArray().map((row, i) =>
                        tr {key: i},
                            row.toArray().map((cell, j) =>
                                if cell
                                    BlackCell
                                        key: j
                                        onMouseUp: => @props.eventStream.onNext {
                                                action: "on_cell_mouse_up"
                                                point: [i, j]
                                            }
                                else
                                    WhiteCell
                                        key: j
                                        onSelect: => @props.eventStream.onNext {
                                                action: "add_point"
                                                point: [i, j]
                                            } 
                                        onHover: => @props.eventStream.onNext {
                                                action: "on_hover"
                                                point: [i, j]
                                            }

                                        onMouseDown: => @props.eventStream.onNext {
                                                action: "on_cell_mouse_down"
                                                point: [i, j]
                                            }
                                        onMouseUp: => @props.eventStream.onNext {
                                                action: "on_cell_mouse_up"
                                                point: [i, j]
                                            }
                            )
                    )


module.exports = MainView

