// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "flatpickr-rails"



document.addEventListener('turbo:load', function() {
  flatpickr('.flatpickr', {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
  });
});
