React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
{div, h1, input, header, section, label, ul, li, button, p} = React.DOM


TodoItem = React.createClass
    mixins: [PureRenderMixin]

    destroy: ->
        @props.eventStream.onNext
            action: "itemDestroy"
            id: @props.item.id

    check: (ev) ->
        @props.eventStream.onNext
            action: "itemCheck"
            checked: ev.target.checked
            id: @props.item.id

    edit: ->
        @props.eventStream.onNext
            action: "editItem"
            id: @props.item.id
            isEditMode: true

    render: ->
        li
            key: @props.item.id
            className: (
                @props.item.complete and "completed" or
                @props.item.isEditMode and "editing")

            div className:"view",

                input
                    className: "toggle"
                    type: "checkbox"
                    checked: @props.item.complete
                    onChange: @check

                label
                    onDoubleClick: @edit
                    @props.item.text

                button
                    className: "destroy"
                    onClick: @destroy

            if @props.item.isEditMode
                input
                    className: "edit"
                    value: @props.item.text

module.exports = TodoItem