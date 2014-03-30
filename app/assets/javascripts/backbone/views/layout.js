app.Views.Layout = Backbone.View.extend({
  el: "#main",
  template: HandlebarsTemplates['backbone/templates/main'],

  renderUpcomingBills: function () {
    this.$el.html(Handlebars.compile(this.template()));
    this.home = new app.Views.UpcomingBills();
    this.home.render();
    return this;
  },

  renderPreviousBills: function () {
    this.$el.html(Handlebars.compile(this.template()));
    this.home = new app.Views.PreviousBills();
    this.home.render();
    return this;
  },

  renderTags: function () {
    this.$el.html(Handlebars.compile(this.template()));
    this.tags = new app.Views.Tags();
    this.tags.render();
    return this;
  },

  renderBill: function (id) {
    this.$el.html(Handlebars.compile(this.template()));
    this.bill = new app.Views.Bill({
      bill: app.db.bills.findWhere({id: id})
    });
    this.bill.render();
    return this;
  }
});

