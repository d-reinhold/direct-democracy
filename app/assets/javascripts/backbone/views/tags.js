app.Views.Tags = Backbone.View.extend({
  el: "#content",
  template: HandlebarsTemplates['backbone/templates/tags'],

  events: {
    'click button': 'deleteTag'
  },

  render: function () {
    this.$el.html(Handlebars.compile(this.template(this.toJSON())));
    this.renderTagSearch();
    return this;
  },

  renderTagSearch: function(){
    var self = this;
    self.$el.find("input#tag-search").autocomplete({
      lookup: app.db.tags.pluck('name'),
      onSelect: function( selection ) {
        var tag = app.db.tags.findWhere({name: selection.value});
        app.db.citizen.get('tags').add(tag);
        app.db.citizen.save();
        self.render();
      }
    });
  },

  deleteTag: function(e) {
    var tag = app.db.tags.findWhere({id: parseInt($(e.currentTarget)[0].id.split('-')[1])});
    app.db.citizen.get('tags').remove(tag);

    app.db.citizen.save(null, {success: function(response) {
      console.log(app.db.citizen.get('tags').pluck('name'))
    }});
    this.render();

  },

  toJSON: function () {
    return {
      tags: app.db.citizen.get('tags').invoke('toJSON'),
      rep: app.db.citizen.get('rep').get('name')
    }
  }
});

