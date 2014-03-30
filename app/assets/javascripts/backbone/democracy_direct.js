//= require_self
//= require_tree ./routers
//= require_tree ./templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./db
//= require_tree .

(function() {
  window.app = {
    Models: {},
    Collections: {},
    Views: {},
    eventSourceListeners: [],
    addEventSourceListener: function(event, callback) {
      app.eventSourceListeners.push({ event: event, callback: callback });
      app.eventSource.addEventListener(event, callback);
    },
    setupEventSource: function() {
      app.eventSource = new EventSource('/bills/events');
      _.each(app.eventSourceListeners, function(eventListener) {
        app.eventSource.addEventListener(eventListener.event, eventListener.callback);
      });
      app.eventSource.addEventListener('error', function() {
        app.eventSource.close();
        _.delay(app.setupEventSource, 1000);
        console.log('new global listener created!')
      }, false);
    },
    initApp: function(){
      $.ajaxSetup({async: false});
//      app.setupEventSource();
//      app.eventSource.addEventListener('keep-alive', function(e) {
//        console.log(arguments)
//      });
      app.db.load();
      app.router = new app.Router();
      Backbone.history.start({ pushState: false, root: '/' });
      Backbone.emulateHTTP = true;
      $(document).foundation();
    },
    env: function() {
      var res = 'http://' + window.location.hostname;
      if (window.location.port) {
        res += ':' + window.location.port;
      }
      return res + '/';
    }
  }
}());