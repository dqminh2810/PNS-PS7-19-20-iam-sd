
import 'package:ps7_iam_sd/Models/Location.dart';
import 'package:ps7_iam_sd/Models/Trace.dart';

class User {
    String name;
    String type;
    String email;
    String password;
    Location location;
    String status;
    int id;

    List<Trace> traces;

    User(this.name, this.type, this.email, this.password, this.location, this.status);

    User.fromJson(Map<String, dynamic> json)
        : name = json['name'],
          type = json['type'],
          email = json['email'],
          password = json['password'],
          location = Location.fromJson(json['location']),
          id = json['id'],
          status = json['id'];

    Map<String, dynamic> toJson() => {
      'name': name,
      'type': type,
      'email': email,
      'password': password,
      'location': location,
      'status': status,
    };



    String toString(){
      return "Name: "+this.name+"  -   Email: "+this.email;
    }

    String getPassword(){
      return this.password;
    }

    String getEmail(){
      return this.email;
    }



}
