import 'package:bloc_project_structure/common_widgets/common_text.dart';
import 'package:bloc_project_structure/common_widgets/textfield_search_custom.dart';
import 'package:bloc_project_structure/until/app_colors.dart';
import 'package:bloc_project_structure/until/fonts_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonTextField extends StatefulWidget {
  final FocusNode focusNodeController;
  final Widget? prefix;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final String? suffix;
  final Widget? suffixWidget;
  final String? label;
  final String? Function(String?)? validatorFunc;
  final Function(String?)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function()? onTab;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function()? onTapOfSuffix;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? padding;
  final bool? isVisibleLabel;
  final Color? textColor;
  final Color? cursorColor;
  final Color? labelColor;
  final bool readOnly;
  final bool autoFocus;
  final bool isLoading;
  final bool viewLoading;

  const CommonTextField(
      {required this.focusNodeController,
      this.prefix,
      this.prefixIconSize,
      this.suffix,
      this.suffixWidget,
      this.label,
      this.textColor,
      this.cursorColor,
      this.labelColor,
      this.validatorFunc,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onTab,
      this.controller,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType,
      this.obscureText = false,
      this.readOnly = false,
      this.autoFocus = true,
      this.viewLoading = false,
      this.isLoading = false,
      this.isVisibleLabel = true,
      this.onTapOfSuffix,
      this.inputFormatters,
      this.textInputAction = TextInputAction.next,
      this.suffixIconSize,
      this.onChange,
      this.padding = EdgeInsets.zero,
      super.key});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible:
              widget.isVisibleLabel! && widget.focusNodeController.hasFocus,
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.028),
            child: CommonAppText(
              text: widget.label!,
              fontSize: FontSizeConstant.font_15,
              fontWeight: FontWeightConstant.bold,
              color: widget.labelColor ?? AppColors.primaryColorOne,
            ),
          ),
        ),
        Padding(
          padding: widget.padding!,
          child: TextFormField(
            autofocus: widget.autoFocus,
            readOnly: widget.readOnly,
            onTap: widget.onTab,
            focusNode: widget.focusNodeController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            textCapitalization: widget.textCapitalization,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChange,
            obscuringCharacter: "*",
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete,
            decoration: InputDecoration(
              prefixIcon: widget.prefix ?? const SizedBox.shrink(),
              suffixIcon: widget.viewLoading
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: Center(
                          child: widget.isLoading
                              ? const CircularProgressIndicator()
                              : Container()))
                  : widget.suffix == null
                      ? widget.suffixWidget ?? const SizedBox.shrink()
                      : widget.suffixWidget ??
                          GestureDetector(
                            onTap: widget.onTapOfSuffix,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    bottom: 5, left: 0, right: 5, top: 0),
                                child: SvgPicture.asset(
                                  widget.suffix!,
                                  height: widget.suffixIconSize ?? 15,
                                )),
                          ),
              // labelText: label,
              // hintText: widget.focusNodeController.hasFocus ? "" : widget.label,
              hintText: widget.focusNodeController.hasFocus ? "" : widget.label,
              hintStyle: TextStyle(
                  color: widget.textColor ?? AppColors.textFieldColor,
                  fontWeight: FontWeightConstant.regular,
                  fontSize: FontSizeConstant.font_15),
              contentPadding:
                  const EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 5),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.textFieldColor,
              )),
              errorStyle: const TextStyle(
                  color: AppColors.textFieldColor,
                  fontWeight: FontWeightConstant.regular,
                  fontSize: FontSizeConstant.font_13),
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.textFieldColor,
              )),
              focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.textFieldColor,
              )),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.textFieldColor,
              )),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                color:widget.textColor ?? AppColors.textFieldColor,
              )),
              prefixIconConstraints: widget.prefix == null
                  ? const BoxConstraints(minHeight: 0, minWidth: 0)
                  : const BoxConstraints(minHeight: 10, minWidth: 22),
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 10, minWidth: 22),
              isDense: true,
              fillColor: widget.textColor ?? AppColors.primaryColorOne,
            ),
            // if(widget.cursorColor)
            cursorColor: widget.cursorColor ?? AppColors.blackTextColor,
            style: TextStyle(
                fontSize: FontSizeConstant.font_15,
                fontWeight: FontWeightConstant.medium,
                color: widget.textColor ?? AppColors.blackTextColor),
            validator: widget.validatorFunc,
          ),
        ),
      ],
    );
  }
}

