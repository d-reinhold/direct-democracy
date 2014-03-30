app.Views.Bill = Backbone.View.extend({
  el: "#content",
  template: HandlebarsTemplates['backbone/templates/bill'],

  initialize: function(options) {
    this.bill = options.bill
  },

  render: function () {
    this.$el.html(Handlebars.compile(this.template(this.toJSON())));
    return this;
  },

  toJSON: function () {
    return {
      name: this.bill.get('name')
    }
  }

});

