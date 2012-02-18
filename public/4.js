// **This example illustrates how to delegate the rendering of a Model to a dedicated View.**
//
// _Working example: [4.html](../4.html)._  
// _[Go to Example 5](5.html)_

//
(function($){
  var Item = Backbone.Model.extend({
    defaults: {
      part1: 'hello',
      part2: 'world'
    }
  });
  
  var List = Backbone.Collection.extend({
    model: Item
  });

  // **ItemView class**: Responsible for rendering each individual `Item`.
  var ItemView = Backbone.View.extend({
    tagName: 'li', // name of (orphan) root tag in this.el
    initialize: function(){
      _.bindAll(this, 'render'); // every function that uses 'this' as the current object should be in here
    },
    render: function(){
      $(this.el).html('<span>'+this.model.get('part1')+' '+this.model.get('part2')+'</span>');
      return this; // for chainable calls, like .render().el
    }
  });
  
  var ListView = Backbone.View.extend({
    el: $('body'), // el attaches to existing element
    events: {
      'click button#add': 'addItem'
    },
    initialize: function(){
      _.bindAll(this, 'render', 'addItem', 'appendItem'); // every function that uses 'this' as the current object should be in here
      
      this.collection = new List();
      this.collection.bind('add', this.appendItem); // collection event binder

      this.counter = 0;
      this.render();
    },
    render: function(){
      var self = this;
      $(this.el).append("<button id='add'>Add list item</button>");
      $(this.el).append("<ul></ul>");
      _(this.collection.models).each(function(item){ // in case collection is not empty
        self.appendItem(item);
      }, this);
    },
    addItem: function(){
      this.counter++;
      var item = new Item();
      item.set({
        part2: item.get('part2') + this.counter // modify item defaults
      });
      this.collection.add(item);
    },
    // `appendItem()` is no longer responsible for rendering an individual `Item`. This is now delegated to the `render()` method of each `ItemView` instance.
    appendItem: function(item){
      var itemView = new ItemView({
        model: item
      });
      $('ul', this.el).append(itemView.render().el);
    }
  });

  var listView = new ListView();      
})(jQuery);
