React = require 'react'
Immutable = require 'immutable'
Map = Immutable.Map
Rx = require 'rx'

{div} = React.DOM
Component1View = React.createFactory(require('../component1/view'))
Component1Bl = require('../component1/bl')

WrapperStore = Immutable.Record {
    name: "wrapper component"
}


class WrapperView extends React.Component
    render: ->
        console.log @props
        storage = @props.storage
        div null,
            div null, storage.name
            "Components wrapper"
            Component1View(@props.component1)


init = (name) ->
    self_name = name
    eventStream = new Rx.Subject

    storage = new WrapperStore

    component1 = Component1Bl("component1")

    observeUpdates = -> [
        Rx.Observable.return({storage})]

    getComponents = -> [component1]

    bubbleUpdates = ->
        selfUpdates = Rx.Observable
        .merge(observeUpdates())
        .map(({storage}) -> {
            name: [self_name],
            storage,
            eventStream,
            component1: {
                storage: component1.getStorage()
                eventStream: component1.getEventStream()
                }
            })

        _components_updates = []
        for comp in getComponents()
            _components_updates = _components_updates.concat(
                comp.bubbleUpdates())

        console.log _components_updates

        comp_updates = Rx.Observable.merge(_components_updates)
        .map((data) ->
            console.log "!!!", data
            new_name = [name].concat data.name
            data.name = new_name
            data
        )

        Rx.Observable.merge(selfUpdates, comp_updates)

    observeUpdates: observeUpdates

    getComponents: getComponents

    bubbleUpdates: bubbleUpdates

    getEventStream: -> eventStream

    getStorage: -> storage

    getName: -> name



module.exports = {init, WrapperView}