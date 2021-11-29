// ===============================================
// text_editing_controller_utils
// 
// Create by Will on 2020/10/30 6:05 PM
// Copyright @flutter_core_kit.All rights reserved.
// ===============================================

import 'package:flutter/widgets.dart';

extension TextEditingControllerExt on TextEditingController {
  void enter(String input) {
    if (selection.isValid) {
      text = text.replaceRange(
        selection.start,
        selection.end,
        input,
      );
    } else {
      text = '$text$input';
    }
  }

  void backspace() {
    if (text.isEmpty) {
      return;
    } else if (selection.isValid) {
      enter('');
    } else {
      final runes = text.runes;
      final newRunes = runes.take(runes.length - 1);
      text = String.fromCharCodes(newRunes);
    }
  }
}
