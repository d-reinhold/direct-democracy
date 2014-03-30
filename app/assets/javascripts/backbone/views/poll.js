app.Views.Poll = Backbone.View.extend({
  el: "#content",
  template: HandlebarsTemplates['backbone/templates/poll'],

  initialize: function() {
    this.bills = app.db.bills.filter(function(bill) {
      return bill.get('result') === null && !bill.get('has_polled')
    });
    this.selectedBill = this.bills[0];
  },

  events: {
    "click button": 'postPoll',
    "change #bill-selector": 'updateSelected'
  },

  updateSelected: function(e) {
    console.log($(e.currentTarget).find(':selected')[0].id)
    this.selectedBill = _(this.bills).findWhere({id: parseInt($(e.currentTarget).find(':selected')[0].id)});
    this.render();
  },

  postPoll: function() {
    var self = this;
    console.log('summary',  self.$el.find('.summary').val())
    self.selectedBill.set({
      has_polled: true,
      summary: self.$el.find('.summary').val()
    });
    self.selectedBill.save();
    this.bills = app.db.bills.filter(function (bill) {
      return bill.get('result') === null && !bill.get('has_polled')
    });
    this.selectedBill = this.bills[0];
    self.render();
  },

  render: function () {
    this.$el.html(Handlebars.compile(this.template(this.toJSON())));
    this.$el.find('#bill-selector option#' + this.selectedBill.id).attr('selected', true);
    return this;
  },

  toJSON: function () {
    return {
      summary: this.selectedBill && this.selectedBill.get('summary'),
      username: app.currentUser.get('name'),
      bills: _(this.bills).invoke('toJSON')
    }
  }
});

