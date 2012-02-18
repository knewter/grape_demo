jQuery ->
  class Item extends Backbone.Model
    defaults:
      part1: 'Hello'
      part2: 'Backbone'

  class List extends Backbone.Collection
    model: Item

  class ItemView extends Backbone.View
    tagName: 'li'
    initialize: ->
      _.bindAll @

      @model.bind 'change', @render
      @model.bind 'remove', @unrender
    render: ->
      $(@el).html """
        <span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>
        <span class='swap'>swap</span>
        <span class='delete'>delete</span>
      """
      @
    unrender: ->
      $(@el).remove()
    swap: ->
      @model.set
        part1: @model.get 'part2'
        part2: @model.get 'part1'
    remove: ->
      @model.destroy()
    events:
      'click .swap': 'swap',
      'click .delete': 'remove'

  class ListView extends Backbone.View
    el: $ 'body'
    initialize: ->
      _.bindAll @

      @collection = new List
      @collection.bind 'add', @appendItem

      @counter = 0
      @render()
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'
    addItem: ->
      @counter++
      item = new Item
      item.set part2: "#{item.get 'part2'} #{@counter}"
      @collection.add item
    appendItem: (item) ->
      item_view = new ItemView model: item
      $('ul').append item_view.render().el


    events: 'click button': 'addItem'

  Backbone.sync = (method, model, success, error) ->
    success()

  list_view = new ListView
