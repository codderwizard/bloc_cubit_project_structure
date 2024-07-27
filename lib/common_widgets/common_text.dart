import 'package:bloc_project_structure/until/app_colors.dart';
import 'package:bloc_project_structure/until/fonts_constant.dart';
import 'package:flutter/material.dart';


///Application Common Text
class CommonAppText extends StatelessWidget {
  final Color? color ;
  final Color? fontShadowColor;
  final Color? decorationColor;
  final double? fontSize;
  final double? decorationThickness;
  final double? height;
  final double? fontShadowBlurRadius;
  final double? letterSpacing;
  final String? text;
  final TextAlign? textAlignment;
  final FontWeight? fontWeight ;
  final int? maxLine ;
  final String? fontFamily;
  final TextDecoration? textDecoration;

  const CommonAppText(
      {
        this.text,
        this.color,
        this.fontShadowColor,
        this.decorationColor,
        this.fontSize,
        this.decorationThickness,
        this.height,
        this.fontShadowBlurRadius,
        this.letterSpacing = 0.4,
        this.textAlignment,
        this.fontWeight = FontWeightConstant.medium,
        this.maxLine = 5,
        this.fontFamily = FontFamilyConstant.openSansCondensed,
        this.textDecoration,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      maxLines: maxLine,
      textScaleFactor : 1.0,
      textAlign: textAlignment ?? TextAlign.center,
      style: TextStyle(
          shadows: [
            Shadow(
              blurRadius: fontShadowBlurRadius ?? 0,  // shadow blur
              color: fontShadowColor ?? Colors.transparent, // shadow color
              offset: const Offset(2.0,2.0), // how much shadow will be shown
            ),
          ],
          letterSpacing: letterSpacing ?? 0,
          color:  AppColors.blackTextColor,
          fontSize: fontSize,
          height: height,
          decoration: textDecoration ?? TextDecoration.none,
          decorationThickness: decorationThickness ?? 2,
          decorationColor: decorationColor ?? AppColors.primaryColorOne,
          fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis,
          fontFamily: fontFamily),
    );
  }
}
