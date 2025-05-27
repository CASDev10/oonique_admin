import 'dart:html';

class CookieManagerRepository {
  static CookieManagerRepository? _manager;

  static CookieManagerRepository? getInstance() {
    _manager ??= CookieManagerRepository();
    return _manager;
  }

  void addToCookie(String key, String value) {
    // 2592000 sec = 30 days.
    document.cookie = "$key=$value; max-age=2592000; path=/;";
  }

  String getCookie(String key) {
    String? cookies = document.cookie;
    List<String> listValues = cookies!.isNotEmpty ? cookies.split(";") : [];
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String key0 = map[0].trim();
      String val = map[1].trim();
      if (key == key0) {
        matchVal = val;
        break;
      }
    }
    return matchVal;
  }
}
