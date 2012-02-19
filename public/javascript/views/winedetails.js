(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  console.log('winedetails');

  jQuery(function() {
    var WineView;
    return window.WineView = WineView = (function(_super) {

      __extends(WineView, _super);

      function WineView() {
        WineView.__super__.constructor.apply(this, arguments);
      }

      WineView.prototype.initialize = function() {
        _.bindAll(this);
        this.template = _.template(tpl.get('wine-details'));
        return this.model.bind('change', this.render);
      };

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
        var _this = this;
        this.model.set({
          name: $('#name').val(),
          grapes: $('#grapes').val(),
          country: $('#country').val(),
          region: $('#region').val(),
          year: $('#year').val(),
          description: $('#description').val()
        });
        if (this.model.isNew()) {
          app.wineList.create(this.model, {
            success: function() {
              return app.navigate("wines/" + _this.model.id, false);
            }
          });
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

      return WineView;

    })(Backbone.View);
  });

}).call(this);
