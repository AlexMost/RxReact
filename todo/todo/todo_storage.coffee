Immutable = require 'immutable'
Record = Immutable.Record
List = Immutable.List

TodoStorage = Record
    todoItems: List()
    todoText: ""
    doneItems: 0
    checkAll: false
    eventStream: null


TodoItem = Record
    text: ""
    id: ""
    complete: false


# String -> TodoState
setTodoText = (text) -> (state) ->
    state.set("todoText", text)


# String -> TodoState
addItem = (text) -> (state) ->
    currentItems = state.get("todoItems")

    newItem = TodoItem
        text: text
        id: text
        complete: false

    state.set("todoItems", currentItems.unshift(newItem))
         .set("todoText", "")


# String -> TodoState
destroyItem = (id) -> (state) ->
    currentItems = state.get("todoItems")
    state.set("todoItems", currentItems.filter((i) -> i.id != id))


# (String, String) -> TodoState
checkItem = (id, checked) -> (state) ->
    currentItems = state.get("todoItems")
    state.set("todoItems", currentItems.map(
        (i) ->
            if i.id == id
                i.set("complete", checked)
            else
                i
        ))  

# Boolean -> TodoState
setCheckAll = (checkAll) -> (state) ->
    currentItems = state.get("todoItems")
    state.set("todoItems",
        currentItems.map((i) -> i.set("complete", checkAll)))


module.exports = {
    TodoStorage
    setTodoText
    addItem
    destroyItem
    checkItem
    setCheckAll
}
