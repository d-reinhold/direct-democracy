app.Views.Bill = Backbone.View.extend({
  el: "#content",
  template: HandlebarsTemplates['backbone/templates/bill'],

  initialize: function(options) {
    this.bill = options.bill
  },

  events: {
    'click button': 'vote'
  },

  vote: function(e) {
    app.db.votes.create({
      citizen_id: app.db.citizen.id,
      bill_id: this.bill.id,
      value: $(e.currentTarget).hasClass('yes')
    });
    this.render();
  },

  render: function () {
    this.$el.html(Handlebars.compile(this.template(this.toJSON())));
    return this;
  },

  toJSON: function () {
    var self = this,
        vote = app.db.votes.findWhere({
          citizen_id: app.db.citizen.id,
          bill_id: self.bill.id
        });

    return {
      name: this.bill.get('name'),
      summary: this.bill.get('summary'),
      link: this.bill.get('link'),
      voted: !_.isUndefined(vote),
      vote_value: vote && vote.get('value')
    }
  }
});

