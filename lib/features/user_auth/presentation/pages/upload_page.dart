// // lib/screens/upload_screen.dart

// import 'package:flutter/material.dart';

// class UploadPage extends StatefulWidget {
//   final Function(String, String, String) onSubmit;

//   UploadPage({required this.onSubmit});

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _textController = TextEditingController();
//   final TextEditingController _imageUrlController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(labelText: 'Text'),
//             ),
//             TextField(
//               controller: _imageUrlController,
//               decoration: InputDecoration(labelText: 'Image URL'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 widget.onSubmit(
//                   _usernameController.text,
//                   _textController.text,
//                   _imageUrlController.text,
//                 );
//                 Navigator.pop(context);
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
// import 'dart:html' as html;

// class UploadPage extends StatefulWidget {
//   final Function(String username, String text, String imageUrl) onSubmit;

//   UploadPage({required this.onSubmit});

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _textController = TextEditingController();
//   File? _image;
//   String? _imageUrl;

//   Future<void> _pickImage() async {
//     if (html.window.navigator.userAgent.contains('Mobile')) {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });

//         // Upload image to Firebase Storage
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('uploads/${DateTime.now().toIso8601String()}');
//         final uploadTask = storageRef.putFile(_image!);
//         final snapshot = await uploadTask.whenComplete(() {});
//         final imageUrl = await snapshot.ref.getDownloadURL();

//         setState(() {
//           _imageUrl = imageUrl;
//         });
//       }
//     } else {
//       // For Web
//       final input = html.FileUploadInputElement()..accept = 'image/*';
//       input.click();
//       input.onChange.listen((e) async {
//         final files = input.files!;
//         if (files.isEmpty) return;

//         final reader = html.FileReader();
//         reader.readAsDataUrl(files[0]);
//         reader.onLoadEnd.listen((e) {
//           final dataUrl = reader.result as String;
//           setState(() {
//             _imageUrl = dataUrl; // Use the data URL directly for Web
//           });
//         });
//       });
//     }
//   }

//   void _submitPost() {
//     final username = _usernameController.text;
//     final text = _textController.text;

//     if (username.isNotEmpty && text.isNotEmpty && _imageUrl != null) {
//       widget.onSubmit(username, text, _imageUrl!);
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Post'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(labelText: 'Text'),
//             ),
//             SizedBox(height: 10),
//             _image != null
//                 ? Image.file(_image!)
//                 : _imageUrl != null
//                     ? Image.network(_imageUrl!)
//                     : Text('No image selected.'),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _submitPost,
//               child: Text('Submit Post'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
// import 'dart:html' as html;

// class UploadPage extends StatefulWidget {
//   final Function(String username, String text, String imageUrl) onSubmit;

//   UploadPage({required this.onSubmit});

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _textController = TextEditingController();
//   File? _image;
//   String? _imageUrl;

//   Future<void> _pickImage() async {
//     if (html.window.navigator.userAgent.contains('Mobile')) {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });

//         // Upload image to Firebase Storage
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('uploads/${DateTime.now().toIso8601String()}');
//         final uploadTask = storageRef.putFile(_image!);
//         final snapshot = await uploadTask.whenComplete(() {});
//         final imageUrl = await snapshot.ref.getDownloadURL();

//         setState(() {
//           _imageUrl = imageUrl;
//         });
//       }
//     } else {
//       // For Web
//       final input = html.FileUploadInputElement()..accept = 'image/*';
//       input.click();
//       input.onChange.listen((e) async {
//         final files = input.files!;
//         if (files.isEmpty) return;

//         final reader = html.FileReader();
//         reader.readAsDataUrl(files[0]);
//         reader.onLoadEnd.listen((e) {
//           final dataUrl = reader.result as String;
//           setState(() {
//             _imageUrl = dataUrl; // Use the data URL directly for Web
//           });
//         });
//       });
//     }
//   }

