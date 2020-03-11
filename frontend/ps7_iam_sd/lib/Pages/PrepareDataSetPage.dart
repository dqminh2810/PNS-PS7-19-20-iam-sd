import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ps7_iam_sd/Models/Event.dart';
import 'package:ps7_iam_sd/Models/Location.dart';
import 'package:ps7_iam_sd/Services/GeolocationService.dart';


class PrepareDataSetPage extends StatefulWidget {
  @override
  _PrepareDataSetPage createState() => _PrepareDataSetPage();

}

class _PrepareDataSetPage extends State<PrepareDataSetPage>{

  Completer<GoogleMapController> _controller = Completer();
   Map<String, Marker> _markers = {};
  static Event A = new Event("Event A", "A", "A", new Location(43.616502, 7.072096), '0');
  static Event B = new Event("Event B", "B", "B", new Location(43.615932, 7.068376), '0');
  static Event C = new Event("Event C", "C", "C", new Location(43.614502, 7.071110), '0');
  static Event D = new Event("Event D", "D", "D", new Location(43.614441, 7.073056), '0');

  @override
  void initState() {
     final marker_evtA = Marker(
      markerId: MarkerId("marker_A"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      position: LatLng(A.location.latitude, A.location.longitude),
      infoWindow: InfoWindow(
        title: 'EVENT A',
        snippet: A.location.toString(),
      ),
    );
     final marker_evtB = Marker(
      markerId: MarkerId("marker_B"),
      position: LatLng(B.location.latitude, B.location.longitude),
      infoWindow: InfoWindow(
        title: 'EVENT B',
        snippet: B.location.toString(),
      ),
    );
     final marker_evtC = Marker(
      markerId: MarkerId("marker_C"),
      position: LatLng(C.location.latitude, C.location.longitude),
      infoWindow: InfoWindow(
        title: 'EVENT C',
        snippet: C.location.toString(),
      ),
    );
     final marker_evtD = Marker(
      markerId: MarkerId("marker_D"),
      position: LatLng(D.location.latitude, D.location.longitude),
      infoWindow: InfoWindow(
        title: 'EVENT D',
        snippet: D.location.toString(),
      ),
    );

    _markers['A_pos'] = marker_evtA;
    _markers['B_pos'] = marker_evtB;
    _markers['C_pos'] = marker_evtC;
    _markers['D_pos'] = marker_evtD;

    prepareDataSet(100, 100, 1);
  }


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Get Current Location on Google Maps'),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }

  double getMinLat(){
    return min(min(A.location.latitude, B.location.latitude), min(C.location.latitude, D.location.latitude));
  }
  double getMaxLat(){
    return max(max(A.location.latitude, B.location.latitude), max(C.location.latitude, D.location.latitude));
  }
  double getMinLong(){
    return min(min(A.location.longitude, B.location.longitude), min(C.location.longitude, D.location.longitude));
  }
  double getMaxLong(){
    return max(max(A.location.longitude, B.location.longitude), max(C.location.longitude, D.location.longitude));
  }

  double getStepLat(int width){
    return (getMaxLat()-getMinLat())/width;
  }
  double getStepLong(int height){
    return (getMaxLong()-getMinLong())/height;
  }

  String getLabel(double distanceFromA, double distanceFromB, double distanceFromC, double distanceFromD){
    double minDistance = min(min(distanceFromA, distanceFromB), min(distanceFromC, distanceFromD));
    if(minDistance == distanceFromA) return "A";
    else if(minDistance == distanceFromB) return "B";
    else if(minDistance == distanceFromC) return "C";
    else if(minDistance == distanceFromD) return "D";
    else return null;
  }

  Future<void> preapreCSVDataset(List<dynamic> dataset) async {
     final width = dataset[0].length+1; //add Column label
     final height = dataset.length+1; //Row Title

    List<List<dynamic>> datasetCSV = new List.generate(height, (_) => new List<String>(width));

    //Header
    datasetCSV[0][0] = "Latitude";
    datasetCSV[0][1] = "Longitude";
    datasetCSV[0][2] = "DistanceFromA";
    datasetCSV[0][3] = "DistanceFromB";
    datasetCSV[0][4] = "DistanceFromC";
    datasetCSV[0][5] = "DistanceFromD";
    datasetCSV[0][6] = "NextEvent";

    print("latitude:  "+dataset[0]['latitude'].toString());
    print("latitude:  "+dataset[1]['latitude'].toString());
    print("latitude:  "+dataset[2]['latitude'].toString());
    print("longitude:  "+dataset[2]['longitude'].toString());
    print("Distance from A:  "+dataset[2]['distanceFromA'].toString());
    for(int i=1; i<height; i++){
        datasetCSV[i][0] = dataset[i-1]['latitude'].toString();
        datasetCSV[i][1] = dataset[i-1]['longitude'].toString();
        datasetCSV[i][2] = dataset[i-1]['distanceFromA'].toString();
        datasetCSV[i][3] = dataset[i-1]['distanceFromB'].toString();
        datasetCSV[i][4] = dataset[i-1]['distanceFromC'].toString();
        datasetCSV[i][5] = dataset[i-1]['distanceFromD'].toString();
        datasetCSV[i][6] = getLabel(dataset[i-1]['distanceFromA'], dataset[i-1]['distanceFromB'], dataset[i-1]['distanceFromC'], dataset[i-1]['distanceFromD']);
    }


    String directory = (await getExternalStorageDirectory()).absolute.path;
     final dir = "$directory";

    File CSVfile = new File(dir+"/dataset.csv");
    print(CSVfile.toString());

    String csv = const ListToCsvConverter().convert(datasetCSV);
    CSVfile.writeAsString(csv);


  }

  Future<void> prepareDataSet(int height, int width, int latBias) async {
    GeolocationService  geoService = new GeolocationService();
    var randomPosTable = randomPosition(height, width, latBias);
    List<dynamic> dataSet = new List(height*width);

    for(int i = 0; i<height; i++){
      for(int j = 0; j<width; j++) {
        dataSet[i*width + j] = new HashMap<String, dynamic>();
        double distanceA, distanceB, distanceC, distanceD;
        distanceA= await geoService.getDistanceEvt(A, randomPosTable[i][j]);
        distanceB= await geoService.getDistanceEvt(B, randomPosTable[i][j]);
        distanceC= await geoService.getDistanceEvt(C, randomPosTable[i][j]);
        distanceD= await geoService.getDistanceEvt(D, randomPosTable[i][j]);
        dataSet[i*width + j]['latitude'] = randomPosTable[i][j].latitude;
        dataSet[i*width + j]['longitude'] = randomPosTable[i][j].longitude;
        dataSet[i*width + j]['distanceFromA'] = distanceA;
        dataSet[i*width + j]['distanceFromB'] = distanceB;
        dataSet[i*width + j]['distanceFromC'] = distanceC;
        dataSet[i*width + j]['distanceFromD'] = distanceD;
      }
    }

    print(dataSet[0]);
    this.preapreCSVDataset(dataSet);
    return dataSet;
  }

  List<List<Location>> randomPosition(int height, int width, int latBias){
    double stepLat = getStepLat(width)/latBias;
    double stepLong = getStepLong(height);

    var coordinateZone = new List.generate(height, (_) => new List<Location>(width*latBias));
    for(int i = 0; i<height; i++){
      for(int j = 0; j<width*latBias; j++){
        if(i==0){
          if(j==0){
            coordinateZone[i][j] = new Location(getMaxLat(), getMinLong());
          }else{
            coordinateZone[i][j] = new Location(coordinateZone[i][j-1].latitude-stepLat, getMinLong());
          }
        }else{
          if(j==0){
            coordinateZone[i][j] = new Location(getMaxLat(), coordinateZone[i-1][j].longitude+stepLong);
          }else{
            coordinateZone[i][j]= new Location(coordinateZone[i][j-1].latitude-stepLat, coordinateZone[i-1][j].longitude+stepLong);
          }
        }
      }
    }
    return coordinateZone;
  }



}