// ignore_for_file: non_constant_identifier_names
import 'dart:math';

class Finance {
  
  static num fv({
    required num rate,
    required num nper,
    required num pmt,
    required num pv,
    bool end = true
  }) {
    final int when = end ? 0 : 1;
    final num temp = pow(1 + rate, nper);
    final num fact = (rate == 0) ? nper : ((1 + rate * when) * (temp - 1) / rate);
    return -(pv * temp + pmt * fact);
  }

  static num pmt({
    required num rate,
    required num nper,
    required num pv,
    num fv = 0,
    bool end = true
  }) {
    final int when = end ? 0 : 1;
    final num temp = pow(1 + rate, nper);
    final num maskedRate = (rate == 0) ? 1 : rate;
    final num fact = (rate == 0)
    ? nper
    : ((1 + maskedRate * when) * (temp - 1) / maskedRate);
    return -(fv + pv * temp) / fact;
  }

  static num nper({
    required num rate,
    required num pmt,
    required num pv,
    num fv = 0,
    bool end = true
  }) {
    final int when = end ? 0 : 1;

    try {
      final num A = -(fv + pv) / pmt;
      final num z = pmt * (1 + rate * when) / rate;
      final num B = log((-fv + z) / (pv + z)) / log(1 + rate);
      return (rate == 0) ? A : B;
    } catch (e) {
      return (-fv + pv) / pmt;
    }
  }

  static num ipmt({
    required num rate,
    required num per,
    required num nper,
    required num pv,
    num fv = 0,
    bool end = true
  }) {
    final num totalPmt = pmt(rate: rate, nper: nper, pv: pv, fv: fv, end: end);
    num ipmt = _rbl(rate: rate, per: per, pmt: totalPmt, pv: pv, end: end) * rate;
    ipmt = end ? ipmt : ipmt / (1 + rate);
    ipmt = (!end && (per == 1)) ? 0 : ipmt;
    return ipmt;
  }

  static num _rbl({
    required num rate,
    required num per,
    required num pmt,
    required num pv,
    bool end = true
  }) {
    return fv(rate: rate, nper: per - 1, pmt: pmt, pv: pv, end: end);
  }

  static num ppmt({
    required num rate,
    required num per,
    required num nper,
    required num pv,
    num fv = 0,
    bool end = true
  }) {
    final num total = pmt(rate: rate, nper: nper, pv: pv, fv: fv, end: end);
    return total - ipmt(rate: rate, per: per, nper: nper, pv: pv, fv: fv, end: end);
  }

  static num pv({
    required num rate,
    required num nper,
    required num pmt,
    required num fv,
    bool end = true
  }) {
    final int when = end ? 0 : 1;
    final num temp = pow(1 + rate, nper);
    final num fact = (rate == 0) ? nper : ((1 + rate * when) * (temp - 1) / rate);
    return -(fv + pmt * fact) / temp;
  }

  static num _g_div_gp(num r, num n, num p, num x, num y, num w) {
    final num t1 = pow(r + 1, n);
    final num t2 = pow(r + 1, n - 1);
    return (y + t1 * x + p * (t1 - 1) * (r * w + 1) / r) /
        (n * t2 * x -
            p * (t1 - 1) * (r * w + 1) / pow(r, 2) +
            n * p * t2 * (r * w + 1) / r +
            p * (t1 - 1) * w / r);
  }

  static num rate({
    required num nper,
    required num pmt,
    required num pv,
    required num fv,
    bool end = true,
    num guess = 0.1,
    num tol = 1e-6,
    num maxIter = 100
  }) {
    final int when = end ? 0 : 1;

    num rn = guess;
    num iterator = 0;
    bool close = false;
    while ((iterator < maxIter) && !close) {
      final num rnp1 = rn - _g_div_gp(rn, nper, pmt, pv, fv, when);
      final num diff = (rnp1 - rn).abs();
      close = diff < tol;
      iterator += 1;
      rn = rnp1;
    }

    return rn;
  }

  static num npv({required num rate, required List<num> values}) {
    return List<int>.generate(values.length, (int index) => index)
        .map((int index) => values[index] / pow(1 + rate, index))
        .fold(0, (num p, num c) => p + c);
  }

  static num _npvPrime({required num rate, required List<num> values}) {
    return List<int>.generate(values.length, (int index) => index)
        .map((int index) => -index * values[index] / pow(1 + rate, index + 1))
        .fold(0, (num p, num c) => p + c);
  }

  static num _npv_div_npvPrime(num rate, List<num> values) {
    final num t1 = npv(rate: rate, values: values);
    final num t2 = _npvPrime(rate: rate, values: values);
    return t1 / t2;
  }

  static num irr({
    required List<num> values,
    num guess = 0.1,
    num tol = 1e-6,
    num maxIter = 100
  }) {
    num rn = guess;
    num iterator = 0;
    bool close = false;
    while ((iterator < maxIter) && !close) {
      final num rnp1 = rn - _npv_div_npvPrime(rn, values);
      final num diff = (rnp1 - rn).abs();
      close = diff < tol;
      iterator += 1;
      rn = rnp1;
    }

    return rn;
  }
}