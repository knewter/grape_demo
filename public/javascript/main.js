(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  jQuery(function() {
    var AppRouter;
    Backbone.View.prototype.close = function() {
      if (this.beforeClose) this.beforeClose();
      this.remove();
      return this.unbind();
    };
    /*
      Usage:
      * add model.name property that will be used as a namespace in the json request
      * put this code before your Backbone app code
      * use toJSON() as usual (so there is no namespacing in your templates)
      * your model's data will be sent under model.name key when calling save()
    */
    Backbone.oldSync = Backbone.sync;
    Backbone.sync = function(method, model, options) {
      var syncReturnValue;
      model.oldToJSON = model.toJSON;
      model.toJSON = function() {
        var json;
        json = {};
        json[model.name] = this.oldToJSON();
        return json;
      };
      syncReturnValue = Backbone.oldSync(method, model, options);
      model.toJSON = model.oldToJSON;
      delete model.oldToJSON;
      return syncReturnValue;
    };
    window.AppRouter = AppRouter = (function(_super) {

      __extends(AppRouter, _super);

      function AppRouter() {
        AppRouter.__super__.constructor.apply(this, arguments);
      }

      AppRouter.prototype.initialize = function() {
        _.bindAll(this);
        return $('#header').html(new HeaderView().render().el);
      };

      AppRouter.prototype.routes = {
        "": "list",
        "wines/new": "newWine",
        "wines/:id": "wineDetails"
      };

      AppRouter.prototype.list = function() {
        return this.before();
      };

      AppRouter.prototype.wineDetails = function(id) {
        var _this = this;
        return this.before(function() {
          _this.wine = _this.wineList.get(id);
          return _this.showView('#content', new WineView({
            model: _this.wine
          }));
        });
      };

      AppRouter.prototype.newWine = function() {
        var _this = this;
        return this.before(function() {
          return _this.showView('#content', new WineView({
            model: new Wine
          }));
        });
      };

      AppRouter.prototype.showView = function(selector, view) {
        if (this.currentView) this.currentView.close();
        $(selector).html(view.render().el);
        this.currentView = view;
        return view;
      };

      AppRouter.prototype.before = function(callback) {
        var _this = this;
        if (this.winelist) {
          if (callback) return callback();
        } else {
          this.wineList = new WineCollection;
          return this.wineList.fetch({
            success: function() {
              $('#sidebar').html(new WineListView({
                model: _this.wineList
              }).render().el);
              if (callback) return callback();
            }
          });
        }
      };

      return AppRouter;

    })(Backbone.Router);
    return tpl.loadTemplates(['header', 'wine-details', 'wine-list-item'], function() {
      window.app = new AppRouter();
      return Backbone.history.start();
    });
  });

}).call(this);
