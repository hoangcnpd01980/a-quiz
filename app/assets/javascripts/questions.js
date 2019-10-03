$(document).on('turbolinks:load', function() {
  (function() {
    App.questions = App.cable.subscriptions.create({
      channel: 'QuestionsChannel'
    },
    {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        $('#question-data').load(window.location + " #question-data");
        $('#notification-center').load(window.location+ " #notification-center");
      },
    });
  }).call(this);
})
