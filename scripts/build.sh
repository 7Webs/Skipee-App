#!/bin/bash

flutter clean;
flutter pub get;
flutter build apk;
cd ./build/app/outputs/flutter-apk || exit;

echo Press enter to open the build output folder;
read enter;

explorer .