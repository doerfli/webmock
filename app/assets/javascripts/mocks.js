$(document).on('turbolinks:load', function() {
    var new_mock = $('#new_mock');

    if ( new_mock != null ) {
        new_mock.find('.ta_ct').select2({
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

        if (window.File && window.FileList && window.FileReader) {
            var fileselect = document.getElementById("fileselect");
            var filedrag = document.getElementById("filedrag");

            // file select
            fileselect.addEventListener("change", FileSelectHandler, false);

            // is XHR2 available?
            var xhr = new XMLHttpRequest();
            if (xhr.upload) {

                // file drop
                filedrag.addEventListener("dragover", FileDragHover, false);
                filedrag.addEventListener("dragleave", FileDragHover, false);
                filedrag.addEventListener("drop", FileSelectHandler, false);
                filedrag.style.display = "block";
                fileselect.style.display = "none";
            }
        }

        function FileSelectHandler(e) {

            // cancel event and hover styling
            FileDragHover(e);

            // fetch FileList object
            var files = e.target.files || e.dataTransfer.files;

            // process all File objects
            for (var i = 0, f; f = files[i]; i++) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    // Output(
                    //     "<p><strong>" + file.name + ":</strong></p><pre>" +
                    //     e.target.result.replace(/</g, "&lt;").replace(/>/g, "&gt;") +
                    //     "</pre>"
                    // );
                    $("#mock_body").text(e.target.result);
                }
                reader.readAsText(f);
            }

        }

        function FileDragHover(e) {
            e.stopPropagation();
            e.preventDefault();
            e.target.className = (e.type == "dragover" ? "hover" : "");
        }
    }


});