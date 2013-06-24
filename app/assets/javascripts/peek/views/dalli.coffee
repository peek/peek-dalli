$(document).on 'peek:render', (event, request_id, data) ->
  $('#peek-dalli-tooltip')
    .attr('title', "Hits: #{data.context.dalli.hits}<br />Misses: #{data.context.dalli.misses}")
    .tipsy
      html: true
      gravity: $.fn.tipsy.autoNS
