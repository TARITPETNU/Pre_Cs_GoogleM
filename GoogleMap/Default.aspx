<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GoogleMap._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<!DOCTYPE html>
<html>

<style>
#map {
  height: 600px;
  width: 100%;
}
</style>

<head>
    <title>Map</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
    <script>

   //direction

        function calcRoute(directionsService, directionsRenderer) {
            var start = document.getElementById('start').value;
            var end = document.getElementById('end').value;
            var request = {
                origin: start,
                destination: end,
                travelMode: 'DRIVING'
            };
            directionsService.route(request, function (result, status) {
                if (status == 'OK') {
                    directionsRenderer.setDirections(result);
                }
            });
        }

        function initMap() {
         
            var directionsService = new google.maps.DirectionsService();
            var directionsRenderer = new google.maps.DirectionsRenderer();
            var onChangeHandler = function () {
                calcRoute(directionsService, directionsRenderer);
            }
            document.getElementById('start').addEventListener('change', onChangeHandler);
            document.getElementById('end').addEventListener('change', onChangeHandler);

            const banrak = { lat: <%=bangrakLatitude %>, lng: <%=bangrakLongitude %> };
            const bangkokjai = { lat: <%=bangkokjaiLatitude %>, lng: <%=bangkokjaiLongitude %>};
            const path = [banrak, bangkokjai];
            const map = new google.maps.Map(document.getElementById("map"), {
                zoom: 13,
                center: banrak ,
            });
            directionsRenderer.setMap(map);
            var flightPath = new google.maps.Polyline({
                path: path,
                strokeColor: "#FF0000",
                strokeOpacity: 1,
                strokeWeight:2
            });
            flightPath.setMap(map);
            //บางรัก  
            const bangrakContentString =
                '<div id="content">' +
                '<div id="siteNotice">' +
                "</div>" +
                '<h1 id="firstHeading" class="firstHeading">Bang Rak</h1>' +
                '<div id="bodyContent">' +
                "<p><b>Latitude: </b>" +<%=bangrakLatitude %>+"</p>" +
                "<p><b>Longitude: </b>" +<%=bangrakLongitude %>+"</p>" +
                "</div>" +
                "</div>";
            const bangrakInfowindow = new google.maps.InfoWindow({
                content: bangrakContentString,
            });

            const markerBanrak = new google.maps.Marker({
                position: banrak,
                map,
                title: "Bang Rak",
                animation: google.maps.Animation.DROP
            });
            markerBanrak.addListener('mouseover', () => {
                bangrakInfowindow.open({
                    anchor: markerBanrak,
                    map,
                    shouldFocus: false,
                });
                if (markerBanrak.getAnimation() !== null) {
                    markerBanrak.setAnimation(null);
                } else {
                    markerBanrak.setAnimation(google.maps.Animation.BOUNCE);
                }
            });
            markerBanrak.addListener('mouseout', () => {
                bangrakInfowindow.close();
            });


            //บางกอกใหญ่
            const bangkokyaiContentString =
                '<div id="content">' +
                '<div id="siteNotice">' +
                "</div>" +
                '<h1 id="firstHeading" class="firstHeading">Bangkok Yai</h1>' +
                '<div id="bodyContent">' +
                "<p><b>Latitude: </b>" +<%=bangkokjaiLatitude %>+"</p>" +
                "<p><b>Longitude: </b>" +<%=bangkokjaiLongitude %>+"</p>" +
                "</div>" +
                "</div>";
            const bangkokyaiInfowindow = new google.maps.InfoWindow({
                content: bangkokyaiContentString,
            });
            const markerBangkokjai = new google.maps.Marker({
                position: bangkokjai,
                map,
                title: "Bangkok Yai",
                animation: google.maps.Animation.DROP
            });
            markerBangkokjai.addListener('mouseover', () => {
                bangkokyaiInfowindow.open({
                    anchor: markerBangkokjai,
                    map,
                    shouldFocus: false,
                });
                if (markerBangkokjai.getAnimation() !== null) {
                    markerBangkokjai.setAnimation(null);
                } else {
                    markerBangkokjai.setAnimation(google.maps.Animation.BOUNCE);
                }
            });
            markerBangkokjai.addListener('mouseout', () => {
                bangkokyaiInfowindow.close();
            });
        }

      
       

    </script>

</head>
<body>
    <div>
    <select id="start" onchange="calcRoute();">
  <option value="chicago, il">Chicago</option>
  <option value="st louis, mo">St Louis</option>
  <option value="joplin, mo">Joplin, MO</option>
  <option value="oklahoma city, ok">Oklahoma City</option>
  <option value="amarillo, tx">Amarillo</option>
  <option value="gallup, nm">Gallup, NM</option>
  <option value="flagstaff, az">Flagstaff, AZ</option>
  <option value="winona, az">Winona</option>
  <option value="kingman, az">Kingman</option>
  <option value="barstow, ca">Barstow</option>
  <option value="san bernardino, ca">San Bernardino</option>
  <option value="los angeles, ca">Los Angeles</option>
</select>
<strong>End: </strong>
<select id="end" onchange="calcRoute();">
  <option value="chicago, il">Chicago</option>
  <option value="st louis, mo">St Louis</option>
  <option value="joplin, mo">Joplin, MO</option>
  <option value="oklahoma city, ok">Oklahoma City</option>
  <option value="amarillo, tx">Amarillo</option>
  <option value="gallup, nm">Gallup, NM</option>
  <option value="flagstaff, az">Flagstaff, AZ</option>
  <option value="winona, az">Winona</option>
  <option value="kingman, az">Kingman</option>
  <option value="barstow, ca">Barstow</option>
  <option value="san bernardino, ca">San Bernardino</option>
  <option value="los angeles, ca">Los Angeles</option>
</select>
</div>
    <div id="map">
    </div>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBF4NbJLoTIwl7OdgQJnf7b_A-iQCYL80k&callback=initMap&v=weekly" async></script>
</body>
</html>

</asp:Content>