class SearchableTextField extends StatefulWidget {
  final FocusNode focusNodeController;
  final List<String> listOfValue;
  final Widget? prefix;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final String? suffix;
  final String? label;
  final String? Function(String?)? validatorFunc;
  final Function(String?)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function()? onTab;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function()? onTapOfSuffix;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry padding;
  final Function(String val)? getSelectedValue;
  final bool Function(bool isOpen)? isMatching;

  const SearchableTextField({
    super.key,
    required this.focusNodeController,
    required this.listOfValue,
    required this.isMatching,
    this.prefixIconSize,
    this.getSelectedValue,
    this.suffix,
    this.label,
    this.validatorFunc,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTab,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.obscureText = false,
    this.onTapOfSuffix,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.suffixIconSize,
    this.padding = EdgeInsets.zero,
    this.onChange,
    this.prefix,
  });

  @override
  State<SearchableTextField> createState() => _SearchableTextFieldState();
}

class _SearchableTextFieldState extends State<SearchableTextField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: widget.focusNodeController.hasFocus,
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.028),
            child: CommonAppText(
              text: widget.label!,
              fontSize: FontSizeConstant.font_15,
              fontWeight: FontWeightConstant.bold,
              color: AppColors.whiteBackgroundColor,
            ),
          ),
        ),
        Padding(
          padding: widget.padding,
          child: TextFieldSearch(
            isMatching: widget.isMatching,
            onSelectValue: widget.getSelectedValue,
            onTabFunction: widget.onTab,
            focusNodeController: widget.focusNodeController,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChange: widget.onChange,
            controller: widget.controller,
            decoration: InputDecoration(
              prefix: widget.prefix == null
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onTap: widget.onTapOfSuffix,
                      child: widget.prefix,
                    ),
              suffixIcon: widget.suffix == null
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onTap: widget.onTapOfSuffix,
                      child: Container(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 0, right: 5, top: 0),
                          child: SvgPicture.asset(
                            widget.suffix!,
                            height: widget.suffixIconSize ?? 15,
                          )),
                    ),
              // labelText: label,
              hintText: widget.focusNodeController.hasFocus ? "" : widget.label,
              hintStyle: const TextStyle(
                  color: AppColors.primaryColorOne,
                  fontWeight: FontWeightConstant.regular,
                  fontSize: FontSizeConstant.font_15),
              contentPadding:
                  const EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 5),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.textFieldColor,
              )),
              errorStyle: const TextStyle(
                  color:  AppColors.textFieldColor,
                  fontWeight: FontWeightConstant.regular,
                  fontSize: FontSizeConstant.font_13),
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color:  AppColors.textFieldColor,
              )),
              focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color:  AppColors.textFieldColor,
              )),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.textFieldColor,
              )),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.textFieldColor,
              )),

              prefixIconConstraints:
                  const BoxConstraints(minHeight: 10, minWidth: 22),
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 10, minWidth: 22),
              isDense: true,
              fillColor: AppColors.primaryColorOne,
            ),
            textStyle: const TextStyle(
                fontSize: FontSizeConstant.font_15,
                fontWeight: FontWeightConstant.medium,
                color: AppColors.blackTextColor),
            validatorFunc: widget.validatorFunc,
            future: () {
              return fetchSimpleData(context);
            },
          ),
        ),
      ],
    );
  }

  // mocking a future
  Future<List> fetchSimpleData(BuildContext context) async {
    return widget.listOfValue;
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? textInputTpe;
  final String? hintText;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? enabled;
  final bool? filled;
  final int? maxLines;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {super.key,
      this.controller,
      this.enabled,
      this.textInputTpe,
      this.hintText,
      this.label,
      this.suffixIcon,
      this.prefixIcon,
      this.filled,
      this.obscureText,
      this.validator,
      this.inputFormatters,
      this.maxLines = 1});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputTpe,
      obscureText: widget.obscureText ?? false,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        focusColor: AppColors.primaryColorOne,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 1, color: AppColors.textFieldColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: AppColors.textFieldColor.withOpacity(0.2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: AppColors.primaryColorOne.withOpacity(0.8), width: 1),
        ),
        isDense: false,
        contentPadding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        hintText: widget.hintText,
        labelText: widget.label,
        fillColor: Colors.white,
        filled: widget.filled,
        labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textFieldColor.withOpacity(0.5).withOpacity(0.8)),
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textFieldColor.withOpacity(0.5).withOpacity(0.8)),
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 50, maxWidth: 50),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
      ),
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textFieldColor),
    );
  }
}
