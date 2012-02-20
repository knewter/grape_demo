console.log 'winemodel'
jQuery ->
  window.Wine = class Wine extends Backbone.Model
    name: 'wine'
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

  window.WineCollection = class WineCollection extends Backbone.Collection
    model: Wine
    url: '/api/v1/wines'
