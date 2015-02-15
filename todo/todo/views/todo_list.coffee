React = require 'react'
{createFactory} = React
{div, h1, h2, input, header, section, label, ul, li, button, p, a} = React.DOM
TodoItem = createFactory(require './todo_item')


TodoList = React.createClass
    getDefaultProps: ->
        todoItems: []


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
                    @props.todoItems.map (item) =>
                        TodoItem {
                            item
                            eventStream: @props.eventStream
                        }


module.exports = TodoList