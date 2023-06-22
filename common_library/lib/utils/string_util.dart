
class StringUtil  {

  static bool isBlank(String? str) {
    return str == null || str == '' ? true : false;
  }

  static String? parseInt(int? data) {
    if (data == null) {
      return null;
    }

    return data.toString();
  }

  static int? toInt(String? data) {
    if (data == null || data == '') {
      return null;
    }

    return int.parse(data);
  }

}
