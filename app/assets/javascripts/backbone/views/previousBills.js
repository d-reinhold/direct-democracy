app.Views.PreviousBills = Backbone.View.extend({
  el: "#content",
  template: HandlebarsTemplates['backbone/templates/previousBills'],

  initialize: function() {
    this.bills = app.db.bills.filter(function(bill) {
      return bill.get('result') !== null && bill.get('has_polled') &&
        !_.isEmpty(_.intersection(
          app.db.citizen.get('tags').pluck('name'),
          bill.get('tags').pluck('name'))
        )
    })
  },

  events: {
    "click button": 'viewBill'
  },

  viewBill: function(e) {
    app.router.navigate('#/bills/' + $(e.currentTarget)[0].id, {trigger: true});
  },

  render: function () {
    this.$el.html(Handlebars.compile(this.template(this.toJSON())));
    return this;
  },

  toJSON: function () {
    return {
      username: app.currentUser.get('name'),
      rep_name: app.currentUser.get('rep').get('name'),
      bills: _(this.bills).invoke('toJSON')
    }
  }

});

