app.Router = Backbone.Router.extend({
  routes: {
    "": "upcomingBills",
    "tags": "tags",
    "bills/:id": "viewBill",
    "upcomingBills": "upcomingBills",
    "previousBills": "previousBills"
  },

  initialize: function() {
    this.layout = new app.Views.Layout();
  },

  upcomingBills: function() {
    this.layout.renderUpcomingBills();
  },

  previousBills: function() {
    this.layout.renderPreviousBills();
  },

  tags: function() {
    this.layout.renderTags();
  },

  viewBill: function(id) {
    this.layout.renderBill(parseInt(id));
  }
});

