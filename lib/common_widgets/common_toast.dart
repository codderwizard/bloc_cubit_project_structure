import 'package:bloc_project_structure/until/app_colors.dart';
import 'package:flutter/material.dart';

// ToastFuture commonToast(
//     {required BuildContext context, required String message}) {
//   return showToast(message.trim(),
//       context: context,
//       animation: StyledToastAnimation.slideFromTopFade,
//       reverseAnimation: StyledToastAnimation.slideToTopFade,
//       position:
//           const StyledToastPosition(align: Alignment.topCenter, offset: 0.0),
//       startOffset: const Offset(0.0, -3.0),
//       reverseEndOffset: const Offset(0.0, -3.0),
//       duration: const Duration(seconds: 4),
//       //Animation duration   animDuration * 2 <= duration
//       animDuration: const Duration(seconds: 1),
//       curve: Curves.fastLinearToSlowEaseIn,
//       reverseCurve: Curves.fastOutSlowIn,
//       backgroundColor: MyApp.themeNotifier.value == ThemeMode.dark
//           ? AppColors.whiteBackgroundColor
//           : AppColors.primaryColorTwo,
//       textStyle: TextStyle(
//           color: MyApp.themeNotifier.value == ThemeMode.dark
//               ? AppColors.textFieldBlackColor
//               : AppColors.whiteTextColor,
//           fontWeight: FontWeightConstant.medium,
//           fontSize: FontSizeConstant.font_15));
// }

void commonToast({required BuildContext context,required String message}) {
  final snackBar = SnackBar(
    content: Text(
       message,
      textAlign : TextAlign.start,
      style: const TextStyle(color: AppColors.whiteTextColor),
    ),
    backgroundColor: AppColors.primaryColorOne,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: AppColors.whiteTextColor,
      onPressed: () {
        //Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}