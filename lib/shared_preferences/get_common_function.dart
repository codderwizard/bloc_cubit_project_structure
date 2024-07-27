import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String?> getDeviceToken() async {
  // const storage = FlutterSecureStorage();
  // return await storage.read(key: dotenv.env['DEVICE_TOKEN']!);
  // return await SharedPrefUtils().getStringValue(SharedKeys.deviceToken);
  return "";
}

Future<String?> getPublicKeyToken() async {
  // const storage = FlutterSecureStorage();
  // return await storage.read(key: dotenv.env['PUBLIC_KEY']!);
  // return await SharedPrefUtils().getStringValue(SharedKeys.publicKey);
  return "";
}

int calculateTimeDifferenceInMinutes(String timestamp) {
  // Parse the timestamp string into a DateTime object
  DateTime dateTime = DateTime.parse(timestamp);

  // Calculate the time difference in minutes
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  // Return the time difference in minutes
  return difference.inMinutes;
}

DateTimeRange getCurrentMonthDateRange() {
  DateTime now = DateTime.now();
  int currentMonth = now.month;

  DateTime firstDayOfMonth = DateTime(now.year, currentMonth, 1);

  DateTime lastDayOfMonth = DateTime(now.year, currentMonth + 1, 0, 23, 59, 59, 999);

  return DateTimeRange(start: firstDayOfMonth, end: lastDayOfMonth);
}

List<String> getMonthDates({required int monthNumber, required int year}) {
  DateTime firstDay = DateTime(year, monthNumber, 1);
  DateTime lastDay = DateTime(year, monthNumber + 1, 0, 23, 59, 59, 999);

  String formattedFirstDay = "${firstDay.toIso8601String()}Z";
  String formattedLastDay = "${lastDay.toIso8601String()}Z";

  List<String> dateList = [formattedFirstDay, formattedLastDay];

  return dateList;
}

List<String> getServerSideCurrentMonthDateRange() {
  DateTime now = DateTime.now();
  int currentMonth = now.month;

  String firstDayOfMonth =
      "${DateTime(now.year, currentMonth, 1).toIso8601String()}Z";
  String lastDayOfMonth =
      "${DateTime(now.year, currentMonth + 1, 0, 23, 59, 59, 999).toIso8601String()}Z";

  List<String> dateList = [firstDayOfMonth, lastDayOfMonth];
  return dateList;
}

String getServerSideCurrentDate(String date) {
  DateTime now = DateTime.parse(date);

  String firstDayOfMonth =
      "${DateTime(now.year, now.month, now.day).toIso8601String()}Z";

  return firstDayOfMonth.toString();
}

DateTime getServerSideCurrentDateTime() {
  DateTime now = DateTime.now().toUtc();

  String currentDateTime =
      "${DateTime(now.year, now.month, now.day,now.hour,now.minute,now.second).toIso8601String()}Z";

  return DateTime.parse(currentDateTime.toString());
}

String getServerSideEndDate(String date) {
  DateTime now = DateTime.parse(date);

  String firstDayOfMonth =
      "${DateTime(now.year, now.month, now.day,23, 59, 59, 999).toIso8601String()}Z";

  return firstDayOfMonth.toString();
}

