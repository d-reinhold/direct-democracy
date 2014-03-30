app.Views.Layout = Backbone.View.extend({
  el: "#main",
  template: HandlebarsTemplates['backbone/templates/layout'],

  render: function() {
    this.$el.html(Handlebars.compile(this.template(this.toJSON())));
    return this;
  },

  renderUpcomingBills: function () {
    this.render();
    new app.Views.UpcomingBills().render();
    return this;
  },

  renderPreviousBills: function () {
    this.render();
    new app.Views.PreviousBills().render();
    return this;
  },

  renderPoll: function () {
    this.render();
    new app.Views.Poll().render();
    return this;
  },

  renderMessageCitizen: function () {
    this.render();
    new app.Views.MessageCitizen().render();
    return this;
  },

  renderMessageRep: function () {
    this.render();
    new app.Views.MessageRep().render();
    return this;
  },

  renderTags: function () {
    this.render();
    new app.Views.Tags().render();
    return this;
  },

  renderBill: function (id) {
    this.render();
    new app.Views.Bill({
      bill: app.db.bills.findWhere({id: id})
    }).render();
    return this;
  },

  toJSON: function() {
    return {
      currentUserIsRep: app.currentUserIsRep()
    }
  }
});

