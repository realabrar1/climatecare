// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task To Reduce CO2eq'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: Column(
//         children: [
//           buildTabs(),
//           Expanded(child: buildTaskList()),
//         ],
//       ),
//     );
//   }

//   Widget buildTabs() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         buildTabButton('Daily Task', Colors.green[700]!),
//         buildTabButton('All Task', Colors.grey),
//         buildTabButton('Global Challenge', Colors.grey),
//       ],
//     );
//   }

//   Widget buildTabButton(String title, Color color) {
//     return TextButton(
//       onPressed: () {
//         // Navigate or update state to show corresponding tasks
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<Map<String, String>> tasks = [
//       {'name': 'Plant a Tree', 'co2eq': '11'},
//       {'name': '1hr Refrigerator (don\'t use)', 'co2eq': '7'},
//       {'name': 'Don\'t waste Food', 'co2eq': '5'},
//       {'name': 'Switch off AC', 'co2eq': '9'},
//       {'name': 'Travel', 'co2eq': '20'}
//     ];

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]['name']!),
//           trailing: IconButton(
//             icon: Icon(Icons.info),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TaskVerificationPage(
//                     taskName: tasks[index]['name']!,
//                     co2Reduction: tasks[index]['co2eq']!,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;
//   final String co2Reduction;

//   TaskVerificationPage({
//     required this.taskName,
//     required this.co2Reduction,
//   });

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   void _saveRecord() {
//     // Logic to save the record
//     // You can implement saving details to database or local storage
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Record Saved!')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Verification'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.taskName,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'You are reducing ${widget.co2Reduction} kg of CO2eq',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: _image == null
//                   ? Text('No image selected.')
//                   : Image.file(_image!),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _takePhoto,
//               child: Text('Capture Photo'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _saveRecord,
//               child: Text('Save Record'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'dart:io' if (kIsWeb) 'dart:typed_data';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;
//   final int points;
//   final double co2Reduction;

//   TaskVerificationPage({
//     required this.taskName,
//     required this.points,
//     required this.co2Reduction,
//   });

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   XFile? _pickedFile;
//   Uint8List? _webImage;
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = '';
//   bool _isUploading = false;

//   final FirebaseStorage _storage = FirebaseStorage.instanceFor(
//     bucket: 'gs://careclimate-95ea3.appspot.com',
//   );

//   Future<void> _takePhoto() async {
//     try {
//       final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//       if (photo != null) {
//         setState(() async {
//           _pickedFile = photo;
//           if (kIsWeb) {
//             _webImage = await photo.readAsBytes();
//           } else {
//             _image = File(photo.path);
//           }
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error capturing image: $e')),
//       );
//     }
//   }

//   Future<void> _saveRecord() async {
//     if ((_pickedFile == null && _image == null) || feedback.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please provide an image and feedback.')),
//       );
//       return;
//     }

//     setState(() {
//       _isUploading = true;
//     });

//     try {
//       // Upload image to Firebase Storage
//       String fileName =
//           'task_verification/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
//       final ref = _storage.ref().child(fileName);

//       if (kIsWeb) {
//         // Upload the file as data on the web
//         await ref.putData(_webImage!);
//       } else {
//         // Upload the file directly from the file system on mobile
//         await ref.putFile(_image!);
//       }

//       final downloadUrl = await ref.getDownloadURL();

//       // Save task details to Firebase Realtime Database
//       final user = FirebaseAuth.instance.currentUser;
//       final userId = user?.email?.replaceAll('.', '_') ?? 'unknown_user';
//       final databaseRef = FirebaseDatabase.instance
//           .refFromURL('https://careclimate-95ea3-default-rtdb.firebaseio.com/')
//           .child('user_data/$userId');

//       await databaseRef.push().set({
//         'taskName': widget.taskName,
//         'points': widget.points,
//         'co2Reduction': widget.co2Reduction,
//         'imageUrl': downloadUrl,
//         'feedback': feedback,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Record Saved!')),
//       );

//       // Clear the image and feedback after upload
//       setState(() {
//         _pickedFile = null;
//         _image = null;
//         _webImage = null;
//         feedback = '';
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to save record: $e')),
//       );
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }

//   Widget buildFeedbackField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Provide Feedback:'),
//         SizedBox(height: 10),
//         TextField(
//           maxLines: 4,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: 'Enter your feedback here',
//           ),
//           onChanged: (text) {
//             setState(() {
//               feedback = text;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Verification'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.taskName,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'You are reducing ${widget.co2Reduction} kg of CO2eq',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: kIsWeb
//                   ? _webImage == null
//                       ? Text('No image selected.')
//                       : Image.memory(
//                           _webImage!,
//                           width: 200,
//                           height: 200,
//                           fit: BoxFit.cover,
//                         )
//                   : _image == null
//                       ? Text('No image selected.')
//                       : Image.network(_image! as String),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _takePhoto,
//               child: Text('Capture Photo'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildFeedbackField(),
//             SizedBox(height: 20),
//             _isUploading
//                 ? Center(child: CircularProgressIndicator())
//                 : ElevatedButton(
//                     onPressed: _saveRecord,
//                     child: Text('Save Record'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green[700],
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TaskVerificationPage extends StatefulWidget {
  final String taskName;

  TaskVerificationPage({required this.taskName});

  @override
  _TaskVerificationPageState createState() => _TaskVerificationPageState();
}

class _TaskVerificationPageState extends State<TaskVerificationPage> {
  File? _image;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
    bucket: 'gs://careclimate-95ea3.appspot.com',
  );
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  String feedback = '';

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_image == null) return null;

    try {
      final storageRef = _storage
          .ref()
          .child('task_images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageRef.putFile(_image!);
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _imageUrl = imageUrl; // Store the image URL
      });
      return imageUrl;
    } catch (e) {
      print('Image upload failed: $e');
      return null;
    }
  }

  Future<void> _saveTaskToDatabase() async {
    final userId = 'user@example.com'; // Replace with actual user ID
    final taskName = widget.taskName;
    final points = 10; // Example points, replace with actual logic
    final imageUrl = _imageUrl;

    if (imageUrl != null) {
      try {
        await _databaseRef.child('tasks').push().set({
          'userId': userId,
          'taskName': taskName,
          'points': points,
          'image': imageUrl,
          'feedback': feedback,
        });
        print('Task details saved to database');
      } catch (e) {
        print('Failed to save task details: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Task: ${widget.taskName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_image != null)
              Image.network(
                _image! as String,
                height: 200,
              )
            else
              Container(
                height: 200,
                color: Colors.grey[300],
                child: Icon(Icons.camera_alt, size: 100),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePhoto,
              child: Text('Capture Photo'),
            ),
            SizedBox(height: 20),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter feedback',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                feedback = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final imageUrl = await _uploadImage();
                if (imageUrl != null) {
                  await _saveTaskToDatabase(); // Save task details to database
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Task verified and image uploaded!')),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Submit Verification'),
            ),
          ],
        ),
      ),
    );
  }
}
