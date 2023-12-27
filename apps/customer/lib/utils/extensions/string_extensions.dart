extension StringExtensions on String? {
  String replaceHttps() {
    if (this == null) {
      return '';
    }
    return this!.replaceAll('https://', 'http://');
  }
}