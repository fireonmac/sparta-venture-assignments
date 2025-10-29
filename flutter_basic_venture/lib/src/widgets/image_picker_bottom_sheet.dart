import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(File?) onImageSelected;

  const ImagePickerBottomSheet({
    super.key,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '사진 선택',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('갤러리'),
            onTap: () async {
              Navigator.pop(context);
              final pickedFile = await picker.pickImage(
                source: ImageSource.gallery,
              );
              onImageSelected(pickedFile != null ? File(pickedFile.path) : null);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('카메라'),
            onTap: () async {
              Navigator.pop(context);
              final pickedFile = await picker.pickImage(
                source: ImageSource.camera,
              );
              onImageSelected(pickedFile != null ? File(pickedFile.path) : null);
            },
          ),
        ],
      ),
    );
  }
}
