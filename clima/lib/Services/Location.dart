import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0.0; // Default value to prevent LateInitializationError
  double longitude = 0.0; // Default value

  Future<void> getLocation() async {
    try {
      // Check permission status
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          throw Exception("Location permissions are denied");
        }
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print("Error getting location: $e");
    }
  }
}
