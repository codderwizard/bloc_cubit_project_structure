import 'package:bloc_project_structure/common_widgets/common_text.dart';
import 'package:bloc_project_structure/until/fonts_constant.dart';
import 'package:flutter/material.dart';

Widget commonProfileWidget(
    {Widget? leadingWidget, String? text, Widget? actionWidget}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leadingWidget ?? Container(width: 5),
        const SizedBox(
          width: 4,
        ),
        CommonAppText(
            text: text,
            fontSize: FontSizeConstant.font_16,
            fontWeight: FontWeightConstant.bold),
        const Spacer(),
        Visibility(visible: actionWidget != null, child: actionWidget!),
      ],
    ),
  );
}

Widget commonDivider({required Color color,double? thickness}) {
  return Divider(
    thickness: thickness ?? 1,
    color: color,
  );
}

