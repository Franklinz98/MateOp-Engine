import 'dart:math';

abstract class Curves {
  static int hiperbolic(int time) {
    var k = 19.88;
    var r = 1.682;
    var p = 1.004;
    var arriba = (time + p);
    var abajo = (time + r + r);
    var frac = (arriba / abajo);
    var buenas = (k * frac) - (k - 15);
    return buenas.round();
  }

  static int gaus(int time) {
    var A = -15.3;
    var B = 0;
    var C = -6;
    var D = 15.20;
    var arriba = (time - B) * (time - B);
    var abajo = (C * C);
    double frac = -(arriba / abajo);
    double e = 2.71828182846;
    double expo;
    expo = pow(e, frac);
    var buenas = A * expo + D;
    return buenas.round();
  }
}
