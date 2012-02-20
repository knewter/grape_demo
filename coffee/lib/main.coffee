jQuery ->
  Backbone.View.prototype.close = ->
    if (@beforeClose)
      @beforeClose()
    @remove()
    @unbind()

  # Extend Backbone.Model to support setting a namespace
  # for models. Example response from server:
  # {
  #   'modelname' : {
  #     ... attributes ...
  #   }
  # We dont want the attributes to be scoped by the model name
  # in the models attributes property. This new parse function
  # will drop the namespace if it is defined on the model.
  # Example:
  #
  # SomeModel = Backbone.Model.extend({
  #   namespace : 'someModel'
  # });
  _.extend Backbone.Model.prototype
    parse: (resp, xhr) ->
      ns = this.namespace
      if(ns)
        return resp[ns]
      resp

  # Extend Backbone.Collection to support setting a namespace
  # for the collection and its models. Example response from server:
  # {
  #   'models' : {[
  #    'model' : {
  #     ... attributes ...
  #   }]}
  #
  # We dont want the attributes to be scoped by the models root
  # This new parse function will drop the namespace
  # if it is defined on the collection. Example:
  #
  # SomeCollection = Backbone.Collection.extend({
  #   namespace : 'myModels'
  # });
  _.extend Backbone.Collection.prototype
    parse: (resp, xhr) ->
      collection = this
      var ns = collection.namespace
      var result = resp
      if(ns)
        result = resp[ns]

      # Not sure how necessary this step is
      return _.map result, (attrs) ->
        model = new collection.model()
        model.set model.parse(attrs)
        model

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
