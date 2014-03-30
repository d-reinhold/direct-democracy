app.Views.Layout = Backbone.View.extend({
  el: "#main",
  template: HandlebarsTemplates['backbone/templates/main'],

  renderHome: function () {
    this.$el.html(Handlebars.compile(this.template()));
    this.home = new app.Views.Home();
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

