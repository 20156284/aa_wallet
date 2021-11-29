flutter build apk --target-platform android-arm,android-arm64 --split-per-abi --dart-define=APP_ENV=$1
cd ./build/app/outputs/flutter-apk
cp app-armeabi-v7a-release.apk $1.apk
mv  $1.apk ..