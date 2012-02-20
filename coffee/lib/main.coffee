jQuery ->
  Backbone.View.prototype.close = ->
    if (@beforeClose)
      @beforeClose()
    @remove()
    @unbind()

  ###
  Usage:
  * add model.name property that will be used as a namespace in the json request
  * put this code before your Backbone app code
  * use toJSON() as usual (so there is no namespacing in your templates)
  * your model's data will be sent under model.name key when calling save()
  ###

  # save reference to Backbone.sync
  Backbone.oldSync = Backbone.sync

  # override original method
  Backbone.sync = (method, model, options) ->
    # save reference to original toJSON()
    model.oldToJSON = model.toJSON

    # override this model instance toJSON() method
    model.toJSON = -> 
      json = {}
      # namespace original json values under model.name key
      json[model.name] = @oldToJSON()
      json
    
    # call original sync method
    syncReturnValue = Backbone.oldSync method, model, options

    # restore original toJSON() on this model instance
    model.toJSON = model.oldToJSON
    delete model.oldToJSON

    # return value returned by original sync
    syncReturnValue

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
