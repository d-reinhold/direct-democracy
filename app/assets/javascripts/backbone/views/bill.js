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
    var self = this;
    var data = {
      bill_id: this.bill.id,
      value: $(e.currentTarget).hasClass('yes')
    }
    if (app.currentUserIsRep()) {
      console.log('rep voting!')
      data = _.extend(data, {
        rep_id: app.currentUser.id,
        citizen_id: null
      });
      console.log(data['rep_id'])
    } else {
      data = _.extend(data, {
        citizen_id: app.currentUser.id,
        rep_id: null
      });
    }
    console.log(data)
    var last = app.db.votes.create(data);
    console.log(last)
    this.render();
  },

  render: function () {
    var self = this;
    self.yesVotes = app.db.votes.filter(function(vote) {
      return  vote.get('bill_id') === self.bill.id
              && vote.get('value')
              && vote.get('citizen_id') !== null;
    });
    self.noVotes = app.db.votes.filter(function(vote) {
      return  vote.get('bill_id') === self.bill.id
        && !vote.get('value')
        && vote.get('citizen_id') !== null;
    });
    self.yesVotesCount = self.yesVotes && self.yesVotes.length || 0;
    self.noVotesCount = self.noVotes && self.noVotes.length || 0;
    console.log(self.yesVotesCount, self.noVotesCount)

    self.yesVotesPercent = self.yesVotesCount / (self.yesVotesCount + self.noVotesCount);



    if (app.currentUserIsRep()) {
      self.yourVote = app.db.votes.findWhere({
        rep_id: app.db.citizen.get('rep').id,
        bill_id: self.bill.id
      });
    } else {
      self.yourVote = app.db.votes.findWhere({
        citizen_id: app.db.citizen.id,
        bill_id: self.bill.id
      });
      self.repVote = app.db.votes.findWhere({
        rep_id: app.db.citizen.get('rep').id,
        bill_id: self.bill.id
      });
    }

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
      rep_name: app.db.citizen.get('rep').get('name'),
      summary: this.bill.get('summary'),
      is_rep: app.currentUserIsRep(),
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

