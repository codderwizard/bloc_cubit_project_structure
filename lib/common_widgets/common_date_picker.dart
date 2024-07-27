import 'package:bloc_project_structure/common_widgets/common_text.dart';
import 'package:bloc_project_structure/until/app_colors.dart';
import 'package:bloc_project_structure/until/fonts_constant.dart';
import 'package:flutter/material.dart';

class DateRangePicker extends StatelessWidget {
  final String text;
  final String date;
  final VoidCallback onTap;

  const DateRangePicker({
    Key? key,
    required this.text,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonAppText(
          text: text,
          fontSize: FontSizeConstant.font_15,
          fontWeight: FontWeight.w400,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.blackTextColor.withOpacity(0.3),
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.width * 0.03),
              child: Center(
                child: CommonAppText(
                  text: date,
                  fontSize: FontSizeConstant.font_13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
