import 'package:location/location.dart';

class LocationHelper {
  late double latitute;
  late double longitude;

  Future<void> getCurrentLocation() async{
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled =await location.requestService();
      if(serviceEnabled) {
        return;
      }
    }
    
    permissionGranted = await location.hasPermission();
    if (permissionGranted==PermissionStatus.denied) {
      permissionGranted= await location.requestPermission();
      if(permissionGranted==PermissionStatus.denied){
        return;
      }
    }

    locationData = await location.getLocation();
    latitute = locationData.latitude!;
    longitude = locationData.longitude!;
  }
}