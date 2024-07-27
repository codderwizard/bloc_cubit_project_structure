import 'package:bloc_project_structure/common_widgets/common_text.dart';
import 'package:bloc_project_structure/until/app_colors.dart';
import 'package:bloc_project_structure/until/fonts_constant.dart';
import 'package:flutter/material.dart';

///Application Common Button
class CommonAppButton extends StatelessWidget {
  final double buttonWidth ;
  final double? buttonHeight;
  final String? buttonText;
  final EdgeInsetsGeometry? padding;
  final Color? buttonColor ;
  final Color? textColor;
  final Function()? buttonTap;

  const CommonAppButton(
      {this.buttonWidth = double.infinity,
        this.buttonHeight = 50,
        this.buttonText,
        this.padding,
        this.textColor,
        this.buttonColor,
        this.buttonTap,
        super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: buttonHeight,
      width: buttonWidth,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color:  buttonColor ?? AppColors.primaryColorOne,
          borderRadius: BorderRadius.circular(15)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: buttonTap,
        child: Center(
          child: CommonAppText(
              text: buttonText ?? "",
              fontSize: FontSizeConstant.font_18,
              color: textColor ?? AppColors.whiteTextColor,
              fontWeight: FontWeightConstant.bold
          ),
        ),
      ),
    );
  }
}