//   void _submitPost() {
//     final username = _usernameController.text;
//     final text = _textController.text;

//     if (username.isNotEmpty && text.isNotEmpty && _imageUrl != null) {
//       widget.onSubmit(username, text, _imageUrl!);
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Post'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(labelText: 'Text'),
//             ),
//             SizedBox(height: 10),
//             _image != null
//                 ? Image.file(_image!)
//                 : _imageUrl != null
//                     ? Image.network(_imageUrl!)
//                     : Text('No image selected.'),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _submitPost,
//               child: Text('Submit Post'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///////////////
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'dart:io';
// import 'dart:html' as html;

// class UploadPage extends StatefulWidget {
//   final Function(String username, String text, String imageUrl) onSubmit;

//   UploadPage({required this.onSubmit});

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _textController = TextEditingController();
//   File? _image;
//   String? _imageUrl;

//   Future<void> _pickImage() async {
//     if (html.window.navigator.userAgent.contains('Mobile')) {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });

//         // Upload image to Firebase Storage
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('uploads/${DateTime.now().toIso8601String()}');
//         final uploadTask = storageRef.putFile(_image!);
//         final snapshot = await uploadTask.whenComplete(() {});
//         final imageUrl = await snapshot.ref.getDownloadURL();

//         setState(() {
//           _imageUrl = imageUrl;
//         });
//       }
//     } else {
//       // For Web
//       final input = html.FileUploadInputElement()..accept = 'image/*';
//       input.click();
//       input.onChange.listen((e) async {
//         final files = input.files!;
//         if (files.isEmpty) return;

//         final reader = html.FileReader();
//         reader.readAsDataUrl(files[0]);
//         reader.onLoadEnd.listen((e) async {
//           final dataUrl = reader.result as String;
//           setState(() {
//             _imageUrl = dataUrl; // Use the data URL directly for Web
//           });
//         });
//       });
//     }
//   }

//   Future<void> _submitPost() async {
//     final username = _usernameController.text;
//     final text = _textController.text;

//     if (username.isNotEmpty && text.isNotEmpty && _imageUrl != null) {
//       // Store the post in Firebase Realtime Database
//       final databaseRef = FirebaseDatabase.instance.ref().child('posts');
//       final newPostRef = databaseRef.push();
//       await newPostRef.set({
//         'username': username,
//         'text': text,
//         'imageUrl': _imageUrl,
//       });

//       // Call the callback to update the UI
//       widget.onSubmit(username, text, _imageUrl!);

//       // Navigate back to the previous screen
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Post'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(labelText: 'Text'),
//             ),
//             SizedBox(height: 10),
//             _image != null
//                 ? Image.file(_image!)
//                 : _imageUrl != null
//                     ? Image.network(_imageUrl!)
//                     : Text('No image selected.'),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _submitPost,
//               child: Text('Submit Post'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadPage extends StatefulWidget {
//   final Future<void> Function(String, String) onSubmit;

//   const UploadPage({required this.onSubmit});

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   String? _imageUrl;
//   final ImagePicker _imagePicker = ImagePicker();
//   bool _isLoading = false;
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _textController = TextEditingController();

//   Future<void> _pickAndUploadImage() async {
//     final XFile? imageFile =
//         await _imagePicker.pickImage(source: ImageSource.gallery);

//     if (imageFile != null) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         final Reference storageRef = FirebaseStorage.instance.ref().child(
//             'Images/${DateTime.now().millisecondsSinceEpoch}.${imageFile.name.split('.').last}');

//         await storageRef.putFile(File(imageFile.path));

