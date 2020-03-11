import 'package:ps7_iam_sd/Models/Case.dart';
import 'package:ps7_iam_sd/Models/Location.dart';
import 'package:ps7_iam_sd/Services/GeolocationService.dart';

class Zone {
  String name;
  String description;
  static double latitudeMin = 43.692483;
  static double latitudeMax = 43.728412;
  static double longitudeMin = 7.242642;
  static double longitudeMax = 7.292493;
  static Location topLeft = new Location(43.728412, 7.242642);
  static Location topRight = new Location(43.692483, 7.242642);
  static Location bottomLeft = new Location (43.728412, 7.292493);
  static Location bottomRight = new Location(43.692483, 7.292493);
  int nbRow;
  int nbColumn;
  double stepWidth;
  double stepHeight;
  List<List<Case>> cases;


  static Future<Zone> init(String name, String description) async {

    var nbRow = 10;
    var nbColumn = 10;
    var cases = new List.generate(nbRow, (_) => new List<Case>(nbColumn));

    double stepLat = calculateStepLat(nbColumn);
    double stepLong = calculateStepLong(nbRow);

    for(int i=0; i<nbRow; i++){
      for(int j=0; j<nbColumn; j++){
        if(i==0){
          if(j==0){
            cases[i][j] = new Case(i, j, latitudeMax-stepLat, latitudeMax, longitudeMin, longitudeMin+stepLong);
          }else{
            cases[i][j] = new Case(i, j, latitudeMax-stepLat, latitudeMax, cases[i][j-1].longitudeMax, cases[i][j-1].longitudeMax+stepLong);
          }
        }else {
          if(j==0){
            cases[i][j] = new Case(i, j, cases[i-1][j].latitudeMin-stepLat, cases[i-1][j].latitudeMin, longitudeMin, longitudeMin+stepLong);
          }else{
            cases[i][j] = new Case(i, j, cases[i-1][j].latitudeMin-stepLat, cases[i-1][j].latitudeMin, cases[i][j-1].longitudeMax, cases[i][j-1].longitudeMax+stepLong);
          }
        }
      }
    }
    return Zone(name, description, nbRow, nbColumn, stepLat, stepLong, cases);
  }
  Zone(this.name, this.description, this.nbRow, this.nbColumn,this.stepWidth, this.stepHeight, this.cases);

  String toString(){
    return "[ ZONE: "+this.name.toString()+" - LatMin: "+latitudeMin.toString()+" - LatMax: "+latitudeMax.toString()+" - LongMin: "+longitudeMin.toString()+" - LongMax: "+longitudeMax.toString()+"]";
  }

  static Future<double> calculateWidthZone() async {
    GeolocationService g = new GeolocationService();
    double width = await g.getDistanceBetween(topLeft, topRight);
    return width;
  }

  static Future<double> calculateHeightZone() async {
    GeolocationService g = new GeolocationService();
    double height = await g.getDistanceBetween(topLeft, bottomLeft);
    return height;
  }

  static double calculateStepLat(int nbRow) {
    //double widthZone = await calculateWidthZone();
    double stepLat = (latitudeMax-latitudeMin)/nbRow;
    return stepLat;
  }

  static double calculateStepLong(int nbColumn) {
    //double heightZone = await calculateHeightZone();
    double stepLong = (longitudeMax-longitudeMin)/nbColumn;
    return stepLong;
  }

  static Future<double> calculateStepWidth(int nbColumn) async {
    double widthZone = await calculateWidthZone();
    double stepWidth = widthZone/nbColumn;
    return stepWidth;
  }

  static Future<double> calculateStepHeight(int nbRow) async {
    double heightZone = await calculateHeightZone();
    double stepHeight = heightZone/nbRow;
    return stepHeight;
  }
}
