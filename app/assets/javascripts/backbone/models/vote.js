app.Models.Vote = Backbone.Model.extend({
  url: function() { return app.env() + "votes/"}
});
