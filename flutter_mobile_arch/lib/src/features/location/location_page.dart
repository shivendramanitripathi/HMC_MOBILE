// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
//
// import '../../services/http_interceptor.dart';
// import '../../services/location_services.dart';
//
// class LocationPage extends StatefulWidget {
//   const LocationPage({super.key});
//
//   @override
//   _LocationPageState createState() => _LocationPageState();
// }
//
// class _LocationPageState extends State<LocationPage> {
//   String _locationMessage = '';
//   final LocationService _locationService = LocationService();
//   final HttpInterceptor _httpInterceptor = HttpInterceptor();
//
//   Future<void> _getCurrentLocation() async {
//     Position? position = await _locationService.getCurrentLocation();
//
//     if (position == null) {
//       setState(() {
//         _locationMessage = 'Failed to get location.';
//       });
//       return;
//     }
//
//     setState(() {
//       _locationMessage =
//       'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
//     });
//
//     String googleMapsUrl =
//         'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
//     if (await canLaunch(googleMapsUrl)) {
//       await launch(googleMapsUrl);
//     } else {
//       setState(() {
//         _locationMessage = 'Could not open the map.';
//       });
//     }
//     String url = 'https://example.com/api/location';
//     var request = http.Request('POST', Uri.parse(url));
//     request.body =
//     '{"latitude": "${position.latitude}", "longitude": "${position.longitude}"}';
//
//     final interceptedRequest = await _httpInterceptor.interceptRequest(request);
//
//     var streamedResponse = await interceptedRequest.send();
//
//     var response = await http.Response.fromStream(streamedResponse);
//     var interceptedResponse = await _httpInterceptor.interceptResponse(response as http.StreamedResponse);
//
//     if (interceptedResponse.statusCode == 200) {
//       setState(() {
//         _locationMessage = 'Location sent successfully!';
//       });
//     } else {
//       setState(() {
//         _locationMessage = 'Failed to send location.';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const SizedBox(height: 20),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: _getCurrentLocation,
//             child: const Icon(Icons.location_on_rounded),
//           ),
//         ),
//       ],
//     );
//   }
// }
