React = require 'react'
{div, button, h1, p} = React.DOM


HelloView = React.createClass
    getDefaultProps: ->
        clicksCount: 0

    incrementClickCount: ->
        @props.eventStream.onNext
            action: "increment_click_count"

    decrementClickCount: ->
        @props.eventStream.onNext
            action: "decrement_click_count"

    render: ->
        div null,
            div null, "Hello"

            if @props.showSavedMessage
                p {style: {color: "red"}}, "Count saved"

            div null, "You clicked #{@props.clicksCount} times"
            button
                onClick: @incrementClickCount
                "Click +1"

            button
                onClick: @decrementClickCount
                "Click -1"


module.exports = HelloView

