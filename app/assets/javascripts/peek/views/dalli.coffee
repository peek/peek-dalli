$(document).on 'peek:render', (event, requestId, data) ->
  title = []
  title.push("Reads: #{data.context.dalli.reads}")
  title.push("Misses: #{data.context.dalli.misses}")
  title.push("Writes: #{data.context.dalli.writes}")

  $('#peek-dalli-tooltip')
    .attr('title', title.join('<br>'))
    .tipsy
      html: true
      gravity: $.fn.tipsy.autoNS
