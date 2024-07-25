import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  late User _user;
  String? _profileImageUrl;

  final List<String> _defaultImages = [
    'assets/images/gym-c.png',
    'assets/images/lotus-c.png',
    'assets/images/food-c.png',
  ];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _profileImageUrl = _user.photoURL ?? _getRandomDefaultImage();
  }

  String _getRandomDefaultImage() {
    final random = Random();
    return _defaultImages[random.nextInt(_defaultImages.length)];
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      okLabel: 'Logout',
      cancelLabel: 'Cancel',
      isDestructiveAction: true,
    );

    if (result == OkCancelResult.ok) {
      await _auth.signOut();
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Here you should upload the image to your backend and get the URL
      // For example, you can use Firebase Storage
      // After uploading, set the _profileImageUrl to the URL of the uploaded image
      setState(() {
        _profileImageUrl =
            pickedFile.path; // Temporary, replace with uploaded image URL
      });
    }
  }

  Future<void> _updateProfile(String name) async {
    try {
      await _user.updateDisplayName(name);
      await _user.reload();
      setState(() {
        _user = _auth.currentUser!;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _confirmLogout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImageUrl!.startsWith('assets/')
                    ? AssetImage(_profileImageUrl!) as ImageProvider
                    : FileImage(File(_profileImageUrl!)),
                child: _profileImageUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Change Profile Picture'),
              ),
              const SizedBox(height: 16),
              Text(
                _user.displayName ?? 'No name',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                _user.email ?? 'No email',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showEditProfileDialog(context);
                },
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final _nameController = TextEditingController(text: _user.displayName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateProfile(_nameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
