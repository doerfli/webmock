content_types = new Bloodhound(
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('ct')
  queryTokenizer: Bloodhound.tokenizers.whitespace
  local: [
    { ct: 'application/json' }
    { ct: 'application/xml' }
    { ct: 'application/x-www-form-urlencoded' }
    { ct: 'multipart/form-data' }
    { ct: 'text/html' }
    { ct: 'text/xml' }
    { ct: 'text/css' }
    { ct: 'text/csv' }
    { ct: 'text/plain' }
  ])
# initialize the bloodhound suggestion engine
content_types.initialize()


$(document).on 'turbolinks:load', ->
  $('#new_mock .ta_ct').typeahead null,
    displayKey: 'ct'
    source: content_types.ttAdapter()
