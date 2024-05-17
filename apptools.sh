#!/bin/bash

commands=(
"$DART_HOME/pub run build_runner build"
"$FLUTTER_HOME/flutter packages pub run build_runner build --delete-conflicting-outputs"
"$FLUTTER_HOME/flutter packages pub run build_runner watch"
"$DART_HOME/dart run build_assets.dart"
"$FLUTTER_HOME/flutter pub run icons_launcher:create"
"$FLUTTER_HOME/flutter pub run flutter_native_splash:create"
"$FLUTTER_HOME/flutter pub run flutter_native_splash:remove"
"$FLUTTER_HOME/flutter build web --web-renderer html"
)

echo Your DART_HOME: $DART_HOME
echo Your FLUTTER_HOME: $FLUTTER_HOME
echo
echo Please select a command.
echo ==============================
for i in "${!commands[@]}"
do
  echo "$i) ${commands[i]}"
done
echo ==============================
echo
echo "Default selection command"
echo "${commands[1]}"
echo
read -p "Enter command id:" command_id
if
  [[ $command_id == "" ]]
then
  ${commands[1]}
else
  ${commands[command_id]}
fi

