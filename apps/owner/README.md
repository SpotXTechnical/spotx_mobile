# reservation mobile owner

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:
# to generate the new locale
# Create easy_localization auto-generated classes
run the following command from the project directory:
<<% flutter pub run easy_localization:generate -S ./assets/translations -f keys -o locale_keys.g.dart>>

# to generate copyWith generated files
<< flutter pub run build_runner build >>
# unit testing
app depend on bloc_test and mocktail for unit testing
# to run all tests:
run the following command from the project directory:
<< flutter test >>
## Build APP
flutter pub run build_runner build --delete-conflicting-outputs

## Android
using fast lane:

flutter build apk --target=lib/main_dev.dart --release
flutter build apk --target=lib/main_live.dart --release
flutter build appbundle --target=lib/main_live.dart --release

## Ios
flutter build ios --target=lib/main_dev.dart --release
flutter build ios --target=lib/main_live.dart --release
