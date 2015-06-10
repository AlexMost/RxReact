Rx = require 'rx'
{setTodoText, addItem, destroyItem,
checkItem, setCheckAll} = require './todo_state'


dispatch_actions = (subject, initialState) ->
    mainInputKeyDown = subject
        .filter(({action}) -> action is "mainInputKeyDown")

    main_input_enter_key_down = mainInputKeyDown
        .filter(({keyCode}) -> keyCode is 13)

    todoTextChange = subject
        .filter(({action}) -> action is "mainInputTextChange")
        .map(({text}) -> setTodoText(text))

    addItemStream = main_input_enter_key_down
        .filter(({text}) -> text.length > 0)
        .map(({text}) -> addItem(text))

    destroyItemStream = subject
        .filter(({action}) -> action is "itemDestroy")
        .map(({id}) -> destroyItem(id))

    checkItemStream = subject
        .filter(({action}) -> action is "itemCheck")
        .map(({checked, id}) -> checkItem(id, checked))

    checkAll = subject
        .filter(({action}) -> action is "toggleCheckAll")
        .map(({checked}) -> setCheckAll(checked))

    Rx.Observable.merge(
        addItemStream, todoTextChange, destroyItemStream, checkItemStream, checkAll)
    .scan(initialState, (currentState, action) -> action(currentState))


module.exports = dispatch_actions