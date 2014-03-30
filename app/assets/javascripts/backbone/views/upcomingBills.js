app.Views.UpcomingBills = Backbone.View.extend({
  el: "#content",
  template: HandlebarsTemplates['backbone/templates/upcomingBills'],

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
      username: app.db.citizen.get('name'),
      rep: app.db.citizen.get('rep').name,
      bills: app.db.bills.chain().filter(function(bill) {
        return bill.get('result') === null  &&
               !_.isEmpty(_.intersection(
                 app.db.citizen.get('tags').pluck('name'),
                 bill.get('tags').pluck('name'))
               )
      }).invoke('toJSON').value()
    }
  }

});

