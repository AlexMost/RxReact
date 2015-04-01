React = require 'react'
{div, span, button} = React.DOM


class Component1 extends React.Component
    render: ->
        div null,
            "hello from component1"
            span null,
                "clicks count #{@props.storage.clicksCount}"
            button
                onClick: => @props.eventStream.onNext {action: "click"}
                "Click me"


module.exports = Component1