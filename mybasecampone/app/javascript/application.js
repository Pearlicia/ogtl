// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// import "font-awesome";


import "trix"
import "@rails/actiontext"
import "@simonbooth/actiontext";

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