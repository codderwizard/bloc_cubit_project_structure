import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


/// Date Extension
extension DateExtension on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);

  /// The comparison is independent of whether the time is in UTC or
  /// in the local time zone.
  bool isBeforeDate(DateTime other) => dateOnly.isBefore(other.dateOnly);

  /// The comparison is independent of whether the time is in UTC or
  /// in the local time zone.
  bool isAfterDate(DateTime other) => dateOnly.isAfter(other.dateOnly);

  /// Returns true if [this] falls between [date1] and [date2] irrespective
  /// of the order in the Calender.
  bool isBetween(DateTime date1, DateTime date2) =>
      (isAfter(date1) && isBefore(date2)) ||
      (isAfter(date2) && isBefore(date1));

  /// Formats date using [DateFormat] from intl package.
  String format(String pattern) => DateFormat(pattern).format(this);

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isToday {
    final nowDate = DateTime.now();
    return year == nowDate.year && month == nowDate.month && day == nowDate.day;
  }

  bool get isYesterday {
    final nowDate = DateTime.now();
    const oneDay = Duration(days: 1);
    return nowDate.subtract(oneDay).isSameDate(this);
  }

  /// Time Ago
  ///
  /// Returns string of time difference between given DateTime and
  /// [DateTime.now()] in the format 1d, 2h, 4s or Just now
  String get timeAgo {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(this);

    if (difference.inDays < 0) {
      return '${difference.inDays.abs()}d remaining';
    }

    if (difference.inDays >= 1) {
      return '${difference.inDays}d';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inSeconds >= 1) {
      return '${difference.inSeconds}s';
    } else {
      return 'Just now';
    }
  }
}

/// Num Extension
extension NumExtension on num {
  ///   print('+ wait for 2 seconds');
  ///   await 2.delay();
  ///   print('- 2 seconds completed');
  ///   print('+ callback in 1.2sec');
  ///   1.delay(() => print('- 1.2sec callback called'));
  ///   print('currently running callback 1.2sec');
  Future delay([FutureOr Function()? callback]) async => Future.delayed(
        Duration(milliseconds: (this * 1000).round()),
        callback,
      );

  /// print(1.seconds + 200.milliseconds);
  /// print(1.hours + 30.minutes);
  /// print(1.5.hours);
  ///```
  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());

  bool isLowerThan(num b) => this < b;

  bool isGreaterThan(num b) => this > b;

  bool isEqual(num b) => this == b;
}

/// Sized box Double Extension
extension SizeBoxDoubleExtension on double {
  Widget get w => SizedBox(width: this);

  Widget get h => SizedBox(height: this);
}

/// Sized box Int Extension
extension SizeBoxIntExtension on num {
  Widget get w => SizedBox(width: double.tryParse(toString()));

  Widget get h => SizedBox(height: double.tryParse(toString()));

  /// Border Radius
  BorderRadiusGeometry get borderRadius =>
      BorderRadius.circular(double.parse(toString()));

  /// Circular Radius
  Radius get cRadius => Radius.circular(toDouble());

  /// Padding All
  EdgeInsets get padAll => EdgeInsets.all(toDouble());

  /// Padding symmetric vertical
  EdgeInsets get padSV => EdgeInsets.symmetric(vertical: toDouble());

  /// Padding symmetric horizontal
  EdgeInsets get padSH => EdgeInsets.symmetric(horizontal: toDouble());
}

