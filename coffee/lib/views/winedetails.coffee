console.log 'winedetails'
jQuery ->
  window.WineView = class WineView extends Backbone.View
    initialize: ->
      _.bindAll @
      @template = _.template tpl.get('wine-details')
      @model.bind 'change', @render


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
        app.wineList.create @model, success: =>
          app.navigate "wines/#{@model.id}", false
      else
        @model.save()
      false
 
    deleteWine: ->
      @model.destroy
        success: ->
            alert 'Wine deleted successfully'
            window.history.back()
      false
