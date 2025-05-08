import 'package:geolocator/geolocator.dart';

double calculateDistance(double startLatitude, double startLongitude,
    double endLatitude, double endLongitude) {
  return Geolocator.distanceBetween(
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
  );
 // double distanceInMeters
 // double distanceInKm = distanceInMeters / 1000;
 // print('Distance: ${distanceInKm.toStringAsFixed(2)} km');
}