// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require turbolinks
//= require_tree .

// $(document).on('turbolinks:load', function(){
//
// })

// Show Google Map
function initMap() {
  var latitude = parseFloat($("#latitude").html());
  var longitude = parseFloat($("#longitude").html());
  var marker_location = {lat: latitude, lng: longitude};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 18,
    center: marker_location
  });
  var marker = new google.maps.Marker({
    position: marker_location,
    map: map
  });

  
}
