import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }


// Initialize Trix or Rich Text editors
document.addEventListener("turbolinks:load", function() {
    var editor = document.querySelector("trix-editor");
    if (editor) {
      editor.addEventListener("trix-file-accept", function(event) {
        var acceptedTypes = ["image/jpeg", "image/png", "image/gif"];
        if (!acceptedTypes.includes(event.file.type)) {
          event.preventDefault();
          alert("Only support attachment of image files");
        }
      });
    }
});