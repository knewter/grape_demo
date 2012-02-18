jQuery ->
  class ListView extends Backbone.View
    el: $ 'body'
    initialize: ->
      _.bindAll @
      @counter = 0
      @render()
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'
    addItem: ->
      @counter++
      $('ul').append "<li>Hello, Coffee#{@counter}</li>"

    events: 'click button': 'addItem'

  list_view = new ListView
