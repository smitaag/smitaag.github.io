class Utils {
  static String? validateMobile(String value) {
    var potentialNumber = int.tryParse(value);

    if (potentialNumber == null) return 'Enter a valid phone number';

    if ((value.length > 10)) {
      return 'Enter a valid phone number';
    } else if ((value.length < 8)) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }
}
