$(document).on('turbolinks:load', function() {
    var new_mock = $('.new_mock');
    
    if ( new_mock.length > 0 ) {
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

        // enable drag and drop upload if File API is available
        if (window.File && window.FileList && window.FileReader) {
            var fileselect = document.getElementById("mock_fileselect");
            var filedrag = document.getElementById("filedrag");

            // file select
            fileselect.addEventListener("change", fileSelectHandler, false);

            // is XHR2 available?
            var xhr = new XMLHttpRequest();
            if (xhr.upload) {
                // file drop
                filedrag.addEventListener("dragover", fileDragHover, false);
                filedrag.addEventListener("dragleave", fileDragHover, false);
                filedrag.addEventListener("drop", fileSelectHandler, false);
                filedrag.style.display = "inline-block";
                fileselect.style.display = "none";
            }
        }

        function fileSelectHandler(e) {

            // cancel event and hover styling
            fileDragHover(e);

            // fetch FileList object
            var files = e.target.files || e.dataTransfer.files;

            // process all File objects
            for (var i = 0, f; f = files[i]; i++) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $("#mock_body").text(e.target.result);
                };
                reader.readAsText(f);
            }

        }

        function fileDragHover(e) {
            e.stopPropagation();
            e.preventDefault();
            if ( e.type == "dragover" ) {
                $(e.target).addClass("hover");
            } else {
                $(e.target).removeClass("hover");
            }
        }
    }


});