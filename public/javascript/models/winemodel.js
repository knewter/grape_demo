(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  console.log('winemodel');

  jQuery(function() {
    var Wine, WineCollection;
    window.Wine = Wine = (function(_super) {

      __extends(Wine, _super);

      function Wine() {
        Wine.__super__.constructor.apply(this, arguments);
      }

      Wine.prototype.name = 'wine';

      Wine.prototype.urlRoot = '/api/v1/wines';

      Wine.prototype.defaults = {
        "id": null,
        "name": "",
        "grapes": "",
        "country": "USA",
        "region": "California",
        "year": "",
        "description": "",
        "picture": ""
      };

      return Wine;

    })(Backbone.Model);
    return window.WineCollection = WineCollection = (function(_super) {

      __extends(WineCollection, _super);

      function WineCollection() {
        WineCollection.__super__.constructor.apply(this, arguments);
      }

      WineCollection.prototype.model = Wine;

      WineCollection.prototype.url = '/api/v1/wines';

      return WineCollection;

    })(Backbone.Collection);
  });

}).call(this);
