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
        td {style: {width: "10px", height: "10px", background: "#FFF"}}    


BlackCell = createFactory(BlackCellClass)
WhiteCell = createFactory(WhiteCellClass)


MainView = React.createClass
    mixins: [PureRenderMixin]

    getDefaultProps: ->
        cells: List(List())

    render: ->
        div null,
            table null,
                tbody null,
                    @props.cells.toArray().map((row, i) ->
                        tr {key: i},
                            row.toArray().map((cell, j) ->
                                cell and BlackCell({key: j}) or WhiteCell({key: j})
                            )
                    )


module.exports = MainView

