import 'package:flutter/cupertino.dart';

class KeyboardUtils {
  static bool isKeyboardShowing(BuildContext context) {
    // Check if the keyboard is currently showing.
    final bottomInset = View.of(context).viewInsets.bottom;
    return bottomInset != 0;
  }

  static closeKeyboard(BuildContext context) {
    // Get the current focus node.
    final focusNode = FocusScope.of(context);

    // If the focus node does not have the primary focus, then unfocus it.
    if (!focusNode.hasPrimaryFocus) {
      focusNode.unfocus();
    }
  }

  // A convenience method that checks if the keyboard is showing and closes it if it is.
  static void closeIfKeyboardShowing(BuildContext context) {
    if (isKeyboardShowing(context)) {
      closeKeyboard(context);
    }
  }
}
