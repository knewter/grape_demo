console.log 'header'
jQuery ->
  window.HeaderView = class HeaderView extends Backbone.View
    initialize: ->
      @template = _.template tpl.get('header')
      _.bindAll @
      @render()
 
    render: ->
      $(@el).html @template()
      @
 
    events:
      "click .new": "newWine"
 
    newWine: (event) ->
      app.navigate "wines/new", true
      false
