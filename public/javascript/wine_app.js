(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  jQuery(function() {
    var AppRouter, HeaderView, Wine, WineCollection, WineListItemView, WineListView, WineView, app;
    Wine = (function(_super) {

      __extends(Wine, _super);

      function Wine() {
        Wine.__super__.constructor.apply(this, arguments);
      }

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
        var _this = this;
        _.bindAll(this);
        this.model.bind('reset', this.render);
        return this.model.bind('add', function(wine) {
          return $(_this.el).append(new WineListItemView({
            model: wine
          }).render().el);
        });
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
        _.bindAll(this);
        this.model.bind('change', this.render);
        return this.model.bind('destroy', this.close);
      };

      WineListItemView.prototype.template = _.template($('#tpl-wine-list-item').html());

      WineListItemView.prototype.render = function() {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
      };

      WineListItemView.prototype.close = function() {
        $(this.el).unbind();
        return $(this.el).remove();
      };

      return WineListItemView;

    })(Backbone.View);
    WineView = (function(_super) {

      __extends(WineView, _super);

      function WineView() {
        WineView.__super__.constructor.apply(this, arguments);
      }

      WineView.prototype.initialize = function() {
        _.bindAll(this);
        return this.model.bind('change', this.render);
      };

      WineView.prototype.template = _.template($('#tpl-wine-details').html());

      WineView.prototype.render = function() {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
      };

      WineView.prototype.events = {
        'change input': 'change',
        'click .save': 'saveWine',
        'click .delete': 'deleteWine'
      };

      WineView.prototype.change = function(event) {
        var target;
        target = event.target;
        return console.log("Changing " + target.id + " from " + target.defaultVal);
      };

      WineView.prototype.saveWine = function() {
        this.model.set({
          name: $('#name').val(),
          grapes: $('#grapes').val(),
          country: $('#country').val(),
          region: $('#region').val(),
          year: $('#year').val(),
          description: $('#description').val()
        });
        if (this.model.isNew()) {
          app.wineList.create(this.model);
        } else {
          this.model.save();
        }
        return false;
      };

      WineView.prototype.deleteWine = function() {
        this.model.destroy({
          success: function() {
            alert('Wine deleted successfully');
            return window.history.back();
          }
        });
        return false;
      };

      WineView.prototype.close = function() {
        $(this.el).unbind();
        return $(this.el).remove();
      };

      return WineView;

    })(Backbone.View);
    HeaderView = (function(_super) {

      __extends(HeaderView, _super);

      function HeaderView() {
        HeaderView.__super__.constructor.apply(this, arguments);
      }

      HeaderView.prototype.template = _.template($('#tpl-header').html());

      HeaderView.prototype.initialize = function() {
        _.bindAll(this);
        return this.render();
      };

      HeaderView.prototype.render = function() {
        $(this.el).html(this.template());
        return this;
      };

      HeaderView.prototype.events = {
        "click .new": "newWine"
      };

      HeaderView.prototype.newWine = function(event) {
        if (app.wineView) app.wineView.close();
        app.wineView = new WineView({
          model: new Wine()
        });
        $('#content').html(app.wineView.render().el);
        return false;
      };

      return HeaderView;

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
        this.setup();
        return $('#sidebar').html(this.wineListView.render().el);
      };

      AppRouter.prototype.wineDetails = function(id) {
        this.setup();
        this.wine = this.wineList.get(id);
        this.wineView = new WineView({
          model: this.wine
        });
        return $('#content').html(this.wineView.render().el);
      };

      AppRouter.prototype.setup = function() {
        this.wineList || (this.wineList = new WineCollection);
        this.wineList.fetch();
        return this.wineListView || (this.wineListView = new WineListView({
          model: this.wineList
        }));
      };

      return AppRouter;

    })(Backbone.Router);
    app = new AppRouter;
    return Backbone.history.start();
  });

}).call(this);
