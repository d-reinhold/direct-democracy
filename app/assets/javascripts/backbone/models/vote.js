app.Models.Vote = Backbone.Model.extend({
  url: function() { return app.env() + "votes/"},

  initialize: function() {
//    this.setUpEventListener();
  },

  toJSON: function() {
    return {
      name:  this.get('name'),
      tag_names: this.get('tags').pluck('name').join(' and '),
      id: this.get('id')
    }
  },

  parse: function(data) {
    data['tags'] = new Backbone.Collection(_.map(data.tags, function(tag) {
      return {id: tag.id, name: tag.name }
    }));
    return data;
  }
});
