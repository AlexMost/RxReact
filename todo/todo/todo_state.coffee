Immutable = require 'immutable'
Record = Immutable.Record
List = Immutable.List


TodoListState = Record
    todoItems: List()
    todoText: ""
    doneItems: 0
    checkAll: false


TodoItemState = Record
    text: ""
    id: ""
    complete: false


# String -> TodoState -> TodoState
setTodoText = (text) -> (state) ->
    state.set("todoText", text)


# String -> TodoState -> TodoState
addItem = (text) -> (state) ->
    currentItems = state.get("todoItems")

    newItem = TodoItemState
        text: text
        id: text
        complete: false

    state.set("todoItems", currentItems.unshift(newItem))
         .set("todoText", "")


# String -> TodoState -> TodoState
destroyItem = (id) -> (state) ->
    currentItems = state.get("todoItems")
    state.set("todoItems", currentItems.filter((i) -> i.id != id))


# (String, String) -> TodoState -> TodoState
checkItem = (id, checked) -> (state) ->
    currentItems = state.get("todoItems")
    state.set("todoItems", currentItems.map(
        (i) ->
            if i.id == id
                i.set("complete", checked)
            else
                i
        ))  

# Boolean -> TodoState -> TodoState
setCheckAll = (checkAll) -> (state) ->
    currentItems = state.get("todoItems")
    state.set("todoItems",
        currentItems.map((i) -> i.set("complete", checkAll)))


module.exports = {
    TodoListState
    setTodoText
    addItem
    destroyItem
    checkItem
    setCheckAll
}
