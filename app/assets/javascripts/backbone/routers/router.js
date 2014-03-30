app.Router = Backbone.Router.extend({
  routes: {
    "": "index",
    "/": "index",
    "tags": "tags",
    "bills/:id": "viewBill",
    "upcomingBills": "upcomingBills",
    "previousBills": "previousBills",
    "messageRep": "messageRep",
    "messageCitizens": "messageCitizens",
    "poll": "poll"
  },

  index: function() {
    console.log('hit index')
    if (app.currentUserIsRep()) {
      this.poll();
    } else {
      this.upcomingBills();
    }
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

  poll: function() {
    if (app.currentUserIsRep()) {
      this.layout.renderPoll();
    } else {
      app.router.navigate('/', {trigger: true})
    }
  },

  messageCitizens: function() {
    this.layout.renderMessageCitizens();
  },

  messageRep: function() {
    this.layout.renderMessageRep();
  },

  viewBill: function(id) {
    this.layout.renderBill(parseInt(id));
  }
});

