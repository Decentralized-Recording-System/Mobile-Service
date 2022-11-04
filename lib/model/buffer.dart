import 'index.dart';

class Buffer {
  List x;
  List y;
  List z;
  int numList;
  final SumResult score = SumResult();
  late List list = [];
  Buffer(this.x, this.y, this.z, this.numList);

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

  List calculate() {
    for (var i = 0; i < numList; i++) {
      if (x[i] != null) {
        score.x = score.x + double.parse(x[i]);
        score.y = score.y + double.parse(y[i]);
        score.z = score.z + double.parse(z[i]);
      }
    }
    reset();
    list = [score.x, score.y, score.z];
    score.reset();
    return list;
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
