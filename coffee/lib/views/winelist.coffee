console.log 'winelist'
jQuery ->
  window.WineListView = class WineListView extends Backbone.View
    tagname: 'ul'

    initialize: ->
      _.bindAll @
      @model.bind 'reset', @render
      @model.bind 'add', (wine) =>
        console.log 'adding'
        $(@el).append new WineListItemView(model: wine).render().el

    render: ->
      _.each @model.models, (wine) =>
        element = new WineListItemView(model: wine).render().el
        $(@el).append(element)
      @

  window.WineListItemView = class WineListItemView extends Backbone.View
    tagName: 'li'

    initialize: ->
      _.bindAll @
      @template = _.template tpl.get('wine-list-item')
      @model.bind 'change', @render
      @model.bind 'destroy', @close

    render: ->
      $(@el).html(@template(@model.toJSON()))
      @
