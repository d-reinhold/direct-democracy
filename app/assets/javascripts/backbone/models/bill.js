app.Models.Bill = Backbone.Model.extend({
//  url: function() { return app.env() + "bills/"},

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

//  setUpEventListener: function() {
//    console.log('setting up listener for ', this.id);
//    var self = this;
//    app.addEventSourceListener('project_week.update.' + self.id, function(e) {
//      var data = JSON.parse(e.data);
//      var oldAllocations = self.get('allocations');
//      var oldPersonIds = oldAllocations.pluck('person_id');
//      var addedPersonIds = _.difference(data.allocations, oldPersonIds);
//      var removedPersonIds = _.difference(oldPersonIds, data.allocations);
//
//      _.each(addedPersonIds, function(personId) {
//        self.get('allocations').add({person_id: personId});
//      });
//
//      _.each(removedPersonIds, function(personId) {
//        oldAllocations.remove(oldAllocations.findWhere({person_id: personId}));
//      });
//
//      self.set('dev_target', data.dev_target);
//      self.set('pm_target', data.pm_target);
//      self.set('design_target', data.design_target);
//    });
//  }
});
