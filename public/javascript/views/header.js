(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  console.log('header');

  jQuery(function() {
    var HeaderView;
    return window.HeaderView = HeaderView = (function(_super) {

      __extends(HeaderView, _super);

      function HeaderView() {
        HeaderView.__super__.constructor.apply(this, arguments);
      }

      HeaderView.prototype.initialize = function() {
        this.template = _.template(tpl.get('header'));
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
        app.navigate("wines/new", true);
        return false;
      };

      return HeaderView;

    })(Backbone.View);
  });

}).call(this);
