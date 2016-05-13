App.messages.index = App.messages.index || {}

class App.messages.index.archiveAllMessages

  constructor: (@options = {}) ->
    @make()
    @bind()

  make: () ->
    @elementId = '#js-archive-all-messages-btn'
    @$element = $(@elementId)

  bind: () ->
    @$element.on 'click', (event) =>
      @table = $('#messages-tb')
      event.preventDefault()
      $.ajax({
        url: @$element.attr('href'),
        type: 'post'
      }).always( =>
        @table.empty()
      )
