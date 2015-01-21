class TodoStorage
    constructor: ->
        @todoItems = []
        @todoText = ""
        @doneItems = 0
        @checkAll = false

    setTodoText: (@todoText) ->

    addItem: (text) ->
        @todoItems.unshift
            text: text
            id: @todoItems.length
            complete: false

    destroyItem: (id) ->
        @todoItems = @todoItems.filter (i) -> i.id != id

    checkItem: (id, isChecked) ->
        @todoItems = @todoItems.map (i) ->
            if i.id is id
                i.complete = isChecked
            i

    setCheckAll: (@checkAll) ->
        @todoItems = @todoItems.map (i) =>
            i.complete = @checkAll
            i

    editItem: (id, isEditMode) ->
        @todoItems = @todoItems.map (i) ->
            if i.id is id
                i.isEditMode = isEditMode
            else
                i.isEditMode = ! isEditMode
            i

    getViewState: ->
        {
            @todoItems
            @todoText
            @checkAll
        }


module.exports = TodoStorage
