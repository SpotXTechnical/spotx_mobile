import 'dart:ui';

const Locale arabicLocale = Locale('ar');
const Locale englishLocale = Locale('en');
const List<Locale> localeList = [englishLocale, arabicLocale];

const assetsFolder = 'assets';
const imagesFolder = 'images';
const iconSize = 18.0;

const Map<String, String> sortTypes = {
  latest: descOrderType,
  lowToHighPrice: ascOrderType,
  highToLowPrice: descOrderType
};
const latest = "Latest";
const lowToHighPrice = "Low To High Price";
const highToLowPrice = "High To Low Price";
const descOrderType = "desc";
const ascOrderType = "asc";
const orderByDefaultPrice = "default_price";
const orderByCreatedAt = "created_at";
const perPageCount = 12;
const String termsConditions = 'https://spotx.app/terms';
const String privacyPolicy = 'https://spotx.app/privacy';
const String cancellationPolicy = 'https://spotx.app/policy';