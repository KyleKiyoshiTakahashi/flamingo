
if ("geolocation" in navigator) {
  $('.js-geolocation').show(); 
} else {
  $('.js-geolocation').hide();
}

/* Where in the world are you? */
$('.js-geolocation').on('click', function() {
  navigator.geolocation.getCurrentPosition(function(position) {
    loadWeather(position.coords.latitude+','+position.coords.longitude); //load weather using your lat/lng coordinates
  });
});

/* 
* Test Locations
* Finale Ligure lat/long: 44.171917, 8.353836
* Finale Ligure WOEID: 2357536
*/
$(document).ready(function() {
  loadWeather('Finale Ligure',''); //@params location, woeid
});

function loadWeather(location, woeid) {
  $.simpleWeather({
    location: location,
    woeid: woeid,
    unit: 'c',
    success: function(weather) {
      html = '<h2><i class="icon-'+weather.code+'"></i> '+weather.temp+'&deg;'+weather.units.temp+'</h2>'; 
      
      $("#weather").html(html);
    },
    error: function(error) {
      $("#weather").html('<p>'+error+'</p>');
    }
  });
}