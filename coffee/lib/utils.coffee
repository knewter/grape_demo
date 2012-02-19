jQuery ->
  class TemplateUtil
    templates: {}

    initialize: ->
      _.bindAll @

    # Recursively pre-load all the templates for the app.
    # This implementation should be changed in a production environment. All the template files should be
    # concatenated in a single file.
    loadTemplates: (names, callback) =>
      # Hash of preloaded templates for the app
      console.log 'loadTemplates'
      loadTemplate = (index) =>
        name = names[index]
        console.log 'Loading template: ' + name
        $.get '/tpl/' + name + '.html', (data) =>
          @templates[name] = data
          index++
          if index < names.length
            loadTemplate index
          else
            if callback
              callback()

      loadTemplate(0)

    # Get template by name from hash of preloaded templates
    get: (name) =>
      @templates[name]

  window.tpl = new TemplateUtil
