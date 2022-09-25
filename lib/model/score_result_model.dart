class ResultScore {
  double resultOfAccelerometerX;
  double resultOfAccelerometerY;
  double resultOfAccelerometerZ;
  double resultOfGyroscopeX;
  double resultOfGyroscopeY;
  double resultOfGyroscopeZ;
  double resultOfUserAccelerometerX;
  double resultOfUserAccelerometerY;
  double resultOfUserAccelerometerZ;
  ResultScore(
      {this.resultOfAccelerometerX = 0,
      this.resultOfAccelerometerY = 0,
      this.resultOfAccelerometerZ = 0,
      this.resultOfGyroscopeX = 0,
      this.resultOfGyroscopeY = 0,
      this.resultOfGyroscopeZ = 0,
      this.resultOfUserAccelerometerX = 0,
      this.resultOfUserAccelerometerY = 0,
      this.resultOfUserAccelerometerZ = 0});
  void setResultScore(List listResultOfAccelerometer,
      List listResultOfGyroscope, List listResultOfUserAccelerometer) {
    resultOfAccelerometerX = listResultOfAccelerometer[0];
    resultOfAccelerometerY = listResultOfAccelerometer[1];
    resultOfUserAccelerometerZ = listResultOfAccelerometer[2];
    resultOfGyroscopeX = listResultOfGyroscope[0];
    resultOfGyroscopeY = listResultOfGyroscope[1];
    resultOfGyroscopeZ = listResultOfGyroscope[2];
    resultOfUserAccelerometerX = listResultOfUserAccelerometer[0];
    resultOfUserAccelerometerY = listResultOfUserAccelerometer[1];
    resultOfUserAccelerometerZ = listResultOfUserAccelerometer[2];
  }

  List getResultScore() {
    return [
      resultOfAccelerometerX,
      resultOfAccelerometerY,
      resultOfAccelerometerZ,
      resultOfGyroscopeX,
      resultOfGyroscopeY,
      resultOfGyroscopeZ,
      resultOfUserAccelerometerX,
      resultOfUserAccelerometerY,
      resultOfUserAccelerometerZ,
    ];
  }
}
