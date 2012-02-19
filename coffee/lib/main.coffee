console.log 'main'
jQuery ->
  Backbone.View.prototype.close = ->
    if (@beforeClose)
      @beforeClose()
    @remove()
    @unbind()

  window.AppRouter = class AppRouter extends Backbone.Router
    initialize: ->
      _.bindAll @
      $('#header').html new HeaderView().render().el

    routes:
      "": "list"
      "wines/new": "newWine"
      "wines/:id": "wineDetails"

    list: ->
      @before()

    wineDetails: (id) ->
      @before =>
        @wine = @wineList.get id
        @showView '#content', new WineView(model: @wine)

    newWine: ->
      @before =>
        @showView '#content', new WineView(model: new Wine)

    
    showView: (selector, view) ->
      if @currentView
        @currentView.close()
      $(selector).html view.render().el
      @currentView = view
      view

    before: (callback) ->
      if @winelist
        if callback
          callback()
      else
        @wineList = new WineCollection
        @wineList.fetch success: =>
          $('#sidebar').html new WineListView(model: @wineList).render().el
          if callback
            callback()

  tpl.loadTemplates ['header', 'wine-details', 'wine-list-item'], ->
    window.app = new AppRouter()
    Backbone.history.start()
