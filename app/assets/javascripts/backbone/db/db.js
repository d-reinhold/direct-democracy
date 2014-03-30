app.db = {
  tags: new app.Collections.Tag(),
  bills: new app.Collections.Bill(),
  votes: new app.Collections.Vote(),
  citizen : new app.Models.Citizen,
  rep : new app.Models.Rep,

  load: function() {
    app.db.tags.fetch();
    app.db.bills.fetch();
    app.db.votes.fetch();
    app.db.citizen.fetch();
    app.db.rep.fetch();
  }
};

