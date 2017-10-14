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
function showMap() {
  var latitude = parseFloat($("#latitude").html());
  var longitude = parseFloat($("#longitude").html());
  var marker_location = {lat: latitude, lng: longitude};
  var map = new google.maps.Map(document.getElementById('show-map'), {
    zoom: 18,
    center: marker_location
  });
  var marker = new google.maps.Marker({
    position: marker_location,
    map: map
  });

}

// Set GoogleMap
function initMap() {

  map = new google.maps.Map(document.getElementById('map-new'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 18
  });
  infoWindow = new google.maps.InfoWindow;

  // If location is on, set this to be initial position of map
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      infoWindow.setPosition(pos);
      infoWindow.setContent(`<div class='text-center'>Latitude: ${pos.lat} <br> Longitude: ${pos.lng}</div>`);
      marker = new google.maps.Marker({
        position: pos,
        map: map
      });
      marker.setPosition(pos);
      infoWindow.open(map, marker);
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  }  else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
  }

  // On click on map, change lat/lng input based on map marker
  map.addListener('click', function(e) {
    placeMarkerAndPanTo(e.latLng, map);
    latLng = e.latLng
    geocoding  = new google.maps.Geocoder();
    setAddress(geocoding);
  });

  // Change map position based on address input
  $('#snapspot_address').on('input', function() {
    snapspot_address = $("#snapspot_address").val()
    geocoding  = new google.maps.Geocoder();
    codeAddress(geocoding);
  });

}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
    'Error: The Geolocation service failed.' :
    'Error: Your browser doesn\'t support geolocation.');
    infoWindow.open(map);
  }

  // Get lat and lng and center map based on placing map marker
  function placeMarkerAndPanTo(latLng, map) {
    if ( marker ) {
      infoWindow.setContent(`<div class='text-center'>Latitude: ${latLng.lat()} <br> Longitude: ${latLng.lng()}</div>`);
      marker.setPosition(latLng);
      infoWindow.open(map, marker);
      $("#snapspot_latitude").val(latLng.lat())
      $("#snapspot_longitude").val(latLng.lng())

    } else {
      marker = new google.maps.Marker({
        position: latLng,
        map: map
      });

    }
    map.panTo(latLng);
  }

  // Get position in map based on address input
  function codeAddress(geocoding){
    if(snapspot_address.length > 0){
      geocoding.geocode({'address': snapspot_address},function(results, status){
        if(status == google.maps.GeocoderStatus.OK){
          map.setCenter(results[0].geometry.location);
          marker.setPosition(results[0].geometry.location);

        } else {
          alert("Geocode was not successful for the following reason: " + status);
        }
      });
    }
  }

  // Set address value based on map marker position
  function setAddress(geocoding) {
    geocoding.geocode({'latLng': latLng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[0]) {
          if(results[0].formatted_address.length>64){
            $("#snapspot_address").val(results[0].formatted_address.substring(0,64)+'...')
          }
          else {
            $("#snapspot_address").val(results[0].formatted_address.substring(0,64)+'...')
          }
        }
      }
    });
  }
