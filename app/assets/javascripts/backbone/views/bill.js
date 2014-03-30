app.Views.Bill = Backbone.View.extend({
  el: "#content",
  template: HandlebarsTemplates['backbone/templates/bill'],

  initialize: function (options) {
    this.bill = options.bill
  },

  events: {
    'click button': 'vote'
  },

  vote: function (e) {
    app.db.votes.create({
      citizen_id: app.db.citizen.id,
      bill_id: this.bill.id,
      value: $(e.currentTarget).hasClass('yes')
    });
    this.render();
  },

  render: function () {
    var self = this;
    self.yesVotes = app.db.votes.where({
      bill_id: self.bill.id,
      value: true
    });
    self.noVotes = app.db.votes.where({
      bill_id: self.bill.id,
      value: false
    });
    self.yesVotesCount = self.yesVotes && self.yesVotes.length || 0;
    self.noVotesCount = self.noVotes && self.noVotes.length || 0;
    self.yesVotesPercent = self.yesVotesCount / (self.yesVotesCount + self.noVotesCount);

    self.yourVote = app.db.votes.findWhere({
      citizen_id: app.db.citizen.id,
      bill_id: self.bill.id
    });
    self.repVote = app.db.votes.findWhere({
      rep_id: app.db.citizen.get('rep').id,
      bill_id: self.bill.id
    });
    self.$el.html(Handlebars.compile(self.template(self.toJSON())));
    if (!_.isUndefined(self.yourVote)) {
      new Chart(self.$el.find("#votes-chart")[0].getContext("2d")).Pie([
        {value: self.yesVotesCount, color: '#008CBA'},
        {value: self.noVotesCount, color: '#F04124'}
      ], {
        animationEasing: 'linear',
        animationSteps: 20
      });
    }
    return this;
  },

  toJSON: function () {
    return {
      name: this.bill.get('name'),
      rep_name: app.db.citizen.get('rep').name,
      summary: this.bill.get('summary'),
      link: this.bill.get('link'),
      you_voted: !_.isUndefined(this.yourVote),
      rep_voted: !_.isUndefined(this.repVote),
      your_vote_value: this.yourVote && this.yourVote.get('value'),
      rep_vote_value: this.repVote && this.repVote.get('value'),
      voted_yes: Math.round(this.yesVotesPercent * 100).toString(),
      voted_no: Math.round((1 - this.yesVotesPercent) * 100).toString()
    }
  }
});

