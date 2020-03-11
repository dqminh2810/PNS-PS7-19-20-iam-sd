import 'dart:async';

import 'package:ps7_iam_sd/Models/Zone.dart';
import 'package:latlong/latlong.dart';

class RouteService{

  Future<List<LatLng>> getPredictedRoute(String route) async{
    Zone zone = await Zone.init("Zone 1", "show cases of zone 1");
    final myString = route.replaceAll(RegExp(r"[^\s\w]"), '');
    List<String> indexs = myString.split(" ");
    List<int> indexnum = new List<int>();
    for (String index in indexs) {
      indexnum.add(int.parse(index));
    }
    
    List<LatLng> routePoints = new List<LatLng>();
    List<int> indexI = new List<int>();
    List<int> indexJ = new List<int>();

    for(int i=0; i<indexnum.length; i++){
      if(i%2 == 0){
        indexI.add(indexnum[i]);
      }
      else{
        indexJ.add(indexnum[i]);
      }
    }

    for(int i=0; i<indexI.length; i++){
      routePoints.add(zone.cases[indexI[i]][indexJ[i]].middlePosition);
    }

    return routePoints;
  }
}