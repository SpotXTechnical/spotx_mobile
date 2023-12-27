import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:spotx/utils/flavors.dart';

import 'main.dart';

void main() {
  FlavorConfig(name: BuildVariant.develop.name, variables: {
    FlavorsVariables.baseUrlKey: 'https://api.spotx.app/api',
  });
  runSpotXApp();
}