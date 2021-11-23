// ===============================================
// directory_extension
// 
// Create by will on 2/23/21 7:50 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================


import 'dart:io';

extension DirectoryExtension on Directory {
  Future<Directory> getChild({
    required String childName,
    bool createIfNotExist = true,
  }) {
    final childPath = '$path${Platform.pathSeparator}$childName';
    final directory = Directory(childPath);

    if (createIfNotExist) {
      return directory.create();
    }

    return Future.value(directory);
  }
}