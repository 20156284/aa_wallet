// ===============================================
// primitive_utils
//
// Create by Will on 2020/10/26 8:27 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

bool toBool(dynamic value) {
  if (value == null) {
    return false;
  } else if (value is bool) {
    return value;
  } else if (value is int) {
    return value.toBool();
  } else if (value is String) {
    return value.toBool();
  }

  // NotNull means TRUE
  return true;
}

extension BoolExt on bool {
  int toInt() => this ? 1 : 0;
}

extension IntExt on int {
  bool toBool() => this != 0;
}

extension StringExt on String {
  bool toBool() {
    return this != '0' && toLowerCase() != 'false';
  }

  String limitLength(int limit, {String ext = ''}) {
    if (runes.length <= limit) return this;
    return String.fromCharCodes(runes, 0, limit) + ext;
  }

  // 抹除开头的0
  String stripLeadingZeros() {
    final pattern = RegExp(r'^0+');
    return replaceAll(pattern, '');
  }

  // 抹除末尾的0
  String stripTrailingZeros() {
    final pattern = RegExp(r'([.]{1}0*)(?!.*\d)');
    return replaceAll(pattern, '');
  }

  // 抹除非数字的字符
  String stripNotNum() {
    final pattern = RegExp(r'[^0-9]*');
    return replaceAllMapped(pattern, (match) => '');
  }

  String addCommasInNum() {
    final pattern = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return replaceAllMapped(pattern, (match) => '${match[1]},');
  }

  /// Samples:
  /// /var/mobile/Containers/Data/Application/F871B628-A1D9-4283-B28B-66C11F9A8C2C/Library/Application Support/HyphenateSDK/appdata/1305716957139439618/1305750348605952001/c5b1d180-3546-11eb-a796-3faafbe44389.aac
  /// /var/mobile/Containers/Data/Application/F871B628-A1D9-4283-B28B-66C11F9A8C2C/Documents/voiceMessage/9d12ca7e-a82c-4fec-b878-4ec43ef99091.aac
  String replaceAppleSandBoxId(String runtimePath) {
    final pattern =
        RegExp(r'/[0-9A-F]+-[0-9A-F]+-[0-9A-F]+-[0-9A-F]+-[0-9A-F]+/');
    final newIdMatch = pattern.firstMatch(runtimePath);
    final newId = newIdMatch?.group(0);

    if (newId == null) return this;

    return replaceFirst(pattern, newId);
  }
}

extension IterableExt<T> on Iterable<T> {
  Iterable<T> divide(T divider) {
    return expand((child) sync* {
      yield divider;
      yield child;
    }).skip(1);
  }

  dynamic getOrNull(int index) {
    if (index >= 0 && index < length) {
      if (this is List) {
        return (this as List)[index];
      } else {
        return elementAt(index);
      }
    }

    return null;
  }

  bool isBlank() {
    for (final e in this) {
      if (e != null) {
        return false;
      }
    }

    return true;
  }

  bool compareElements(Iterable? b) {
    if (this == b) {
      return true;
    } else if (b == null) {
      return false;
    } else if (length != b.length) {
      return false;
    }

    final iteratorA = iterator;
    final iteratorB = b.iterator;
    while (iteratorA.moveNext()) {
      iteratorB.moveNext();
      if (iteratorA.current != iteratorB.current) {
        return false;
      }
    }

    return true;
  }
}
