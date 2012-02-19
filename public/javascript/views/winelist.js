(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  console.log('winelist');

  jQuery(function() {
    var WineListItemView, WineListView;
    window.WineListView = WineListView = (function(_super) {

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
          console.log('adding');
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
    return window.WineListItemView = WineListItemView = (function(_super) {

      __extends(WineListItemView, _super);

      function WineListItemView() {
        WineListItemView.__super__.constructor.apply(this, arguments);
      }

      WineListItemView.prototype.tagName = 'li';

      WineListItemView.prototype.initialize = function() {
        _.bindAll(this);
        this.template = _.template(tpl.get('wine-list-item'));
        this.model.bind('change', this.render);
        return this.model.bind('destroy', this.close);
      };

      WineListItemView.prototype.render = function() {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
      };

      return WineListItemView;

    })(Backbone.View);
  });

}).call(this);
