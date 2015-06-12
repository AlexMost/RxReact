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
            onClick: @props.onSelect


WhiteCellClass = React.createClass
    render: ->
        td 
            className: "dead"
            onClick: @props.onSelect
            


BlackCell = createFactory(BlackCellClass)
WhiteCell = createFactory(WhiteCellClass)


MainView = React.createClass
    mixins: [PureRenderMixin]

    getDefaultProps: ->
        cells: List(List())

    render: ->
        div null,
            if @props.isPlay
                button
                    onClick: => @props.eventStream.onNext
                        action: "stop"
                    "stop"
            else
                button
                    onClick: => @props.eventStream.onNext
                        action: "play"
                        
                    "play"

            button
                onClick: => @props.eventStream.onNext {action: "save"}
                "dump"

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
                                        onSelect: => @props.eventStream.onNext {
                                                action: "del_point"
                                                point: [i, j]
                                            } 
                                else
                                    WhiteCell
                                        key: j
                                        onSelect: => @props.eventStream.onNext {
                                                action: "add_point"
                                                point: [i, j]
                                            } 
                            )
                    )


module.exports = MainView

