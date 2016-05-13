App.messages = App.messages || {}

class App.messages.index

  constructor: (@options = {}) ->
    @make()

  make: () ->
    new App.messages.index.archiveMessage
    new App.messages.index.archiveAllMessages
    return
