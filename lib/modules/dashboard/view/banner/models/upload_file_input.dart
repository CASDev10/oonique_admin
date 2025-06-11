import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType

class UploadFileInput {
  final Uint8List bytes;
  final String fileName;
  final String mimeType;

  UploadFileInput({
    required this.bytes,
    required this.fileName,
    required this.mimeType,
  });

  factory UploadFileInput.fromJson(Map<String, dynamic> json) {
    return UploadFileInput(
      bytes: json['bytes'],
      fileName: json['filePath'],
      mimeType: json['mimeType'],
    );
  }

  Future<MultipartFile> toMultipartFile() async {
    return MultipartFile.fromBytes(
      bytes,
      filename: fileName,
      contentType: MediaType.parse(mimeType),
    );
  }
}
