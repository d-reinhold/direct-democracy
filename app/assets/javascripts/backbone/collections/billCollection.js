app.Collections.Bill = Backbone.Collection.extend({
    model: app.Models.Bill,
    url: app.env() + 'bills'
});
