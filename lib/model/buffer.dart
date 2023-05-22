import 'index.dart';

class Buffer {
  List x;
  List y;
  List z;
  int numList;
  final SumResult score = SumResult();
  Buffer(this.x, this.y, this.z, this.numList);
  int hashBrake = 0;
  bool hashBrakeStatus = false;
  void pushData(String xData, String yData, String zData) {
    x.add(xData);
    y.add(yData);
    z.add(zData);
  }

  void reset() {
    x = [];
    y = [];
    z = [];
  }

  int calculateUserAccelerometerListBuffer() {
    hashBrake = 0;
    for (var i = 0; i < numList; i++) {
      if (x[i] != null) {
        if (x[i] <= -6 || y[i] <= -6 || z[i] <= -6) {
          hashBrakeStatus = true;
        }
        if (hashBrakeStatus && (x[i] >= -2 || y[i] >= -2 || z[i] >= -2)) {
          hashBrakeStatus = false;
          hashBrake += 1;
        }
      }
    }
    reset();
    return hashBrake;
  }

  List getListXBuffer() {
    return x;
  }

  List getListYBuffer() {
    return y;
  }

  List getListZBuffer() {
    return z;
  }
}
