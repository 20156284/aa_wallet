// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as path_lib;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:sprintf/sprintf.dart';
import 'package:yaml/yaml.dart';

// 删除未链接的文件
const bool _deleteUnlinkedFiles = false;
// 打印未使用的链接
const bool _printUnusedLinks = false;
// 删除未使用的链接和相关文件
const bool _deleteUnusedLinksAndFiles = false;

final File _pubspecFile = File('pubspec.yaml');
final String _assetsClassPath = path_lib.join('lib', 'assets', 'res.dart');
final Directory _assetsDirectory = Directory('assets');
final Directory _libDirectory = Directory('lib');

const String _assetsClassName = 'Res';
const String _assetsClassHeaderLine = 'class $_assetsClassName {';
const String _assetsClassFieldLine = "\tstatic const String %s = '%s';";
const String _assetsClassFooterLine = '}';

final RegExp _resolutionDirectory = RegExp('/[0-9]+.0/');
final RegExp _fileNameDelimiter = RegExp(r'[^\da-zA-Z]');

Future<void> main() {
  final String pubspecStr = _pubspecFile.readAsStringSync();
  final Pubspec pubspec = Pubspec.parse(
    pubspecStr,
    sourceUrl: _pubspecFile.uri,
  );
  // 读取pubspec.yaml
  final YamlList assets = pubspec.flutter!['assets'] as YamlList;
  final List<String> linkList = <String>[];

  // 遍历pubspec.yaml，归整所有文件
  for (final dynamic value in assets) {
    final String path = value.toString();
    if (path.endsWith('/')) {
      final Directory directory = Directory(path);
      final Iterable<String> subLinks = _listFiles(directory).map((File e) {
        return path_lib.split(e.path).join('/');
      });

      linkList.addAll(subLinks);
      continue;
    }

    linkList.add(path);
  }

  // 文件排序
  linkList.sort();

  // 文件去重
  final Set<String> linkSet = linkList.map((String e) {
    return e.replaceFirst(_resolutionDirectory, '');
  }).toSet();

  // 打印未链接的文件
  final List<File> unlinkedFiles = _findUnlinkedFiles(linkSet);
  if (unlinkedFiles.isNotEmpty) {
    print('未链接的文件：');
    for (final File file in unlinkedFiles) {
      print(file.path);
    }
    print('（共${unlinkedFiles.length}个）');
    print('');
  }

  // 删除未链接的文件
  if (_deleteUnlinkedFiles && unlinkedFiles.isNotEmpty) {
    print('正在删除未链接的文件...');
    for (final File file in unlinkedFiles) {
      print('删除 ${file.path}');
      file.deleteSync();
    }
    print('');
  }

  // 打印未使用的链接
  IOSink? pubspecSink;
  if (_printUnusedLinks || _deleteUnusedLinksAndFiles) {
    print('正在查找未使用的链接...');
    final DateTime beginTime = DateTime.now();

    final List<String> unusedLinks = linkSet.toList();
    final Iterable<File> dartFiles =
        _listFiles(_libDirectory, true).where((File element) {
      return path_lib.extension(element.path).toLowerCase().endsWith('.dart');
    });
    for (final File file in dartFiles) {
      if (path_lib.equals(file.path, _assetsClassPath)) {
        continue;
      }

      final String fileStr = file.readAsStringSync();
      unusedLinks.removeWhere((String link) {
        return fileStr.contains(link) ||
            fileStr.contains('$_assetsClassName.${_toFieldName(link)}');
      });
    }

    if (_printUnusedLinks) {
      unusedLinks.forEach(print);

      final DateTime endTime = DateTime.now();
      final Duration consumedTime = endTime.difference(beginTime);
      print('（共${unusedLinks.length}个，用时 $consumedTime）');
      print('');
    }

    if (_deleteUnusedLinksAndFiles && unusedLinks.isNotEmpty) {
      // 删除未使用的链接
      print('正在删除未使用的链接...');
      linkSet.removeWhere(unusedLinks.contains);

      // 删除相关文件
      print('正在删除相关文件...');
      final List<File> unusedFiles =
          _listFiles(_assetsDirectory, true).where((File file) {
        for (final String link in unusedLinks) {
          if (_isPointToFile(file, link)) {
            return true;
          }
        }
        return false;
      }).toList(growable: false);
      int deleteCount = 0;
      for (final File file in unusedFiles) {
        print('删除 ${file.path}');
        file.deleteSync();
        deleteCount++;
      }
      print('（共删除$deleteCount个文件）');

      // 覆写pubspec文件
      print('正在写入pubspec.yaml...');
      final List<String> pubspecLines = LineSplitter.split(pubspecStr).toList()
        ..removeWhere((String line) {
          const String linePrefix = '- ';
          line = line.trim();

          if (line.startsWith(linePrefix)) {
            for (final String link in unusedLinks) {
              if (line == '$linePrefix$link') {
                return true;
              }
            }
          }

          return false;
        });
      pubspecSink = _pubspecFile.openWrite(mode: FileMode.writeOnly);
      pubspecLines.forEach(pubspecSink.writeln);
      print('');
    }
  }

  // 写入类文件
  print('正在写入${path_lib.basename(_assetsClassPath)}...');
  final File classFile = File(_assetsClassPath);
  final IOSink classFileSink = classFile.openWrite(mode: FileMode.writeOnly)
    ..writeln(_assetsClassHeaderLine);
  for (final String link in linkSet) {
    final String fieldName = _toFieldName(link);
    final String fieldLine = sprintf(
      _assetsClassFieldLine,
      <String>[fieldName, link],
    );
    classFileSink.writeln(fieldLine);
  }
  classFileSink.writeln(_assetsClassFooterLine);

  return Future.wait(<Future<void>>[
    classFileSink.flush().whenComplete(classFileSink.close),
    if (pubspecSink != null)
      pubspecSink.flush().whenComplete(pubspecSink.close),
  ]);
}

