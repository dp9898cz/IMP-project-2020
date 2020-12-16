import "package:http/http.dart" as http;

class HTTP {
  static Future<int> espLed(int led, bool state) async {
    var url =
        'http://192.168.4.1/LED' + led.toString() + (state ? 'ON' : 'OFF');
    try {
      var resp = await http.post(url);
      if (resp.statusCode == 204) {
        return 0;
      }
      return 1;
    } catch (e) {
      return 1;
    }
  }

  static Future<int> espSequence() async {
    var url = 'http://192.168.4.1/SEQUENCE';
    try {
      var resp = await http.post(url);
      if (resp.statusCode == 204) {
        return 0;
      }
      return 1;
    } catch (e) {
      return 1;
    }
  }
}
