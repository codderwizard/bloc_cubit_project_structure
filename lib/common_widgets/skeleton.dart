// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:wollette/main.dart';
// import 'package:wollette/until/app_colors.dart';
//
// class Skeleton extends StatefulWidget {
//   final double height;
//   final double width;
//   final EdgeInsets? padding;
//   final EdgeInsets? margin;
//
//   const Skeleton({Key? key, this.height = 20, this.width = 200,this.margin,this.padding }) : super(key: key);
//
//   @override
//   createState() => SkeletonState();
// }
//
// class SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
//   AnimationController? _controller;
//
//   Animation? gradientPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
//
//     gradientPosition = Tween<double>(
//       begin: -3,
//       end: 10,
//     ).animate(
//       CurvedAnimation(
//           parent: _controller!,
//           curve: Curves.linear
//       ),
//     )..addListener(() {
//       setState(() {});
//     });
//
//     _controller!.repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width:  widget.width,
//       height: widget.height,
//       margin: widget.margin,
//       padding: widget.padding,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//           gradient: LinearGradient(
//               begin: Alignment(gradientPosition!.value, 0),
//               end: const Alignment(-1, 0),
//               colors: MyApp.themeNotifier.value == ThemeMode.dark
//               ? [
//                 const Color.fromRGBO(31, 94, 143, 1.0),
//                 AppColors.dropDownSelectedBackgroundColor.withOpacity(0.5),
//                 const Color.fromRGBO(31, 94, 143, 1.0),
//               ]
//               : [
//                 Colors.white,
//                 AppColors.lightGreyColor90.withOpacity(0.5),
//                 Colors.white,
//               ]
//           )
//       ),
//     );
//   }
// }
//
// Widget simmerEffectCommon({required Widget childView}){
//   return Shimmer.fromColors(
//     baseColor: MyApp.themeNotifier.value == ThemeMode.light ? AppColors.lightGreyColor20 : AppColors.dropDownSelectedBackgroundColor,
//     highlightColor: MyApp.themeNotifier.value == ThemeMode.light ? AppColors.whiteBackgroundColor : AppColors.transparentBlueColor,
//     period: const Duration(milliseconds: 2000),
//     child: childView,
//   );
// }
//
// Widget shimmerHomeEffectCommon({required Widget childView}){
//   return Shimmer.fromColors(
//     baseColor: MyApp.themeNotifier.value == ThemeMode.light ? AppColors.lightGreyColor20 : AppColors.lightBlueBgColor,
//     highlightColor: MyApp.themeNotifier.value == ThemeMode.light ? AppColors.whiteBackgroundColor : AppColors.dropDownSelectedBackgroundColor,
//     period: const Duration(milliseconds: 2000),
//     child: childView,
//   );
// }