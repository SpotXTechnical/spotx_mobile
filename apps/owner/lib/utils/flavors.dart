import 'package:flutter_flavor/flutter_flavor.dart';

enum BuildVariant { develop, live }

abstract class FlavorsVariables {
  static const String baseUrlKey = 'baseUrlKey';
}

bool isLiveApp() => BuildVariant.live.name == FlavorConfig.instance.name;
bool isDevelopApp() => BuildVariant.develop.name == FlavorConfig.instance.name;
