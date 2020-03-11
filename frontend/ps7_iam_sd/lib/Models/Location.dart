import 'package:ps7_iam_sd/Models/Case.dart';
import 'package:ps7_iam_sd/Models/Zone.dart';

class Location {
  double latitude ;
  double longitude;
  List<Case> belongCases;
  Zone zone;

  Location(double latitude, double longitude){
    belongCases = new List<Case>();
    this.latitude = latitude;
    this.longitude = longitude;
  }

  Location.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'] as double,
        longitude = json['longitude'] as double;

  Map<String, dynamic> toJson() => {
    'latitude' : latitude.toDouble(),
    'longitude' : longitude.toDouble(),
  };

  String toString(){
    return "["+this.latitude.toString()+", "+this.longitude.toString()+"]";
  }

  List detectBelongCases(){
    for(int i=0; i<this.zone.cases.length; i++){
      for(int j=0; j<this.zone.cases[0].length; j++){
        if((this.latitude<=zone.cases[i][j].latitudeMax && this.latitude>=zone.cases[i][j].latitudeMin) && (this.longitude<=zone.cases[i][j].longitudeMax && this.longitude>=zone.cases[i][j].longitudeMin)){
          belongCases.add(zone.cases[i][j]);
        }
      }
    }
    return belongCases;
  }
}
