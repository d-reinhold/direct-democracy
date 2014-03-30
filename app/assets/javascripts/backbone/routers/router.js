app.Router = Backbone.Router.extend({
  routes: {
    "": "index",
    "tags": "tags",
    "bills/:id": "viewBill"
  },

  initialize: function() {
    this.layout = new app.Views.Layout();
  },

  index: function() {
    this.layout.renderHome();
  },

  tags: function() {
    this.layout.renderTags();
  },

  viewBill: function(id) {
    this.layout.renderBill(parseInt(id));
  }
});

