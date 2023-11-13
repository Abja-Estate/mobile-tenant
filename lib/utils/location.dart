import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

import 'local_storage.dart';

getAddress(data) async {
  // Initialize geocoding service
  GeocodingPlatform.instance;

  // Get user location
  LocationData locationData = await data;

  // Extract the latitude and longitude from LocationData
  double latitude = locationData.latitude!;
  double longitude = locationData.longitude!;

  // Perform reverse geocoding
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);

  // Extract address from the first placemark
  String address = placemarks.first?.thoroughfare ?? '';
  String houseNumber = placemarks.first?.subThoroughfare ?? '';
  String city = placemarks.first?.locality ?? '';
  String localGovernment = placemarks.first?.subAdministrativeArea ?? '';
  String state = placemarks.first?.administrativeArea ?? '';
  String country = placemarks.first?.country ?? '';
  


  var locationInfo = {
    'fullAddress': '${houseNumber} ${address}, ${localGovernment}, ${city}',
    "state": state == '' ? city : state,
    "city": localGovernment
  };
  // Print the address
  // return '${houseNumber} ${address}, ${localGovernment}, ${city}';
  return locationInfo;
}
