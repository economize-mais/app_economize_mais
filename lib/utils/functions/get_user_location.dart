import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

Future getUserLatLong() async {
  Location location = Location();

  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }

  var permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }

  var locationData = await location.getLocation();
  return (locationData.latitude, locationData.longitude);
}

Future mapMostProbableZipcode(double latitude, double longitude) async {
  final map = {};

  List<geocoding.Placemark> listPlacemark =
      await geocoding.placemarkFromCoordinates(latitude, longitude);

  for (var placemark in listPlacemark) {
    map[placemark.postalCode] = (map[placemark.postalCode] ?? 0) + 1;
  }

  String mostProbableKey = listPlacemark.last.postalCode!;
  for (var element in map.entries) {
    if (element.key == mostProbableKey) continue;

    if (element.value < map[mostProbableKey]) {
      mostProbableKey = element.key;
    }
  }

  return mostProbableKey;
}
