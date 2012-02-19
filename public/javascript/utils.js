(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  jQuery(function() {
    var TemplateUtil;
    TemplateUtil = (function() {

      function TemplateUtil() {
        this.get = __bind(this.get, this);
        this.loadTemplates = __bind(this.loadTemplates, this);
      }

      TemplateUtil.prototype.templates = {};

      TemplateUtil.prototype.initialize = function() {
        return _.bindAll(this);
      };

      TemplateUtil.prototype.loadTemplates = function(names, callback) {
        var loadTemplate,
          _this = this;
        console.log('loadTemplates');
        loadTemplate = function(index) {
          var name;
          name = names[index];
          console.log('Loading template: ' + name);
          return $.get('/tpl/' + name + '.html', function(data) {
            _this.templates[name] = data;
            index++;
            if (index < names.length) {
              return loadTemplate(index);
            } else {
              if (callback) return callback();
            }
          });
        };
        return loadTemplate(0);
      };

      TemplateUtil.prototype.get = function(name) {
        return this.templates[name];
      };

      return TemplateUtil;

    })();
    return window.tpl = new TemplateUtil;
  });

}).call(this);
