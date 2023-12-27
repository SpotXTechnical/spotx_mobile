import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:owner/utils/flavors.dart';

import 'main.dart';

void main() {
  FlavorConfig(name: BuildVariant.develop.name, variables: {
    FlavorsVariables.baseUrlKey: 'https://api-stage.spotx.app/api',
  });
  runSpotXApp();
}