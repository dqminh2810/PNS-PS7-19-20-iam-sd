import 'dart:collection';

import 'package:ps7_iam_sd/Models/Case.dart';
import 'package:ps7_iam_sd/Models/Location.dart';

class Trace {
  HashMap<int, List<Case>> possibilities;

  Trace(List<Location> tracePos){
    possibilities = new HashMap();
    buildTrace(tracePos);
  }

  void buildTrace(List<Location> tracePos){
    int k=0;
    for(Location l in tracePos){
      l.detectBelongCases();
      possibilities[k] = l.belongCases;
      k++;
    }

    int h=0;
    while(h<possibilities.length){
      if(h!=0){
        for(Case c in possibilities[h-1]){
          for(Case next in possibilities[h]){
            if(c.i!=next.i || c.j!=next.j){
              c.updateAdjacents(c, next);
            }
          }
        }
      }
      h++;
    }
  }

  @override
  String toString() {
    String s = '';
    for(int i=0; i<possibilities.length; i++){
      s+=i.toString()+': '+possibilities[i].toString();
      for(int j=0; j<possibilities[i].length; j++){
        s+=' - '+possibilities[i][j].adjacents.toString();
      }
      s+='\n';
    }
    return s;
  }
  
}