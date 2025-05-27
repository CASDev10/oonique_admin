import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';

class WebImagePicker extends StatefulWidget {
  @override
  _WebImagePickerState createState() => _WebImagePickerState();
}

class _WebImagePickerState extends State<WebImagePicker> {
  Uint8List? _imageData;
  String? _fileName;
  bool _uploading = false;

  void _pickImage() {
    final uploadInput = html.FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final file = uploadInput.files?.first;
      if (file != null) {
        final reader = html.FileReader();

        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((e) {
          setState(() {
            _imageData = reader.result as Uint8List;
            _fileName = file.name;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _imageData != null
            ? Image.memory(
              _imageData!,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            )
            : Text('No image selected.'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _uploading ? null : _pickImage,
          child: Text(_uploading ? 'Uploading...' : 'Pick and Upload Image'),
        ),
      ],
    );
  }
}
