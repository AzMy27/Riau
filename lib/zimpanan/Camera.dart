import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.front,
    );
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Akses Kamera'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20.0),
        alignment: Alignment.topCenter,
        child: _image == null
            ? const Text('Tidak ada gambar')
            : Image.file(
                _image!,
                width: 300.0,
                fit: BoxFit.fitHeight,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Ambil Foto',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
