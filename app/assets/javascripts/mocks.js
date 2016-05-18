$(document).on('turbolinks:load', function() {
    return $('#new_mock .ta_ct').select2({
        placeholder: 'Select an option',
        multiple: false,
        tags: true,
        createSearchChoice: function(term, data) {
            if ($(data).filter((function() {
                    return this.text.localeCompare(term) === 0;
                })).length === 0) {
                return {
                    id: term,
                    text: term
                };
            }
        }
    });
});