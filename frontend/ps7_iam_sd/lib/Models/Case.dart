import 'dart:collection';
import 'package:ps7_iam_sd/Models/Location.dart';
import 'package:ps7_iam_sd/Models/Zone.dart';
import 'package:latlong/latlong.dart';

class Case {
  Zone zone;
  int i;
  int j;
  double latitudeMin;
  double latitudeMax;
  double longitudeMin;
  double longitudeMax;
  LatLng middlePosition;
  HashMap<int, int> adjacents;   //Key: The cases adjacent - Value: Number of times this case adjacent reached from the current case - 3,5 or 8 cases adjacent

  Case(int i, int j, double latitudeMin, double latitudeMax, double longitudeMin, double longitudeMax) {
    this.i = i;
    this.j = j;
    this.latitudeMin = latitudeMin;
    this.latitudeMax = latitudeMax;
    this.longitudeMin = longitudeMin;
    this.longitudeMax = longitudeMax;
    this.zone = zone;
    middlePosition = new LatLng((latitudeMax+latitudeMin)/2, (longitudeMax+longitudeMin)/2);
    adjacents = new HashMap();
    initAdjacents();
  }

    void initAdjacents(){
    for(int i = 0; i<8; i++){
      adjacents[i] = 0;
    }
  }

    bool checkLocation(Location l) {
      if ((l.latitude < this.latitudeMax && l.latitude > this.latitudeMin) &&
          (l.longitude < this.longitudeMax &&
              l.longitude > this.longitudeMin)) {
        return true;
      }
      return false;
    }

    void increaseWeight(int m){
      int i,j;  //index i and j of adjacent case
      i = getIndexRow(m);
      j = getIndexColumn(m);
      if(this.checkValidIndex(i, j)){
        this.adjacents[m]++;
      }
    }

    int getWeight(int m){
      return adjacents[m];
    }

    int getIndexRow(int m){
    int i;
      switch(m){
        case 0: i=this.i;
                break;
        case 1: i=this.i-1;
                break;
        case 2: i=this.i-1;
                break;
        case 3: i=this.i-1;
                break;
        case 4: i=this.i;
                break;
        case 5: i=this.i+1;
                break;
        case 6: i=this.i+1;
                break;
        case 7: i=this.i+1;
                break;
        default: break;
      }
      return i;
    }

    int getIndexColumn(int m){
    int j;
    switch(m){
      case 0: j=this.j+1;
              break;
      case 1: j=this.j+1;
              break;
      case 2: j=this.j;
              break;
      case 3: j=this.j-1;
              break;
      case 4: j=this.j-1;
              break;
      case 5: j=this.j-1;
              break;
      case 6: j=this.j;
              break;
      case 7: j=this.j+1;
              break;
      default:  break;
    }
    return j;
  }

    int getOrderAdjacent(int i, int j){
      if(i==this.i && j==this.j+1) return 0;
      else if(i==this.i-1 && j==this.j+1) return 1;
      else if(i==this.i-1 && j==this.j) return 2;
      else if(i==this.i-1 && j==this.j-1) return 3;
      else if(i==this.i && j==this.j-1) return 4;
      else if(i==this.i+1 && j==this.j-1) return 5;
      else if(i==this.i+1 && j==this.j) return 6;
      else if(i==this.i+1 && j==this.j+1) return 7;
    }

    Case predictNextCase(){
      int max=0;
      int indexMax=0;
      for(int i=0; i<adjacents.length; i++){
        if(adjacents[i] >max){
          max=adjacents[i];
          indexMax=i;
        }
      }
      if(max>0)
        return zone.cases[getIndexRow(indexMax)][getIndexColumn(indexMax)];
      else{
        //WHAT IF ADJACENTS HAVE NO NEXT MOVE - FOR NOW IT DOENST CHANGE
        if(((zone.cases.length-1)-this.j)>=zone.cases.length~/2) {
          increaseWeight(0);
          return zone.cases[getIndexRow(0)][getIndexColumn(0)];
        }
        else{
          increaseWeight(4);
          return zone.cases[getIndexRow(4)][getIndexColumn(4)];
        }

        /*
        for(int m=0; m<8; i++){
          if(checkValidIndex(getIndexRow(m), getIndexColumn(m))){
            return zone.cases[getIndexRow(m)][getIndexColumn(m)].predictNextCase();
          }
        }
         */
      }
    }

    void updateAdjacents(Case predictedNextCase, Case realNextCase) {
      if (predictedNextCase.i == realNextCase.i && predictedNextCase.j == realNextCase.j) {
        increaseWeight(getOrderAdjacent(predictedNextCase.i, predictedNextCase.j));
      } else {
          int max = 0;
          for (int i = 0; i < adjacents.length; i++) {
            if (adjacents[i] > max) {
              max = adjacents[i];
            }
          }
          if (max > 0)
            increaseWeight(getOrderAdjacent(realNextCase.i, realNextCase.j));
          //return zone.cases[getIndexRow(indexMax)][getIndexColumn(indexMax)];
          else {
            //WHAT IF ADJACENTS HAVE NO NEXT MOVE - FOR NOW IT DOENST CHANGE
            if (((zone.cases.length - 1) - this.j) >= zone.cases.length ~/ 2) {
              realNextCase.increaseWeight(0);
              //return zone.cases[getIndexRow(0)][getIndexColumn(0)];
            } else {
              realNextCase.increaseWeight(4);
              //return zone.cases[getIndexRow(0)][getIndexColumn(0)];
            }
          }

      }
    }

    bool checkValidIndex(int i, int j) {
      if (i >= 0 && i <= zone.cases.length - 1 && j >= 0 && j < zone.cases[0].length - 1) {
        return true;
      }
      return false;
    }

    void updateEmpty(){
      bool isEmpty = true;
      for(int m=0; m<8; m++){
        if(this.adjacents[m]!=0){
          isEmpty = false;
        }
      }
      if(isEmpty){
        this.predictNextCase();
      }
    }

    @override
    String toString() {
      String s = '';
      s+='['+this.i.toString()+', '+this.j.toString()+']';
      return s;
  }



}