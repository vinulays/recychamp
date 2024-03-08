import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<List<int>?> ImagePick(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  final XFile? file;

  try {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      file = File(pickedFile.path) as XFile?;
      return await file?.readAsBytes();
    }
  } catch (e) {
    print('Error picking image: $e');
  }

  return null;
}
