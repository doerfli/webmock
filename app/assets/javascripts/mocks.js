$(document).on('turbolinks:load', function() {
    $('#new_mock .ta_ct').select2({
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

    console.log("loading channel");
    App.mockChannel = App.cable.subscriptions.create({channel: "MockChannel", id: "123"},
        {
            received: function(data) {
                console.log(data);
                App.mockChannel.send({ sent_by: "bla1", body: "This is a cool chat app." })
            }
        });
    setTimeout(function() {
        App.mockChannel.send({ sent_by: "Paul", body: "This is a cool chat app." })
    }, 2000);

});