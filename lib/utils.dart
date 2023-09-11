import 'package:flutter/material.dart';
import 'package:flutter_rtc_prep/enums.dart';
import 'package:flutter_rtc_prep/styles/styles.dart';
import 'package:go_router/go_router.dart';

class Utils {

  static void showAlertDialog(
      {required AlertDialogType type,
      required String title,
      required String content,
      required BuildContext context,
      bool cancelOnTitle = false,
      Function? onOptionSelected}) {
    List<Widget> optionBtns = [];

    // quick function to capture the selected option
    // and to bubble it up to the caller, and then
    // right after pop the dialog
    btnFunction(AlertDialogOptions selectedOption) {
      onOptionSelected != null ? onOptionSelected(selectedOption) : () {};
      GoRouter.of(context).pop();
    }

    // depending on the type of alert, generate
    // the appropriate buttons
    switch (type) {
      case AlertDialogType.ok:
        optionBtns =
            getAlertButtonsFromOptions([AlertDialogOptions.ok], btnFunction);
        break;
      case AlertDialogType.okCancel:
        optionBtns = getAlertButtonsFromOptions(
            [AlertDialogOptions.ok, AlertDialogOptions.cancel], btnFunction);
        break;
      case AlertDialogType.yesNo:
        optionBtns = getAlertButtonsFromOptions(
            [AlertDialogOptions.yes, AlertDialogOptions.no], btnFunction);
        break;
      case AlertDialogType.yesNoCancel:
        optionBtns = getAlertButtonsFromOptions([
          AlertDialogOptions.yes,
          AlertDialogOptions.no,
          AlertDialogOptions.cancel
        ], btnFunction);
        break;
    }

    // show the alert dialog
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(title, style: RTCPrepStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold
            )),
            content: Text(content, style: RTCPrepStyles.labelMedium),
            actions: optionBtns,
          );
        });
  }

  static List<TextButton> getAlertButtonsFromOptions(
      List<AlertDialogOptions> options, Function event) {
    // given the list of alert options and an event
    // generate a list of TextButtons for the alert
    return options
        .map((option) => TextButton(
            onPressed: () => event(option),
            child: Text(option.name.toTitleCase(),
                style: RTCPrepStyles.labelMedium)))
        .toList();
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}