//         _imageUrl = await storageRef.getDownloadURL();
//         Fluttertoast.showToast(msg: 'Image uploaded successfully');
//       } catch (e) {
//         print('Error occurred: $e');
//         Fluttertoast.showToast(msg: 'Failed to upload image');
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Post'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _imageUrl == null
//                 ? Icon(Icons.person, size: 200, color: Colors.grey)
//                 : Image.network(
//                     _imageUrl!,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: _pickAndUploadImage,
//               icon: Icon(Icons.image),
//               label: Text('Upload Image', style: TextStyle(fontSize: 20)),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(labelText: 'Post Text'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final username = _usernameController.text;
//                 final text = _textController.text;
//                 if (username.isNotEmpty &&
//                     text.isNotEmpty &&
//                     _imageUrl != null) {
//                   widget.onSubmit(username, text); // Fixed function call
//                   Navigator.pop(context);
//                 } else {
//                   Fluttertoast.showToast(
//                       msg: 'Please fill all fields and upload an image');
//                 }
//               },
//               child: Text('Submit'),
//             ),
//             if (_isLoading)
//               Center(
//                 child: SpinKitThreeBounce(color: Colors.black, size: 20),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///////////////////////
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadPage extends StatefulWidget {
//   final Function(String, String, String) onSubmit;

//   const UploadPage({required this.onSubmit});

//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   String? _imageUrl;
//   final ImagePicker _imagePicker = ImagePicker();
//   bool _isLoading = false;
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _textController = TextEditingController();

//   Future<void> _pickAndUploadImage() async {
//     final XFile? imageFile =
//         await _imagePicker.pickImage(source: ImageSource.gallery);

//     if (imageFile != null) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         // Determine the file extension dynamically
//         final String fileExtension = imageFile.name.split('.').last;
//         final String validExtension =
//             ['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension.toLowerCase())
//                 ? fileExtension
//                 : 'png'; // Default to png if the extension is not supported

//         final Reference storageRef = FirebaseStorage.instance.ref().child(
//             'Images/${DateTime.now().millisecondsSinceEpoch}.$validExtension');

//         await storageRef.putFile(File(imageFile.path));

//         _imageUrl = await storageRef.getDownloadURL();
//         Fluttertoast.showToast(msg: 'Image uploaded successfully');
//       } catch (e) {
//         print('Error occurred: $e');
//         Fluttertoast.showToast(msg: 'Failed to upload image');
//       } finally {
//         if (mounted) {
//           setState(() {
//             _isLoading = false;
//           });
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Post'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _imageUrl == null
//                 ? Icon(Icons.image, size: 200, color: Colors.grey)
//                 : Image.network(
//                     _imageUrl!,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: _pickAndUploadImage,
//               icon: Icon(Icons.image),
//               label: Text('Upload Image', style: TextStyle(fontSize: 20)),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(labelText: 'Post Text'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final username = _usernameController.text;
//                 final text = _textController.text;
//                 if (username.isNotEmpty &&
//                     text.isNotEmpty &&
//                     _imageUrl != null) {
//                   widget.onSubmit(username, text, _imageUrl!);
//                   Navigator.pop(context);
//                 } else {
//                   Fluttertoast.showToast(
//                       msg: 'Please fill all fields and upload an image');
//                 }
//               },
//               child: Text('Submit'),
//             ),
//             if (_isLoading)
//               Center(
//                 child: SpinKitThreeBounce(color: Colors.black, size: 20),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///////////////////////////////////////
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageAndText() async {
    if (_image == null || _textController.text.isEmpty) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child(
          'community_images/${DateTime.now().millisecondsSinceEpoch}.png');
      final uploadTask = storageRef.putFile(_image!);
      final snapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      // Save data to Firestore
      await FirebaseFirestore.instance.collection('community_posts').add({
        'imageUrl': imageUrl,
        'text': _textController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the input and image
      setState(() {
        _textController.clear();
        _image = null;
        _isUploading = false;
      });

      Navigator.pop(context);
    } catch (e) {
      print('Upload failed: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image and Text'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                color: Colors.grey[300],
                width: double.infinity,
                height: 200,
                child: _image == null
                    ? Center(child: Text('Pick an image'))
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your text',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImageAndText,
              child:
                  _isUploading ? CircularProgressIndicator() : Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
