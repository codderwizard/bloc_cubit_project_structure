import 'dart:io';

import 'package:bloc_project_structure/common_widgets/common_button.dart';
import 'package:bloc_project_structure/common_widgets/common_text.dart';
import 'package:bloc_project_structure/until/app_colors.dart';
import 'package:bloc_project_structure/until/app_strings.dart';
import 'package:bloc_project_structure/until/logger.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestCameraPermission(BuildContext context) async {
  if(Platform.isAndroid) {
    PermissionStatus status = await Permission.camera.status;
    logger.info("Camera status -- $status");
    if (status.isGranted) {
      return true;
    }
    PermissionStatus newStatus = await Permission.camera.request();
    if (newStatus.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied && newStatus.isPermanentlyDenied) {
      if (context.mounted) {
        showCameraPermissionDialog(context,true);
      }
    }
    return false;
  }else{
    PermissionStatus status = await Permission.camera.status;
    logger.info("Camera status -- $status");
    if (status.isGranted) {
      return true;
    }
    PermissionStatus newStatus = await Permission.camera.request();
    if (newStatus.isGranted) {
      return true;
    }
    logger.info("Camera newStatus -- $newStatus");
    if (newStatus.isPermanentlyDenied) {
      if (context.mounted) {
        showCameraPermissionDialog(context,true);
      }
    }
    return false;
  }
}

Future<bool> requestGalleryPermission(BuildContext context) async {
  if(Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    logger.info("Version sdk == ${androidInfo.version.sdkInt}");
    if (androidInfo.version.sdkInt <= 32) {
      PermissionStatus status = await Permission.storage.status;
      if (status.isGranted) {
        return true;
      }
      PermissionStatus newStatus = await Permission.storage.request();
      if (newStatus.isGranted) {
        return true;
      }
      if (status.isPermanentlyDenied && newStatus.isPermanentlyDenied) {
        if (context.mounted) {
          showCameraPermissionDialog(context,false);
        }
      }
      return false;
    } else {
      PermissionStatus status = await Permission.photos.status;
      if (status.isGranted) {
        return true;
      }
      PermissionStatus newStatus = await Permission.photos.request();
      if (newStatus.isGranted) {
        return true;
      }
      if (status.isPermanentlyDenied && newStatus.isPermanentlyDenied) {
        if (context.mounted) {
          showCameraPermissionDialog(context,false);
        }
      }
      return false;
    }
  }
  else{
    PermissionStatus status = await Permission.photos.status;
    logger.info("Gallery status -- $status");
    if (status.isGranted) {
      return true;
    }
    PermissionStatus newStatus = await Permission.photos.request();
    if (newStatus.isGranted) {
      return true;
    }
    logger.info("Gallery status newStatus -- $newStatus");
    if (newStatus.isPermanentlyDenied) {
      if (context.mounted) {
        showCameraPermissionDialog(context,false);
      }
    }

    // Otherwise, the permission was not granted, so return false.
    return false;
  }
}

Future<void> showCameraPermissionDialog(BuildContext context,bool isFromCamera) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: CommonAppText(
          text: isFromCamera ? AppStrings.cameraPermissionDenied : AppStrings.galleryPermissionDenied,
          color: AppColors.blackTextColor,
        ),
        content: CommonAppText(
          text: isFromCamera ? AppStrings.cameraPermissionDeniedSubLabel: AppStrings.galleryPermissionDeniedSubLabel,
          color: AppColors.blackTextColor,
          textAlignment: TextAlign.start,
        ),
        actions: [
          CommonAppButton(
            buttonText: AppStrings.goToSettings,
            buttonTap: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            buttonWidth: 180,
            buttonHeight: 40,
          ),
        ],
      );
    },
  );
}

Future<String> getTempFilePathFromMemoryImage(MemoryImage memoryImage) async {
  // Create a new temporary file.
  File tempFile = File('${Directory.systemTemp.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.png');

  // Write the bytes from the `MemoryImage` object to the temporary file.
  await tempFile.writeAsBytes(memoryImage.bytes);

  // Get the path to the temporary file.
  String tempFilePath = tempFile.path;

  return tempFilePath;
}

Future<bool> checkLocationPermission({required BuildContext context}) async {
  bool status = await Permission.location.isGranted;
  logger.info("Location status -- $status");
  if (status) {
    return true;
  }
  PermissionStatus newStatus = await Permission.location.request();
  if (newStatus.isGranted) {
    return true;
  }
  logger.info("Location status newStatus -- $newStatus");
  if (newStatus.isPermanentlyDenied) {
    if (context.mounted) {
      showLocationPermissionDialog(context);
    }
  }
  return false;
}

Future<void> showLocationPermissionDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const CommonAppText(
          text: AppStrings.locationPermissionDenied,
          color: AppColors.blackTextColor,
        ),
        content: const CommonAppText(
          text: AppStrings.locationPermissionDeniedSubLabel,
          color: AppColors.blackTextColor,
          textAlignment: TextAlign.start,
        ),
        actions: [
          CommonAppButton(
            buttonText: AppStrings.goToSettings,
            buttonTap: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            buttonWidth: MediaQuery.of(context).size.width * 0.35,
            buttonHeight: 40,
          ),
        ],
      );
    },
  );
}