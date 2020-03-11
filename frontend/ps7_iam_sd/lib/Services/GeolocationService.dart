import 'package:geolocator/geolocator.dart';
import 'package:ps7_iam_sd/Models/Event.dart';
import 'package:ps7_iam_sd/Models/Location.dart';
import 'package:ps7_iam_sd/Models/User.dart';

class GeolocationService {
  static bool near = false;

  Future isEventNearByUser(Event evt, User usr) async{
    Geolocator geo = new Geolocator();
     await geo.distanceBetween(evt.location.latitude, evt.location.longitude, evt.location.latitude, usr.location.latitude).then((value) => {
      isNearBy(value)
    });
  }

  void isNearBy(distance){
    print(distance);
    if(distance < 10) near = true;
    else near = false;
  }

  bool getNear(){
    return near;
  }


  Future getDistanceEvt(Event evt, Location currentPosition) async {
    double distance = await getDistanceBetween(evt.location, currentPosition);
    return distance;
  }


  Future<double> getDistanceBetween(Location l1, Location l2) async {
    Geolocator geo = new Geolocator();
    double distance = await geo.distanceBetween(l1.latitude,
        l1.longitude, l2.latitude, l2.longitude);
    return distance;
  }
}