React = require 'react'
createFactory = React.createFactory
{div, button, table, tbody, tr, td} = React.DOM
PureRenderMixin = require('react/addons').addons.PureRenderMixin
Immutable = require 'immutable'
List = Immutable.List


BlackCellClass = React.createClass
    render: ->
        td {style: {width: "10px", height: "10px", background: "#000"}}


WhiteCellClass = React.createClass
    render: ->
        td 
            style: {width: "10px", height: "10px", background: "#FFF", cursor: "pointer"}
            onClick: @props.onSelect


BlackCell = createFactory(BlackCellClass)
WhiteCell = createFactory(WhiteCellClass)


MainView = React.createClass
    mixins: [PureRenderMixin]

    getDefaultProps: ->
        cells: List(List())

    render: ->
        div null,
            table {style: {border: "1px solid gray"}},
                tbody null,
                    @props.cells.toArray().map((row, i) =>
                        tr {key: i},
                            row.toArray().map((cell, j) =>
                                if cell
                                    BlackCell({key: j})
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

