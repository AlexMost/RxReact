React = require 'react'
{div, button} = React.DOM


HelloView = React.createClass

    incrementClickCount: ->
        @props.eventStream.onNext
            action: "increment_click_count"

    render: ->
        div null,
            div null, "You clicked #{@props.clicksCount} times"
            button
                onClick: @incrementClickCount
                "Click"


module.exports = HelloView

