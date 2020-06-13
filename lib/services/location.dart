import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<Location> getCurrentLocation() async {
    try {
      Position currentPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;
    } catch (e) {
      print(e);
    }

    return this;
  }

  @override
  String toString() {
    if (latitude != null && longitude != null) {
      return 'Latitude: $latitude and Longtitude: $longitude';
    } else {
      return 'get current location first';
    }
  }
}
