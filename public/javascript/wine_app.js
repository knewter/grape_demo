(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  jQuery(function() {
    var AppRouter, Wine, WineCollection, WineListItemView, WineListView, WineView, app;
    Wine = (function(_super) {

      __extends(Wine, _super);

      function Wine() {
        Wine.__super__.constructor.apply(this, arguments);
      }

      return Wine;

    })(Backbone.Model);
    WineCollection = (function(_super) {

      __extends(WineCollection, _super);

      function WineCollection() {
        WineCollection.__super__.constructor.apply(this, arguments);
      }

      WineCollection.prototype.model = Wine;

      WineCollection.prototype.url = '/api/v1/wines';

      return WineCollection;

    })(Backbone.Collection);
    WineListView = (function(_super) {

      __extends(WineListView, _super);

      function WineListView() {
        WineListView.__super__.constructor.apply(this, arguments);
      }

      WineListView.prototype.tagname = 'ul';

      WineListView.prototype.initialize = function() {
        _.bindAll(this);
        return this.model.bind('reset', this.render);
      };

      WineListView.prototype.render = function() {
        var _this = this;
        _.each(this.model.models, function(wine) {
          var element;
          element = new WineListItemView({
            model: wine
          }).render().el;
          return $(_this.el).append(element);
        });
        return this;
      };

      return WineListView;

    })(Backbone.View);
    WineListItemView = (function(_super) {

      __extends(WineListItemView, _super);

      function WineListItemView() {
        WineListItemView.__super__.constructor.apply(this, arguments);
      }

      WineListItemView.prototype.tagName = 'li';

      WineListItemView.prototype.initialize = function() {
        return _.bindAll(this);
      };

      WineListItemView.prototype.template = _.template($('#tpl-wine-list-item').html());

      WineListItemView.prototype.render = function() {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
      };

      return WineListItemView;

    })(Backbone.View);
    WineView = (function(_super) {

      __extends(WineView, _super);

      function WineView() {
        WineView.__super__.constructor.apply(this, arguments);
      }

      WineView.prototype.initialize = function() {
        return _.bindAll(this);
      };

      WineView.prototype.template = _.template($('#tpl-wine-details').html());

      WineView.prototype.render = function() {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
      };

      return WineView;

    })(Backbone.View);
    AppRouter = (function(_super) {

      __extends(AppRouter, _super);

      function AppRouter() {
        AppRouter.__super__.constructor.apply(this, arguments);
      }

      AppRouter.prototype.initialize = function() {
        return _.bindAll(this);
      };

      AppRouter.prototype.routes = {
        "": "list",
        "wines/:id": "wineDetails"
      };

      AppRouter.prototype.list = function() {
        this.wineList = new WineCollection;
        this.wineListView = new WineListView({
          model: this.wineList
        });
        this.wineList.fetch();
        return $('#sidebar').html(this.wineListView.render().el);
      };

      AppRouter.prototype.wineDetails = function(id) {
        window.wineList = this.wineList;
        this.wine = this.wineList.get(id);
        this.wineView = new WineView({
          model: this.wine
        });
        return $('#content').html(this.wineView.render().el);
      };

      return AppRouter;

    })(Backbone.Router);
    app = new AppRouter;
    return Backbone.history.start();
  });

}).call(this);
