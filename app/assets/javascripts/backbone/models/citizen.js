app.Models.Citizen = Backbone.Model.extend({
  url: function() { return app.env() + "citizens/1" },

  toJSON: function() {
    return {
      tag_ids: this.get('tags').pluck('id')
    }
  },

  parse: function(data) {
    data['tags'] = new Backbone.Collection(_.map(data.tags, function(tag) {
      return {id: tag.id, name: tag.name }
    }));
    return data;
  }
});
