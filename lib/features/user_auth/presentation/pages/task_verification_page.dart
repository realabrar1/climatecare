// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart';

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   Uint8List? _image;
//   String? _imageUrl;
//   final ImagePicker _picker = ImagePicker();
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   String feedback = '';

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       final imageBytes = await photo.readAsBytes();
//       setState(() {
//         _image = imageBytes;
//       });
//     }
//   }

//   Future<String?> _uploadImage() async {
//     if (_image == null) return null;

//     try {
//       final storageRef = _storage
//           .ref()
//           .child('task_images/${DateTime.now().millisecondsSinceEpoch}.png');
//       final uploadTask = storageRef.putData(_image!);
//       final snapshot = await uploadTask.whenComplete(() {});
//       final imageUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         _imageUrl = imageUrl;
//       });
//       return imageUrl;
//     } catch (e) {
//       print('Image upload failed: $e');
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Verify Task: ${widget.taskName}'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if (_image != null)
//               Image.memory(
//                 _image!,
//                 height: 200,
//               )
//             else
//               Container(
//                 height: 200,
//                 color: Colors.grey[300],
//                 child: Icon(Icons.camera_alt, size: 100),
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _takePhoto,
//               child: Text('Capture Photo'),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 hintText: 'Enter feedback',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 feedback = value;
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final imageUrl = await _uploadImage();
//                 if (imageUrl != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Task verified and image uploaded!')),
//                   );
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('SubmitVerification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TaskDetailsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Tasks'),
//       ),
//       body: Center(
//         child: Text('Task Details'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class TaskVerificationPage extends StatefulWidget {
  final String taskName;

  TaskVerificationPage({required this.taskName});

  @override
  _TaskVerificationPageState createState() => _TaskVerificationPageState();
}

class _TaskVerificationPageState extends State<TaskVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Task'),
      ),
      body: Center(
        child: Text('Task: ${widget.taskName}'),
      ),
    );
  }
}