/// [recurseSubs] 递归目录下的所有文件
/// https://flutter.cn/docs/development/ui/assets-and-images#specifying-assets
Iterable<File> _listFiles(Directory directory, [bool recurseSubs = false]) {
  return directory.listSync().expand((FileSystemEntity element) {
    if (element is File) {
      if (element.path.contains('.DS_Store')) {
        return const <File>[];
      }
      return <File>[element];
    } else if (recurseSubs && element is Directory) {
      return _listFiles(element, true);
    }
    return const <File>[];
  });
}

/// 驼峰命名法，替换所有特殊字符
String _toFieldName(String path) {
  int start = path.indexOf('/');
  if (start == -1) {
    start = 0;
  }
  int end = path.lastIndexOf('.');
  if (end == -1) {
    end = path.length;
  }
  final List<String> parts =
      path.substring(start + 1, end).split(_fileNameDelimiter);

  for (int i = 0; i < parts.length; i++) {
    if (i == 0) {
      continue;
    }
    parts[i] = parts[i].capitalize();
  }

  return parts.join();
}

List<File> _findUnlinkedFiles(Iterable<String> links) {
  final Iterable<File> allFiles = _listFiles(_assetsDirectory, true);

  final List<File> unlinkedFiles = <File>[];
  for (final File file in allFiles) {
    final String? find = links.firstWhereOrNull((String element) {
      return _isPointToFile(file, element);
    });
    if (find == null) {
      unlinkedFiles.add(file);
    }
  }

  return unlinkedFiles;
}

bool _isPointToFile(File file, String link) {
  final List<String> fileFragments = path_lib.split(file.path);
  final List<String> linkFragments = path_lib.split(link);

  if (fileFragments.last != linkFragments.last) {
    return false;
  }

  // 链接的长度与真实路径的长度相等或少1位（由于变体的存在）
  final int diffLen = fileFragments.length - linkFragments.length;
  if (diffLen < 0 || diffLen > 1) {
    return false;
  }

  final int parentLen = min(fileFragments.length, linkFragments.length) - 1;
  for (int i = 0; i < parentLen; i++) {
    if (fileFragments[i] != linkFragments[i]) {
      return false;
    }
  }

  return true;
}

extension _StringExtension on String {
  /// 首字母大写
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
