
import 'package:ps7_iam_sd/Models/Location.dart';

class Event {
    String name;
    String description;
    String category;
    Location location;
    String number;
    int id;
    DateTime startTime;
    DateTime endTime;

    Event(this.name, this.description, this.category, this.location, this.number);

    Event.fromJson(Map<String, dynamic> json)
        : name = json['name'],
          description = json['description'],
          category = json['category'],
          location = Location.fromJson(json['location']),
          id = json['id'],
          number = json['number'];

    Map<String, dynamic> toJson() => {
      'name': name,
      'description': description,
      'category': category,
      'location': location,
      'number': number,
    };


    String toString(){
      return "Name: "+this.name+"  -   Category: "+this.category;
    }
}
