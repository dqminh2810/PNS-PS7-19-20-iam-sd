import 'package:flutter_test/flutter_test.dart';
import 'package:ps7_iam_sd/Pages/NearestEventsPage.dart';
import 'package:flutter_test/src/widget_tester.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Nearest Events Page Test', () {
    test('Distance A Test', () {
      var result = new NearestEventsPage().createState().getDistanceA();
      expect(result, 0.0);
    });

    test('Current Latitude Position Test', () {
      var result = new NearestEventsPage().createState().getCurrentPosition();
      print(result.latitude);
      expect(result.latitude, 43.614502);
    });

    test('Current Longitude Position Test', () {
      var result = new NearestEventsPage().createState().getCurrentPosition();
      print(result.longitude);
      expect(result.longitude, 7.07111);
    });
  });
}
