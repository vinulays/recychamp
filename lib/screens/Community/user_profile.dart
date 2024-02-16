import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late String _profilePicUrl = 'profilePicUrl';
  late String username = 'username';
  final picker = ImagePicker();
  File? _selectedImage;
  File? _selectedVideo;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _videoController = VideoPlayerController.file(_selectedVideo!);
    _videoController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Future<void> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        username = userData['username'];
        _profilePicUrl = userData['profilePicUrl'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 50,
                // ignore: unnecessary_null_comparison
                backgroundImage: NetworkImage(_profilePicUrl)),
            const SizedBox(height: 20),
            Text(
              username ?? 'Loading...',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              Image.file(_selectedImage!) // Display selected image
            else if (_selectedVideo != null)
              VideoPlayer(_videoController) // Display selected video
            else
              const Text('No media selected'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _chooseImage();
              },
              child: const Text('Choose Image'), // select image
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _chooseVideo();
              },
              child: const Text('Choose Video'), //select video
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _chooseImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      // Upload image to Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = ref.putFile(_selectedImage!);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Save post data to Firestore
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('posts').add({
        'userId': user?.uid,
        'username': username,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> _chooseVideo() async {
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      setState(() {
        _selectedVideo = File(pickedVideo.path);
      });
      // Upload video to Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('videos')
          .child('${DateTime.now().millisecondsSinceEpoch}.mp4');
      UploadTask uploadTask = ref.putFile(File(pickedVideo.path));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String videoUrl = await snapshot.ref.getDownloadURL();

      // Save post data to Firestore
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('posts').add({
        'userId': user?.uid,
        'username': username,
        'videoUrl': videoUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}
