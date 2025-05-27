import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType
import 'package:oonique/constants/constants.dart';
import 'package:oonique/core/storage_service/storage_service.dart';
import 'package:path/path.dart' as path;

import '../../core/di/service_locator.dart';

final StorageService _storageService = sl<StorageService>();
double getCellSpacing(BuildContext context, Size size) {
  double width = size.width;

  if (width >= 1100) {
    return width * 0.07; // Desktop
  } else if (width >= 850) {
    return width * 0.09; // Tablet
  } else {
    return width * 0.15; // Mobile
  }
}

double getIdCellSpacing(BuildContext context, Size size) {
  double width = size.width;

  if (width >= 1100) {
    return width * 0.04; // Desktop
  } else if (width >= 850) {
    return width * 0.06; // Tablet
  } else {
    return width * 0.10; // Mobile
  }
}

double getDialogueWidth(BuildContext context, Size size) {
  double width = size.width;

  if (width >= 1100) {
    return width * 0.4; // Desktop
  } else if (width >= 850) {
    return width * 0.3; // Tablet
  } else {
    return width; // Mobile
  }
}

Future<Map<String, dynamic>?> pickImageFileWeb() async {
  final completer = Completer<Map<String, dynamic>?>();
  final uploadInput = html.FileUploadInputElement()..accept = 'image/*';
  uploadInput.click();

  uploadInput.onChange.listen((e) {
    final file = uploadInput.files?.first;
    if (file != null) {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((e) {
        completer.complete({
          'fileName': file.name,
          'bytes': reader.result as Uint8List,
        });
      });
    } else {
      completer.complete(null);
    }
  });

  return await completer.future;
}

List<String> getAllKeys(dynamic json) {
  final keys = <String>{};

  void extractKeys(dynamic value) {
    if (value is Map<String, dynamic>) {
      for (final entry in value.entries) {
        keys.add(entry.key);
        extractKeys(entry.value);
      }
    } else if (value is List) {
      for (final item in value) {
        extractKeys(item);
      }
    }
  }

  extractKeys(json);
  return keys.toList();
}

setToken(String token) async {
  await _storageService.setString(StorageKeys.tokenValue, "Bearer $token");
}

getToken() async {
  final token = await _storageService.getString(StorageKeys.tokenValue);
  return token;
}

Future<MultipartFile> changeMultiFromBytes({
  required Uint8List bytes,
  required String filePath,
  required String mimeType,
}) async {
  String fileName = path.basename(filePath);
  final mediaType = MediaType.parse(mimeType);

  return MultipartFile.fromBytes(
    bytes,
    filename: fileName,
    contentType: mediaType,
  );
}

double getCellSpacingSupport(BuildContext context, Size size) {
  double width = size.width;

  if (width >= 1100) {
    return width * 0.09; // Desktop
  } else if (width >= 850) {
    return width * 0.11; // Tablet
  } else {
    return width * 0.17; // Mobile
  }
}

double getIdCellSpacingSupport(BuildContext context, Size size) {
  double width = size.width;

  if (width >= 1100) {
    return width * 0.06; // Desktop
  } else if (width >= 850) {
    return width * 0.08; // Tablet
  } else {
    return width * 0.12; // Mobile
  }
}
