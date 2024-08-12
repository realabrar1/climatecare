// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   final _captionController = TextEditingController();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   Future<void> _uploadPost() async {
//     if (_image == null || _captionController.text.isEmpty) {
//       // Handle validation
//       return;
//     }

//     try {
//       // Upload image to Firebase Storage
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference storageReference =
//           FirebaseStorage.instance.ref().child('community_posts/$fileName');
//       UploadTask uploadTask = storageReference.putFile(_image!);
//       await uploadTask.whenComplete(() => null);
//       String imageUrl = await storageReference.getDownloadURL();

//       // Save post information to Firestore
//       await FirebaseFirestore.instance.collection('community_posts').add({
//         'image_url': imageUrl,
//         'caption': _captionController.text,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       // Clear the image and caption after upload
//       setState(() {
//         _image = null;
//         _captionController.clear();
//       });

//       // Close the modal
//       Navigator.of(context).pop();
//     } catch (e) {
//       print('Error uploading post: $e');
//     }
//   }

//   void _showPostDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('New Post'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _image != null
//                 ? Image.file(_image!)
//                 : TextButton(
//                     onPressed: _pickImage,
//                     child: Text('Pick Image'),
//                   ),
//             TextField(
//               controller: _captionController,
//               decoration: InputDecoration(labelText: 'Caption'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: _uploadPost,
//             child: Text('Post'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('community_posts')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final posts = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return ListTile(
//                 leading: post['image_url'] != null
//                     ? Image.network(post['image_url'], width: 50)
//                     : null,
//                 title: Text(post['caption']),
//                 subtitle: Text(post['timestamp']?.toDate()?.toString() ?? ''),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPostDialog,
//         child: Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.task),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.group),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: 2, // Set the current index for CommunityPage
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.white,
//         backgroundColor: Colors.black,
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               Navigator.pushReplacementNamed(context, '/home');
//               break;
//             case 1:
//               Navigator.pushReplacementNamed(context, '/tasks');
//               break;
//             case 2:
//               Navigator.pushReplacementNamed(context, '/community');
//               break;
//             case 3:
//               Navigator.pushReplacementNamed(context, '/profile');
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
///test
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   final _captionController = TextEditingController();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   Future<void> _uploadPost() async {
//     if (_image == null || _captionController.text.isEmpty) {
//       // Handle validation
//       return;
//     }

//     try {
//       // Upload image to Firebase Storage
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference storageReference =
//           FirebaseStorage.instance.ref().child('community_posts/$fileName');
//       UploadTask uploadTask = storageReference.putFile(_image!);
//       await uploadTask.whenComplete(() => null);
//       String imageUrl = await storageReference.getDownloadURL();

//       // Save post information to Firestore
//       await FirebaseFirestore.instance.collection('community_posts').add({
//         'image_url': imageUrl,
//         'caption': _captionController.text,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       // Clear the image and caption after upload
//       setState(() {
//         _image = null;
//         _captionController.clear();
//       });

//       // Close the modal
//       Navigator.of(context).pop();
//     } catch (e) {
//       print('Error uploading post: $e');
//     }
//   }

//   void _showPostDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('New Post'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _image != null
//                 ? Image.file(_image!)
//                 : TextButton(
//                     onPressed: _pickImage,
//                     child: Text('Pick Image'),
//                   ),
//             TextField(
//               controller: _captionController,
//               decoration: InputDecoration(labelText: 'Caption'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: _uploadPost,
//             child: Text('Post'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('community_posts')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final posts = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return Card(
//                 margin: EdgeInsets.all(10),
//                 elevation: 5,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     post['image_url'] != null
//                         ? Image.network(post['image_url'])
//                         : SizedBox.shrink(),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text(
//                         post['caption'],
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 5),
//                       child: Text(
//                         post['timestamp']?.toDate()?.toString() ?? '',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPostDialog,
//         child: Icon(Icons.add),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//     );
//   }
// }
///test 2 is good
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   final TextEditingController _titleController = TextEditingController();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   Future<void> _uploadPost() async {
//     if (_image == null || _titleController.text.isEmpty) return;

//     String fileName = _image!.path.split('/').last;
//     Reference storageRef =
//         FirebaseStorage.instance.ref().child('community/$fileName');
//     UploadTask uploadTask = storageRef.putFile(_image!);

//     TaskSnapshot taskSnapshot = await uploadTask;
//     String imageUrl = await taskSnapshot.ref.getDownloadURL();

//     await _firestore.collection('community').add({
//       'username': 'User', // Replace with actual user data
//       'userImage':
//           'https://example.com/userImage.jpg', // Replace with actual user image URL
//       'title': _titleController.text,
//       'photo': imageUrl,
//     });

//     setState(() {
//       _image = null;
//       _titleController.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Community'),
//         ),
//         body: StreamBuilder(
//           stream: _firestore.collection('community').snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }
//             return ListView(
//               children: snapshot.data!.docs.map((doc) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(doc['userImage']),
//                   ),
//                   title: Text(doc['username']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(doc['title']),
//                       SizedBox(height: 5),
//                       Image.network(doc['photo']),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text('Upload Post'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextField(
//                         controller: _titleController,
//                         decoration: InputDecoration(labelText: 'Title'),
//                       ),
//                       SizedBox(height: 10),
//                       _image == null
//                           ? Text('No image selected.')
//                           : Image.file(_image!),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: _pickImage,
//                         child: Text('Pick Image'),
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         await _uploadPost();
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Upload'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Icon(Icons.add),
//         ));
//   }
// }
//End test 2 is good//
// lib/features/user_auth/presentation/pages/community_page.dart
