import '../services/index.dart';
import 'index.dart';

class TelemeticsProcess {
  int numList;
  List accelerometerScoreList = [];
  List gyroscopeScoreList = [];
  List userAccelerometerScoreList = [];
  late Buffer accelerometerBuffer = Buffer([], [], [], numList);
  late Buffer gyroscopeListBuffer = Buffer([], [], [], numList);
  late Buffer userAccelerometerListBuffer = Buffer([], [], [], numList);
  ScoreCase scoreCase = ScoreCase();
  ResultScore resultOfAllScore = ResultScore();
  TelemeticsProcess(this.numList);

  List process(List<String> accelerometer, List<String> gyroscope,
      List<String> userAccelerometer) {
    accelerometerBuffer.pushData(
        accelerometer[0], accelerometer[1], accelerometer[2]);
    gyroscopeListBuffer.pushData(gyroscope[0], gyroscope[1], gyroscope[2]);
    userAccelerometerListBuffer.pushData(
        userAccelerometer[0], userAccelerometer[1], userAccelerometer[2]);

    if (accelerometerBuffer.x.length == numList &&
        gyroscopeListBuffer.x.length == numList &&
        userAccelerometerListBuffer.x.length == numList) {
      resultOfAllScore.setResultScore(
          accelerometerBuffer.calculate(),
          gyroscopeListBuffer.calculate(),
          userAccelerometerListBuffer.calculate());
      return resultOfAllScore.getResultScore();
    }
    return [];
  }
}
