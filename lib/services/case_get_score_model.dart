import '../model/index.dart';
import 'index.dart';

class ScoreCase {
  void getCase(List listOfResult, TelemeticsDatabase db) {
    if (listOfResult[0] < 500) {
    } else if (listOfResult[1] < 500) {
      db.create(TelemeticsDatabaseModel(
          score: 11, highestValue: 12.0, lowestValue: 15.0));
    } else if (listOfResult[2] > 500) {
      db.create(TelemeticsDatabaseModel(
          score: 11, highestValue: 12.0, lowestValue: 15.0));
    } else if (listOfResult[3] < 500) {
    } else if (listOfResult[4] < 500) {
    } else if (listOfResult[5] < 500) {
    } else if (listOfResult[6] < 500) {
    } else if (listOfResult[7] < 500) {
    } else if (listOfResult[8] < 500) {}
  }
}
