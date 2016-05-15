

$(document).on 'turbolinks:load', ->

  $('#new_mock .ta_ct').select2
    placeholder: 'Select an option'
    multiple: false
    tags: true
    createSearchChoice: (term, data) ->
      if $(data).filter((->
        @text.localeCompare(term) == 0
      )).length == 0
        return {
          id: term
          text: term
        }

