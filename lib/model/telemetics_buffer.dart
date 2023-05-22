import 'index.dart';

class TelemeticsBuffer {
  List accelerometerX;
  List accelerometerY;
  List accelerometerZ;
  List gyroscopeX;
  List gyroscopeY;
  List gyroscopeZ;
  List userAccelerometerX;
  List userAccelerometerY;
  List userAccelerometerZ;
  int numList;
  final SumResult score = SumResult();
  TelemeticsBuffer(
      this.accelerometerX,
      this.accelerometerY,
      this.accelerometerZ,
      this.gyroscopeX,
      this.gyroscopeY,
      this.gyroscopeZ,
      this.userAccelerometerX,
      this.userAccelerometerY,
      this.userAccelerometerZ,
      this.numList);
  int hashBrake = 0;
  bool hashBrakeStatus = false;
  bool brakeDuration = false;
  int brakeDurationCount = 0;
  void pushData(
    String accelerometerInputX,
    String accelerometerInputY,
    String accelerometerInputZ,
    String gyroscopeInputX,
    String gyroscopeInputY,
    String gyroscopeInputZ,
    String userAccelerometerInputX,
    String userAccelerometerInputY,
    String userAccelerometerInputZ,
  ) {
    accelerometerX.add(accelerometerInputX);
    accelerometerY.add(accelerometerInputY);
    accelerometerZ.add(accelerometerInputZ);
    gyroscopeX.add(gyroscopeInputX);
    gyroscopeY.add(gyroscopeInputY);
    gyroscopeZ.add(gyroscopeInputZ);
    userAccelerometerX.add(userAccelerometerInputX);
    userAccelerometerY.add(userAccelerometerInputY);
    userAccelerometerZ.add(userAccelerometerInputZ);
  }

  void reset() {
    accelerometerX = [];
    accelerometerY = [];
    accelerometerZ = [];
    gyroscopeX = [];
    gyroscopeY = [];
    gyroscopeZ = [];
    userAccelerometerX = [];
    userAccelerometerY = [];
    userAccelerometerZ = [];
  }

  List calculate() {
    hashBrake = 0;
    brakeDuration = false;
    brakeDurationCount = 0;
    hashBrakeStatus = false;
    for (var i = 0; i < numList; i++) {
      if (userAccelerometerX[i] != null) {
        if (!hashBrakeStatus &&
            (userAccelerometerX[i] <= -1 ||
                userAccelerometerY[i] <= -1 ||
                userAccelerometerZ[i] <= -1)) {
          hashBrakeStatus = true;
          brakeDuration = true;
        }
        if (hashBrakeStatus &&
            (userAccelerometerX[i] >= -0.5 ||
                userAccelerometerY[i] >= -0.5 ||
                userAccelerometerZ[i] >= -0.5)) {
          hashBrakeStatus = false;
          brakeDuration = false;
          brakeDurationCount = 0;
          hashBrake += 1;
        }
        if (brakeDuration) {
          brakeDurationCount++;
        }
        if (brakeDurationCount >= numList / 2) {
          brakeDuration = false;
          brakeDurationCount = 0;
        }
      }
    }
    if (hashBrake > 0) {
      return [
        hashBrake,
        [
          userAccelerometerX.reduce((curr, next) => curr > next ? curr : next),
          userAccelerometerY.reduce((curr, next) => curr > next ? curr : next),
          userAccelerometerZ.reduce((curr, next) => curr > next ? curr : next),
        ].reduce((curr, next) => curr > next ? curr : next),
        [
          userAccelerometerX.reduce((curr, next) => curr < next ? curr : next),
          userAccelerometerY.reduce((curr, next) => curr < next ? curr : next),
          userAccelerometerZ.reduce((curr, next) => curr < next ? curr : next),
        ].reduce((curr, next) => curr < next ? curr : next),
      ];
    }
    reset();

    return [];
  }

  // List getListXTelemeticsBuffer() {
  //   return [];
  // }

  // List getListYTelemeticsBuffer() {
  //   return y;
  // }

  // List getListZTelemeticsBuffer() {
  //   return z;
  // }
}
