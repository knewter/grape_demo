jQuery ->
  class Wine extends Backbone.Model

  class WineCollection extends Backbone.Collection
    model: Wine
    url: '/api/v1/wines'

  class WineListView extends Backbone.View
    tagname: 'ul'

    initialize: ->
      _.bindAll @
      @model.bind 'reset', @render

    render: ->
      _.each @model.models, (wine) =>
        element = new WineListItemView(model: wine).render().el
        $(@el).append(element)
      @

  class WineListItemView extends Backbone.View
    tagName: 'li'

    initialize: ->
      _.bindAll @

    template: _.template $('#tpl-wine-list-item').html()

    render: ->
      $(@el).html(@template(@model.toJSON()))
      @

  class WineView extends Backbone.View
    initialize: ->
      _.bindAll @

    template: _.template $('#tpl-wine-details').html()

    render: ->
      $(@el).html @template(@model.toJSON())
      @

  class AppRouter extends Backbone.Router
    initialize: ->
      _.bindAll @

    routes:
      "": "list"
      "wines/:id": "wineDetails"

    list: ->
      @wineList = new WineCollection
      @wineListView = new WineListView(model: @wineList)
      @wineList.fetch()
      $('#sidebar').html @wineListView.render().el

    wineDetails: (id) ->
      window.wineList = @wineList
      @wine = @wineList.get id
      @wineView = new WineView model: @wine
      $('#content').html @wineView.render().el

  app = new AppRouter
  Backbone.history.start()
