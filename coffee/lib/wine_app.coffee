jQuery ->
  class Wine extends Backbone.Model
    urlRoot: '/api/v1/wines'
    defaults:
      "id": null
      "name": ""
      "grapes": ""
      "country": "USA"
      "region": "California"
      "year": ""
      "description": ""
      "picture": ""

  class WineCollection extends Backbone.Collection
    model: Wine
    url: '/api/v1/wines'

  class WineListView extends Backbone.View
    tagname: 'ul'

    initialize: ->
      _.bindAll @
      @model.bind 'reset', @render
      @model.bind 'add', (wine) =>
        $(@el).append new WineListItemView(model: wine).render().el

    render: ->
      _.each @model.models, (wine) =>
        element = new WineListItemView(model: wine).render().el
        $(@el).append(element)
      @

  class WineListItemView extends Backbone.View
    tagName: 'li'

    initialize: ->
      _.bindAll @
      @model.bind 'change', @render
      @model.bind 'destroy', @close

    template: _.template $('#tpl-wine-list-item').html()

    render: ->
      $(@el).html(@template(@model.toJSON()))
      @

    close: ->
      $(@el).unbind()
      $(@el).remove()

  class WineView extends Backbone.View
    initialize: ->
      _.bindAll @
      @model.bind 'change', @render

    template: _.template $('#tpl-wine-details').html()

    render: ->
      $(@el).html @template(@model.toJSON())
      @

    events:
      'change input': 'change'
      'click .save': 'saveWine'
      'click .delete': 'deleteWine'

    change: (event) ->
      target = event.target
      console.log "Changing #{target.id} from #{target.defaultVal}"

    saveWine: ->
      @model.set
        name: $('#name').val()
        grapes: $('#grapes').val()
        country: $('#country').val()
        region: $('#region').val()
        year: $('#year').val()
        description: $('#description').val()
      if @model.isNew()
        app.wineList.create(@model)
      else
        @model.save()
      false
 
    deleteWine: ->
      @model.destroy
        success: ->
            alert 'Wine deleted successfully'
            window.history.back()
      false;

    close: ->
      $(@el).unbind()
      $(@el).remove()

  class HeaderView extends Backbone.View
    template: _.template $('#tpl-header').html()
 
    initialize: ->
      _.bindAll @
      @render()
 
    render: ->
      $(@el).html @template()
      @
 
    events:
      "click .new": "newWine"
 
    newWine: (event) ->
      app.wineView.close() if app.wineView
      app.wineView = new WineView model: new Wine()
      $('#content').html app.wineView.render().el
      false;

  class AppRouter extends Backbone.Router
    initialize: ->
      _.bindAll @

    routes:
      "": "list"
      "wines/:id": "wineDetails"

    list: ->
      @setup()
      $('#sidebar').html @wineListView.render().el

    wineDetails: (id) ->
      @setup()
      @wine = @wineList.get id
      @wineView = new WineView model: @wine
      $('#content').html @wineView.render().el

    setup: ->
      @wineList ||= new WineCollection
      @wineList.fetch()
      @wineListView ||= new WineListView(model: @wineList)


  app = new AppRouter
  Backbone.history.start()
