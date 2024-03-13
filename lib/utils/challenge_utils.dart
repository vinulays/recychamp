import 'dart:io';

Future<String> getImageSize(File image) async {
  int sizeInBytes = await image.length();
  String sizeString;
  if (sizeInBytes < 1024) {
    sizeString = '${sizeInBytes}B';
  } else if (sizeInBytes < 1024 * 1024) {
    sizeString = '${(sizeInBytes / 1024).toStringAsFixed(2)}KB';
  } else {
    sizeString = '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(2)}MB';
  }
  return sizeString;
}
