Rx = require 'rx'

dispatch_actions = (view, subject, store) ->
    mainInputKeyDown = subject
        .filter(({action}) -> action is "mainInputKeyDown")

    main_input_enter_key_down = mainInputKeyDown
        .filter(({keyCode}) -> keyCode is 13)

    addItem = main_input_enter_key_down
        .filter(({text}) -> text.length > 0)
        .do(({text}) ->
            store.addItem text
            store.setTodoText "")

    todoTextChange = subject
        .filter(({action}) -> action is "mainInputTextChange")
        .do(({text}) -> store.setTodoText(text))

    destroyItem = subject
        .filter(({action}) -> action is "itemDestroy")
        .do(({id}) -> store.destroyItem id)

    checkItem = subject
        .filter(({action}) -> action is "itemCheck")
        .do(({checked, id}) -> store.checkItem id, checked)

    checkAll = subject
        .filter(({action}) -> action is "toggleCheckAll")
        .do(({checked}) -> store.setCheckAll checked)

    editItem = subject
        .filter(({action}) -> action is "editItem")
        .do(({id, isEditMode}) -> store.editItem id, isEditMode)

    Rx.Observable.merge(
        addItem
        todoTextChange
        destroyItem
        checkItem
        checkAll
        editItem
    ).subscribe(
        -> view.setProps store.getViewState()
        (err) ->
            console.error? err
    )


module.exports = dispatch_actions