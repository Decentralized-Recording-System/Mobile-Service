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
      print("full");
      resultOfAllScore.setResultScore(
          accelerometerBuffer.calculate(),
          gyroscopeListBuffer.calculate(),
          userAccelerometerListBuffer.calculate());
      return resultOfAllScore.getResultScore();
    }
    return [];
  }

  List test(List<String> accelerometer, List<String> gyroscope,
      List<String> userAccelerometer) {
    accelerometerBuffer.pushData(
        accelerometer[0], accelerometer[1], accelerometer[2]);
    gyroscopeListBuffer.pushData(gyroscope[0], gyroscope[1], gyroscope[2]);
    userAccelerometerListBuffer.pushData(
        userAccelerometer[0], userAccelerometer[1], userAccelerometer[2]);

    if (accelerometerBuffer.x.length == numList &&
        gyroscopeListBuffer.x.length == numList &&
        userAccelerometerListBuffer.x.length == numList) {
      print("full");
      List allListVar = [];
      for (var i = 0; i < numList; i++) {
        allListVar.add([
          accelerometerBuffer.getListXBuffer()[i],
          accelerometerBuffer.getListYBuffer()[i],
          accelerometerBuffer.getListZBuffer()[i],
          gyroscopeListBuffer.getListXBuffer()[i],
          gyroscopeListBuffer.getListYBuffer()[i],
          gyroscopeListBuffer.getListXBuffer()[i],
          userAccelerometerListBuffer.getListXBuffer()[i],
          userAccelerometerListBuffer.getListYBuffer()[i],
          userAccelerometerListBuffer.getListZBuffer()[i]
        ]);
      }
      var allList = allListVar;
      accelerometerBuffer.reset();
      gyroscopeListBuffer.reset();
      userAccelerometerListBuffer.reset();
      return allList;
      // resultOfAllScore.setResultScore(
      //     accelerometerBuffer.getListBuffer(),
      //     gyroscopeListBuffer.getListBuffer(),
      //     userAccelerometerListBuffer.getListBuffer());
      // return resultOfAllScore.getResultScore();
    }
    return [];
  }
}
