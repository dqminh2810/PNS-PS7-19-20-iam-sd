

import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ps7_iam_sd/Models/Case.dart';
import 'package:ps7_iam_sd/Models/Location.dart';
import 'package:ps7_iam_sd/Models/Trace.dart';
import 'package:ps7_iam_sd/Models/Zone.dart';

class TestZonePage extends StatefulWidget {
  @override
  _TestZonePage createState() => _TestZonePage();
}

class _TestZonePage extends State<TestZonePage> {

  @override
  void initState() {
    //test();
    initZone();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      ),
    );
  }


  void initZone() async{
    Zone zone =  await Zone.init("testZone", "test");

    for(int i=0; i<zone.cases.length; i++){
      for(int j=0; j<zone.cases[0].length; j++) {
        zone.cases[i][j].zone = zone;
      }
    }
    prepareDataSet(zone, initListLocations(zone));
  }

  Trace initTrace(Zone zone){
    List<Location> tracePos =  new List();

    Location l1 = new Location(43.614654, 7.067939);
    Location l2 = new Location(43.614728, 7.067918);
    Location l3 = new Location(43.614763, 7.067864);
    Location l4 = new Location(43.614837, 7.067848);
    Location l5 = new Location(43.614914, 7.067854);
    Location l6 = new Location(43.614984, 7.067795);
    Location l7 = new Location(43.615031, 7.067779);
    Location l8 = new Location(43.615112, 7.067795);
    Location l9 = new Location(43.615182, 7.067773);
    Location l10 = new Location(43.615248, 7.067816);
    Location l11 = new Location(43.615310, 7.067773);
    Location l12 = new Location(43.615337, 7.067752);
    Location l13 = new Location(43.615423, 7.067746);
    Location l14 = new Location(43.615435, 7.067768);
    Location l15 = new Location(43.615501, 7.06779);
    l1.zone = zone;
    l2.zone = zone;
    l3.zone = zone;
    l4.zone = zone;
    l5.zone = zone;
    l6.zone = zone;
    l7.zone = zone;
    l8.zone = zone;
    l9.zone = zone;
    l10.zone = zone;
    l11.zone = zone;
    l12.zone = zone;
    l13.zone = zone;
    l14.zone = zone;
    l15.zone = zone;

    tracePos.add(l1);
    tracePos.add(l2);
    tracePos.add(l3);
    tracePos.add(l4);
    tracePos.add(l5);
    tracePos.add(l6);
    tracePos.add(l7);
    tracePos.add(l8);
    tracePos.add(l9);
    tracePos.add(l10);
    tracePos.add(l11);
    tracePos.add(l12);
    tracePos.add(l13);
    tracePos.add(l14);
    tracePos.add(l15);

    Trace t = new Trace(tracePos);
    for(int i=0; i<zone.cases.length; i++){
      for(int j=0; j<zone.cases[0].length; j++){
        zone.cases[i][j].updateAdjacents(zone.cases[i][j], zone.cases[i][j]);
      }
    }
    return t;
  }

  List<List<Location>> initListLocations(Zone zone){
    final p1 = new Location(43.72661555, 7.2451345499999995);
    final p2 = new Location(43.72661555, 7.25011965);
    final p3 = new Location(43.72661555, 7.255104749999999);
    final p4 = new Location(43.72661555, 7.26008985);
    final p5 = new Location(43.72661555, 7.265074949999999);
    final p6 = new Location(43.72661555, 7.27006005);
    final p7 = new Location(43.72661555, 7.275045149999999);
    final p8 = new Location(43.72661555, 7.280030249999999);
    final p9 = new Location(43.72661555, 7.285015349999998);
    final p10 = new Location(43.72661555, 7.290000449999999);
    final p11 = new Location(43.72302265, 7.290000449999999);
    final p12 = new Location(43.72302265, 7.285015349999998);
    final p13 = new Location(43.72302265, 7.280030249999999);
    final p14 = new Location(43.72302265, 7.275045149999999);
    final p15 = new Location(43.72302265, 7.27006005);
    final p16 = new Location(43.72302265, 7.265074949999999);
    final p17 = new Location(43.72302265, 7.26008985);
    final p18 = new Location(43.72302265, 7.255104749999999);
    final p19 = new Location(43.72302265, 7.25011965);
    final p20 = new Location(43.72302265, 7.2451345499999995);
    final p21 = new Location(43.719429749999996, 7.2451345499999995);
    final p22 = new Location(43.719429749999996, 7.25011965);
    final p23 = new Location(43.719429749999996, 7.255104749999999);
    final p24 = new Location(43.719429749999996, 7.26008985);
    final p25 = new Location(43.719429749999996, 7.265074949999999);
    final p26 = new Location(43.719429749999996, 7.27006005);
    final p27 = new Location(43.719429749999996, 7.275045149999999);
    final p28 = new Location(43.719429749999996, 7.280030249999999);
    final p29 = new Location(43.719429749999996, 7.285015349999998);
    final p30 = new Location(43.719429749999996, 7.290000449999999);
    final p31 = new Location(43.715836849999995, 7.290000449999999);
    final p32 = new Location(43.715836849999995, 7.285015349999998);
    final p33 = new Location(43.715836849999995, 7.280030249999999);
    final p34 = new Location(43.715836849999995, 7.275045149999999);
    final p35 = new Location(43.715836849999995, 7.27006005);
    final p36 = new Location(43.715836849999995, 7.265074949999999);
    final p37 = new Location(43.715836849999995, 7.26008985);
    final p38 = new Location(43.715836849999995, 7.255104749999999);
    final p39 = new Location(43.715836849999995, 7.25011965);
    final p40 = new Location(43.715836849999995, 7.2451345499999995);
    final p41 = new Location(43.712243949999994, 7.2451345499999995);
    final p42 = new Location(43.712243949999994, 7.25011965);
    final p43 = new Location(43.712243949999994, 7.255104749999999);
    final p44 = new Location(43.712243949999994, 7.26008985);
    final p45 = new Location(43.712243949999994, 7.265074949999999);
    final p46 = new Location(43.712243949999994, 7.27006005);
    final p47 = new Location(43.712243949999994, 7.275045149999999);
    final p48 = new Location(43.712243949999994, 7.280030249999999);
    final p49 = new Location(3.712243949999994, 7.285015349999998);
    final p50 = new Location(43.712243949999994, 7.290000449999999);
    final p51 = new Location(43.70865104999999, 7.290000449999999);
    final p52 = new Location(43.70865104999999, 7.285015349999998);
    final p53 = new Location(43.70865104999999, 7.280030249999999);
    final p54 = new Location(43.70865104999999, 7.275045149999999);
    final p55 = new Location(43.70865104999999, 7.27006005);
    final p56 = new Location(43.70865104999999, 7.265074949999999);
    final p57 = new Location(43.70865104999999, 7.26008985);
    final p58 = new Location(43.70865104999999, 7.255104749999999);
    final p59 = new Location(43.70865104999999, 7.25011965);
    final p60 = new Location(43.70865104999999, 7.2451345499999995);
    final p61 = new Location(43.70505814999999, 7.2451345499999995);
    final p62 = new Location(43.70505814999999, 7.25011965);
    final p63 = new Location(43.70505814999999, 7.255104749999999);
    final p64 = new Location(43.70505814999999, 7.26008985);
    final p65 = new Location(43.70505814999999, 7.265074949999999);
    final p66 = new Location(43.70505814999999, 7.27006005);
    final p67 = new Location(43.70505814999999, 7.275045149999999);
    final p68 = new Location(43.70505814999999, 7.280030249999999);
    final p69 = new Location(43.70505814999999, 7.285015349999998);
    final p70 = new Location(43.70505814999999, 7.290000449999999);
    final p71 = new Location(43.70146524999999, 7.290000449999999);
    final p72 = new Location(43.70146524999999, 7.285015349999998);
    final p73 = new Location(43.70146524999999, 7.280030249999999);
    final p74 = new Location(43.70146524999999, 7.275045149999999);
    final p75 = new Location(43.70146524999999, 7.27006005);
    final p76 = new Location(43.70146524999999, 7.265074949999999);
    final p77 = new Location(43.70146524999999, 7.26008985);
    final p78 = new Location(43.70146524999999, 7.255104749999999);
    final p79 = new Location(43.70146524999999, 7.25011965);
    final p80 = new Location(43.70146524999999, 7.2451345499999995);
    final p81 = new Location(43.69787234999999, 7.2451345499999995);
    final p82 = new Location(43.69787234999999, 7.25011965);
    final p83 = new Location(43.69787234999999, 7.255104749999999);
    final p84 = new Location(43.69787234999999, 7.26008985);
    final p85 = new Location(43.69787234999999, 7.265074949999999);
    final p86 = new Location(43.69787234999999, 7.27006005);
    final p87 = new Location(43.69787234999999, 7.275045149999999);
    final p88 = new Location(43.69787234999999, 7.280030249999999);
    final p89 = new Location(43.69787234999999, 7.285015349999998);
    final p90 = new Location(43.69787234999999, 7.290000449999999);
    final p91 = new Location(43.69427944999999, 7.290000449999999);
    final p92 = new Location(43.69427944999999, 7.285015349999998);
    final p93 = new Location(43.69427944999999, 7.280030249999999);
    final p94 = new Location(43.69427944999999, 7.275045149999999);
    final p95 = new Location(43.69427944999999, 7.27006005);
    final p96 = new Location(43.69427944999999, 7.265074949999999);
    final p97 = new Location(43.69427944999999, 7.26008985);
    final p98 = new Location(43.69427944999999, 7.255104749999999);
    final p99 = new Location(43.69427944999999, 7.25011965);
    final p100 = new Location(43.69427944999999, 7.2451345499999995);

    List<Location> trace1 = new List<Location>();
    List<Location> trace2 = new List<Location>();
    List<Location> trace3 = new List<Location>();
    List<Location> trace4 = new List<Location>();
    List<Location> trace5 = new List<Location>();
    List<Location> trace6 = new List<Location>();
    List<Location> trace7 = new List<Location>();
    List<Location> trace8 = new List<Location>();
    List<Location> trace9 = new List<Location>();
    List<Location> trace10 = new List<Location>();
    trace1.add(p80); trace1.add(p61); trace1.add(p62); trace1.add(p59); trace1.add(p42); trace1.add(p43); trace1.add(p44); trace1.add(p37); trace1.add(p24); trace1.add(p25); trace1.add(p26); trace1.add(p27); trace1.add(p28); trace1.add(p32); trace1.add(p49);
    trace2.add(p9); trace2.add(p8); trace2.add(p7); trace2.add(p14); trace2.add(p15); trace2.add(p16); trace2.add(p17); trace2.add(p18); trace2.add(p19); trace2.add(p21); trace2.add(p40); trace2.add(p41); trace2.add(p60); trace2.add(p59); trace2.add(p58);
    trace3.add(p51); trace3.add(p52); trace3.add(p53); trace3.add(p48); trace3.add(p33); trace3.add(p27); trace3.add(p26); trace3.add(p25); trace3.add(p24); trace3.add(p23); trace3.add(p19); trace3.add(p3); trace3.add(p4); trace3.add(p5); trace3.add(p6);
    trace4.add(p1); trace4.add(p20); trace4.add(p19); trace4.add(p22); trace4.add(p23); trace4.add(p37); trace4.add(p45); trace4.add(p46); trace4.add(p47); trace4.add(p54); trace4.add(p68); trace4.add(p73); trace4.add(p88); trace4.add(p89); trace4.add(p90);
    trace5.add(p79); trace5.add(p78); trace5.add(p77); trace5.add(p76); trace5.add(p75); trace5.add(p74); trace5.add(p73); trace5.add(p72); trace5.add(p69); trace5.add(p52); trace5.add(p49); trace5.add(p32); trace5.add(p29); trace5.add(p30); trace5.add(p11);
    trace6.add(p79); trace6.add(p82); trace6.add(p83); trace6.add(p84); trace6.add(p85); trace6.add(p96); trace6.add(p95); trace6.add(p94); trace6.add(p88); trace6.add(p89); trace6.add(p91); trace6.add(p90); trace6.add(p71); trace6.add(p70); trace6.add(p51);
    trace7.add(p100); trace7.add(p99); trace7.add(p98); trace7.add(p97); trace7.add(p84); trace7.add(p77); trace7.add(p76); trace7.add(p75); trace7.add(p74); trace7.add(p67); trace7.add(p54); trace7.add(p47); trace7.add(p34); trace7.add(p28); trace7.add(p29);
    trace8.add(p40); trace8.add(p39); trace8.add(p38); trace8.add(p43); trace8.add(p58); trace8.add(p57); trace8.add(p56); trace8.add(p55); trace8.add(p54); trace8.add(p53); trace8.add(p48); trace8.add(p33); trace8.add(p28); trace8.add(p13); trace8.add(p8);
    trace9.add(p82); trace9.add(p83); trace9.add(p78); trace9.add(p63); trace9.add(p64); trace9.add(p57); trace9.add(p56); trace9.add(p45); trace9.add(p46); trace9.add(p55); trace9.add(p66); trace9.add(p67); trace9.add(p68); trace9.add(p73); trace9.add(p88);
    trace10.add(p82); trace10.add(p79); trace10.add(p62); trace10.add(p59); trace10.add(p58); trace10.add(p43); trace10.add(p44); trace10.add(p37); trace10.add(p24); trace10.add(p25); trace10.add(p36); trace10.add(p35); trace10.add(p46); trace10.add(p47); trace10.add(p48);
    for(int k=0; k<15; k++){
      trace1[k].zone = zone;
      trace2[k].zone = zone;
      trace3[k].zone = zone;
      trace4[k].zone = zone;
      trace5[k].zone = zone;
      trace6[k].zone = zone;
      trace7[k].zone = zone;
      trace8[k].zone = zone;
      trace9[k].zone = zone;
      trace10[k].zone = zone;
    }

    List<List<Location>> user1Traces = [];
    user1Traces.add(trace1);
    user1Traces.add(trace2); user1Traces.add(trace3);  user1Traces.add(trace4); user1Traces.add(trace5); user1Traces.add(trace6); user1Traces.add(trace7); user1Traces.add(trace8);   user1Traces.add(trace9); user1Traces.add(trace10);

    return user1Traces;
  }

  Future preapreCSVDataset(List<dynamic> dataset) async{
     var width = dataset[0].length;
     var height = dataset.length+1; //add Row Title

    List<List<dynamic>> datasetCSV = new List.generate(height, (_) => new List<String>(width));

    datasetCSV[0][0] = "Index i";
    datasetCSV[0][1] = "Index j";
    datasetCSV[0][2] = "Adjacent 0";
    datasetCSV[0][3] = "Adjacent 1";
    datasetCSV[0][4] = "Adjacent 2";
    datasetCSV[0][5] = "Adjacent 3";
    datasetCSV[0][6] = "Adjacent 4";
    datasetCSV[0][7] = "Adjacent 5";
    datasetCSV[0][8] = "Adjacent 6";
    datasetCSV[0][9] = "Adjacent 7";
    datasetCSV[0][10] = "Next Move";

    for(int i=1; i<height; i++){
      datasetCSV[i][0] = dataset[i-1]['i'].toString();
      datasetCSV[i][1] = dataset[i-1]['j'].toString();
      datasetCSV[i][2] = dataset[i-1]['adjacent0'].toString();
      datasetCSV[i][3] = dataset[i-1]['adjacent1'].toString();
      datasetCSV[i][4] = dataset[i-1]['adjacent2'].toString();
      datasetCSV[i][5] = dataset[i-1]['adjacent3'].toString();
      datasetCSV[i][6] = dataset[i-1]['adjacent4'].toString();
      datasetCSV[i][7] = dataset[i-1]['adjacent5'].toString();
      datasetCSV[i][8] = dataset[i-1]['adjacent6'].toString();
      datasetCSV[i][9] = dataset[i-1]['adjacent7'].toString();
      datasetCSV[i][10] = dataset[i-1]['label'].toString();
    }


    String directory = (await getExternalStorageDirectory()).absolute.path;
     final dir = "$directory";

    File CSVfile = new File(dir+"/dataset.csv");
    print(CSVfile.toString());

    String csv = const ListToCsvConverter().convert(datasetCSV);
    CSVfile.writeAsString(csv);
  }

  void prepareDataSet(Zone zone, List<List<Location>>dataTraces){
    List<Trace> traces = [];
    for(int i=0; i<dataTraces.length; i++){
      traces.add(new Trace(dataTraces[i]));
    }

    for(int i=0; i<zone.cases.length; i++){
      for(int j=0; j<zone.cases[0].length; j++){
        zone.cases[i][j].updateEmpty();
      }
    }
    var height = zone.cases.length;
    var width = zone.cases[0].length;

    List<dynamic> dataSet = new List(height*width);
    for(int i = 0; i<height; i++){
      for(int j = 0; j<width; j++) {
        dataSet[i*width + j] = new HashMap<String, dynamic>();
        int index_i = zone.cases[i][j].i;
        int index_j = zone.cases[i][j].j;
        int adjacent0 = zone.cases[i][j].getWeight(0);
        int adjacent1 = zone.cases[i][j].getWeight(1);
        int adjacent2 = zone.cases[i][j].getWeight(2);
        int adjacent3 = zone.cases[i][j].getWeight(3);
        int adjacent4 = zone.cases[i][j].getWeight(4);
        int adjacent5 = zone.cases[i][j].getWeight(5);
        int adjacent6 = zone.cases[i][j].getWeight(6);
        int adjacent7 = zone.cases[i][j].getWeight(7);

        dataSet[i*width + j]['i'] = index_i;
        dataSet[i*width + j]['j'] = index_j;
        dataSet[i*width + j]['adjacent0'] = adjacent0;
        dataSet[i*width + j]['adjacent1'] = adjacent1;
        dataSet[i*width + j]['adjacent2'] = adjacent2;
        dataSet[i*width + j]['adjacent3'] = adjacent3;
        dataSet[i*width + j]['adjacent4'] = adjacent4;
        dataSet[i*width + j]['adjacent5'] = adjacent5;
        dataSet[i*width + j]['adjacent6'] = adjacent6;
        dataSet[i*width + j]['adjacent7'] = adjacent7;
        dataSet[i*width + j]['label'] = getLabel(zone.cases[i][j]);
      }
    }

    this.preapreCSVDataset(dataSet);
  }

  int getLabel(Case c){
    var maxWeight = max(max(max(c.adjacents[0], c.adjacents[1]), max(c.adjacents[2], c.adjacents[3])),max(max(c.adjacents[4], c.adjacents[5]), max(c.adjacents[6], c.adjacents[7])));

    var key = c.adjacents.keys.firstWhere((k) => c.adjacents[k] == maxWeight, orElse: () => null);
    return key;

  }

}