/// String Nullable Extension
extension StringExtension on String? {
  /// Returns `true` if the string is either `null` or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  /// Returns `true` if the string is neither null nor empty.
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Checks if string is a valid username.
  bool get isValidUsername =>
      hasMatch(r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is phone number.
  bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is phone number.
  bool get isValidPhoneNumber {
    if (isNullOrEmpty || this!.length > 16 || this!.length < 9) return false;
    return hasMatch(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Capitalize each word inside string
  /// Example: your name => Your Name, your name => Your name
  String capitalize() {
    if (this == null) return this ?? '';
    return (this ?? '').split(' ').map((e) => e.capitalize()).join(' ');
  }

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  String capitalizeFirst() {
    if (this == null) return this ?? '';
    return (this ?? '')[0].toUpperCase() +
        (this ?? '').substring(1).toLowerCase();
  }

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  String removeAllWhitespace() {
    return (this ?? '').replaceAll(' ', '');
  }

  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this ?? '');
  }

  bool get isStrongPassword {
    if ((this ?? '').isNotEmpty) {
      return false;
    }
    var regex = RegExp(
        r'^(?=.*([A-Z]){1,})(?=.*[!@#$&*]{1,})(?=.*[0-9]{1,})(?=.*[a-z]{1,}).{8,100}$');
    return regex.hasMatch(this!);
  }

  /// Checks if string consist only numeric.
  /// Numeric only doesn't accepting "." which double data type have
  bool isNumericOnly() => hasMatch(r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  bool isAlphabetOnly() => hasMatch(r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  bool hasCapitalLetter() => hasMatch(r'[A-Z]');

  /// Checks if string is boolean.
  bool isBool() {
    return (this == 'true' || this == 'false');
  }

  /// Returns true if [this] happens to be an email
  /// This uses RFC822 email validation specs which is widely accepted.
  /// check this: https://regexr.com/2rhq7
  /// Original Ref: https://www.ietf.org/rfc/rfc822.txt
  bool get isEmail => RegExp(
          r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
          caseSensitive: false)
      .hasMatch(this ?? '');
}

extension StringNonNullableExtension on String {
  /// Whether this [String] is txt.
  bool get isTxt => toLowerCase().hasMatch(r'.txt$');

  /// Whether this [String] is word.
  bool get isDoc => toLowerCase().hasMatch(r'.(doc|docx)$');

  /// Whether this [String] is excel.
  bool get isExcel => toLowerCase().hasMatch(r'.(xls|xlsx)$');

  /// Whether this [String] is ppt.
  bool get isPpt => toLowerCase().hasMatch(r'.(ppt|pptx)$');

  /// Whether this [String] is apk.
  bool get isApk => toLowerCase().hasMatch(r'.apk$');

  /// Whether this [String] is pdf.
  bool get isPdf => toLowerCase().hasMatch(r'.pdf$');

  /// Whether this [String] is html.
  bool get isHtml => toLowerCase().hasMatch(r'.html$');

  /// Returns `true` if the string is either `null` or empty.
  bool get isNullOrEmpty => isEmpty;

  /// Returns `true` if the string is neither null nor empty.
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Capitalize each word inside string
  /// Example: your name => Your Name, your name => Your name
  String capitalize() {
    if (isEmpty) return this ?? '';
    return split(' ').map((e) => e.capitalize()).join(' ');
  }

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  String capitalizeFirst() {
    if (isEmpty) return this ?? '';
    return this[0].toUpperCase() + (this ?? '').substring(1).toLowerCase();
  }

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  String removeAllWhitespace() {
    return replaceAll(' ', '');
  }

  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  bool get isStrongPassword {
    if ((this ?? '').isNotEmpty) {
      return false;
    }
    var regex = RegExp(
        r'^(?=.*([A-Z]){1,})(?=.*[!@#$&*]{1,})(?=.*[0-9]{1,})(?=.*[a-z]{1,}).{8,100}$');
    return regex.hasMatch(this);
  }

  /// Checks if string consist only numeric.
  /// Numeric only doesn't accepting "." which double data type have
  bool isNumericOnly() => hasMatch(r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  bool isAlphabetOnly() => hasMatch(r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  bool hasCapitalLetter() => hasMatch(r'[A-Z]');

  /// Checks if string is boolean.
  bool isBool() {
    return (this == 'true' || this == 'false');
  }

  /// Returns true if [this] happens to be an email
  /// This uses RFC822 email validation specs which is widely accepted.
  /// check this: https://regexr.com/2rhq7
  /// Original Ref: https://www.ietf.org/rfc/rfc822.txt
  bool get isEmail => RegExp(
          r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
          caseSensitive: false)
      .hasMatch(this);

  // Copy String to Clipboard
  Future<void> copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: trim()));
  }
}

/// List Extensions for nullable [List].
extension NullableListX<T> on List<T>? {
  /// Returns true if this nullable [List] is either null or empty.
  bool get isEmptyOrNull => this?.isEmpty ?? true;

  /// Creates empty [List] if this nullable [List] is null,
  /// otherwise returns this [List].
  List<T> get orEmpty => this ?? [];
}

/// Shimmer Effect Extension
extension ShimmerEffect on Widget {

  /// Padding All
  Padding padAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  /// Padding Symmetric
  Padding padS({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      ),
      child: this,
    );
  }
}

/// Duration Extensions
extension GetDurationUtils on Duration {
  ///  await Duration(seconds: 1).delay();
  Future<void> get delay => Future.delayed(this);
}

/// Responsive with context
extension Responsive on BuildContext {
  T responsive<T>(
    T defaultVal, {
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    final wd = MediaQuery.of(this).size.width;
    return wd >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultVal)
        : wd >= 1024
            ? (lg ?? md ?? sm ?? defaultVal)
            : wd >= 768
                ? (md ?? sm ?? defaultVal)
                : wd >= 640
                    ? (sm ?? defaultVal)
                    : defaultVal;
  }
}

/// List Widget Extensions
extension StyledList<E> on List<Widget> {
  Widget toColumn({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Widget? separator,
  }) =>
      Column(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        // textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: separator != null && isNotEmpty
            ? (expand((child) => [child, separator]).toList()..removeLast())
            : this,
      );

  Widget toRow({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Widget? separator,
  }) =>
      Row(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        // textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: separator != null && isNotEmpty
            ? (expand((child) => [child, separator]).toList()..removeLast())
            : this,
      );

  Widget toStack({
    Key? key,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    // TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
    List<Widget> children = const <Widget>[],
  }) =>
      Stack(
        key: key,
        alignment: alignment,
        // textDirection: textDirection,
        fit: fit,
        clipBehavior: clipBehavior,
        children: this,
      );

  Widget toWrap({
    Key? key,
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    double spacing = 0.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 0.0,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
    List<Widget> children = const <Widget>[],
  }) =>
      Wrap(
        key: key,
        direction: direction,
        alignment: alignment,
        spacing: spacing,
        runAlignment: runAlignment,
        runSpacing: runSpacing,
        crossAxisAlignment: crossAxisAlignment,
        // textDirection: textDirection,
        verticalDirection: verticalDirection,
        clipBehavior: clipBehavior,
        children: this,
      );
}

/// List Widget Extensions
extension LitExtension<T> on List<T> {
  List<T> removeDuplication() {
    final uniqueSet = HashSet<T>();
    final resultList = <T>[];

    for (final item in this) {
      if (uniqueSet.add(item)) {
        resultList.add(item);
      }
    }
    return resultList;
  }
}
