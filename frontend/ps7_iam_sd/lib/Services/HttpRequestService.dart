import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ps7_iam_sd/Mocks/EventMock.dart';
import 'package:ps7_iam_sd/Models/Case.dart';
import 'package:ps7_iam_sd/Models/Event.dart';
import 'package:ps7_iam_sd/Models/Location.dart';
import 'package:ps7_iam_sd/Models/User.dart';
import 'package:ps7_iam_sd/Models/Zone.dart';
import 'package:ps7_iam_sd/Services/GeolocationService.dart';

class HttpRequestService {

  static User user;
  var baseUrl = "http://192.168.43.230:9100/api";

  Future<List<User>> getUsers() async {
     final response = await http.get('$baseUrl/users');
    if (response.statusCode == 200) {
       final responseJson = json.decode(response.body);
      var userList = List<User>.from(responseJson.map((i) => User.fromJson(i)));
      return userList;
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<User> getUserByEmail(String userEmail) async {
     final response = await http.get("$baseUrl/users/$userEmail");
    if (response.statusCode == 200) {
       final responseJson = json.decode(response.body);
      var list = List<User>.from(responseJson.map((i) => User.fromJson(i)));
      return list[0];
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<User> getUserByEmailAndPassword(String userEmail, String userPassword) async {
    final response = await http.get('$baseUrl/users/$userEmail/$userPassword');
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      var list = List<User>.from(responseJson.map((i) => User.fromJson(i)));
      user = list[0];
      return list[0];
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<User> postUser(User user) async {
    final response = await http.post('$baseUrl/users/', body: json.encode(user.toJson()), headers: {HttpHeaders.contentTypeHeader: 'application/json',});
    if (response.statusCode == 200) {
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }

  }

  Future<User> putUser(User user) async {
    final response = await http.put('$baseUrl/users/', body: user.toJson());
    if (response.statusCode == 200) {
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<Event>> getEvents() async {
    final response = await http.get('$baseUrl/events');
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      var eventList = List<Event>.from(responseJson.map((i) => Event.fromJson(i)));
      return eventList;
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<Event> getEventByLocation(Location eventLocation) async {
    final latitude = eventLocation.latitude;
    final longitude = eventLocation.longitude;
    final response = await http.get("$baseUrl/events/$latitude/$longitude");
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      var list = List<Event>.from(responseJson.map((i) => Event.fromJson(i)));
      return list[0];
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<User> postEvent(Event event) async {
    final response = await http.post('$baseUrl/events/', body: json.encode(event.toJson()), headers: {HttpHeaders.contentTypeHeader: 'application/json',});
    if (response.statusCode == 200) {
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }

  }

  Future<User> putEvent(Event event) async {
    final response = await http.put('$baseUrl/events/', body: event.toJson());
    if (response.statusCode == 200) {
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<String> getPredictionEvent(Location visitorLocation) async {
      GeolocationService  geoService = new GeolocationService();
      double latitude = visitorLocation.latitude;
      double longitude = visitorLocation.longitude;
      List<Event> eventsZone2 = new List();
      for(int i=0; i<eventList2.length; i++){
        eventsZone2.add(new Event(eventList2[i]['name'], eventList2[i]['description'], eventList2[i]['category'], new Location(eventList2[i]['location']['latitude'], eventList2[i]['location']['longitude']), eventList2[i]['number']));
      }
      double distanceA = await geoService.getDistanceEvt(eventsZone2[0], visitorLocation); //event A
      double distanceB = await geoService.getDistanceEvt(eventsZone2[1], visitorLocation); //event A
      double distanceC = await geoService.getDistanceEvt(eventsZone2[2], visitorLocation); //event A
      double distanceD = await geoService.getDistanceEvt(eventsZone2[3], visitorLocation); //event A


       final response = await http.get("$baseUrl/prediction/?latitude=$latitude&longitude=$longitude&distanceA=$distanceA&distanceB=$distanceB&distanceC=$distanceC&distanceD=$distanceD");
      if (response.statusCode == 200) {
        final responseJson = response.body;
        return responseJson.toString();
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.body}');
      }
  }

  Future<String> getPredictionTrace(Location visitorLocation) async {
    Zone zone =  await Zone.init("Zone 1", "test http request zone 1");
    for(int i=0; i<zone.cases.length; i++){
      for(int j=0; j<zone.cases[0].length; j++) {
        zone.cases[i][j].zone = zone;
      }
    }
    visitorLocation.zone = zone;
    List<Case> belongCases = visitorLocation.detectBelongCases();
    int indexRow = belongCases[0].i;
    int indexColumn = belongCases[0].j;

    final response = await http.get("$baseUrl/prediction/?indexRow=$indexRow&indexColumn=$indexColumn");
    if (response.statusCode == 200) {
      final responseJson = response.body;
      return responseJson.toString();
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}
