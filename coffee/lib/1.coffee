jQuery ->
  class ListView extends Backbone.View
    el: $ 'body'
    initialize: ->
      _.bindAll @
      @render()
    render: ->
      $(@el).append '<ul><li>Hello World</li></ul>'

  list_view = new ListView
