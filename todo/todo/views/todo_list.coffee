React = require 'react'
PureRenderMixin = require('react/addons').addons.PureRenderMixin
{createFactory} = React
{div, h1, h2, input, header, section, label, ul, li, button, p, a} = React.DOM
TodoItem = createFactory(require './todo_item')
Immutable = require 'immutable'
List = Immutable.List

TodoList = React.createClass
    mixins: [PureRenderMixin]

    getDefaultProps: ->
        todoItems: List()


    mainInputKeyDown: (ev) ->
        @props.eventStream.onNext
            action: "mainInputKeyDown"
            keyCode: ev.keyCode
            text: ev.target.value


    mainInputTextChange: (ev) ->
        @props.eventStream.onNext
            action: "mainInputTextChange"
            text: ev.target.value


    toggleCheckAll: (ev) ->
        @props.eventStream.onNext
            action: "toggleCheckAll"
            checked: ev.target.checked


    render: ->
        div null,
            header {id: "header"},

                h1 null, "todos"

                input
                    id: "new-todo"
                    autoFocus: true
                    value: @props.todoText
                    placeholder: "What needs to be done?"
                    onKeyDown: @mainInputKeyDown
                    onChange: @mainInputTextChange

            section {id: "main"},

                input
                    id: "toggle-all"
                    type: "checkbox"
                    checked: @props.checkAll
                    onChange: @toggleCheckAll

                label
                    htmlFor: "toggle-all"
                    "Mark all as complete"

                ul {id: "todo-list"},
                    @props.todoItems.toArray().map (item) =>
                        TodoItem {
                            key: item.id
                            item
                            eventStream: @props.eventStream
                        }

                button
                    onClick: => @props.eventStream.onNext {action: "history_back"}
                    "Back"


module.exports = TodoList