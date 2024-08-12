// lib/screens/community_screen.dart

// import 'package:flutter/material.dart';

// import 'upload_page.dart'; // Add this import

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final List<Map<String, String>> _posts = [];

//   void _addPost(String username, String text, String imageUrl) {
//     setState(() {
//       _posts.add({
//         'username': username,
//         'text': text,
//         'imageUrl': imageUrl,
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: ListView.builder(
//         itemCount: _posts.length,
//         itemBuilder: (context, index) {
//           final post = _posts[index];
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               leading: post['imageUrl'] != null
//                   ? Image.network(post['imageUrl']!, width: 50, height: 50)
//                   : null,
//               title: Text(post['username']!),
//               subtitle: Text(post['text']!),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => UploadPage(onSubmit: _addPost)),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }
///////////
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'upload_page.dart'; // Add this import
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'upload_page.dart'; // Add this import

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final List<Map<String, String>> _posts = [];

//   void _addPost(String username, String text, String imageUrl) {
//     setState(() {
//       _posts.add({
//         'username': username,
//         'text': text,
//         'imageUrl': imageUrl,
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: ListView.builder(
//         itemCount: _posts.length,
//         itemBuilder: (context, index) {
//           final post = _posts[index];
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               leading: post['imageUrl'] != null
//                   ? CachedNetworkImage(
//                       imageUrl: post['imageUrl']!,
//                       width: 50,
//                       height: 50,
//                       placeholder: (context, url) =>
//                           CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                     )
//                   : null,
//               title: Text(post['username']!),
//               subtitle: Text(post['text']!),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => UploadPage(onSubmit: _addPost)),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final List<Map<String, String>> _posts = [];

//   void _addPost(String username, String text, String imageUrl) {
//     setState(() {
//       _posts.add({
//         'username': username,
//         'text': text,
//         'imageUrl': imageUrl,
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: ListView.builder(
//         itemCount: _posts.length,
//         itemBuilder: (context, index) {
//           final post = _posts[index];
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               leading: post['imageUrl'] != null
//                   ? CachedNetworkImage(
//                       imageUrl: post['imageUrl']!,
//                       width: 50,
//                       height: 50,
//                       placeholder: (context, url) =>
//                           CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                     )
//                   : null,
//               title: Text(post['username']!),
//               subtitle: Text(post['text']!),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => UploadPage(onSubmit: _addPost)),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }

// ////////////
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class CommunityPage extends StatelessWidget {
// //   final User user;
// //   CommunityPage({required this.user});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Community'),
// //       ),
// //       body: Center(
// //         child: Text('Community screen content here'),
// //       ),
// //     );
// //   }
// // }
// // Import statements should be at the top
// Import statements should be at the top
// Import statements should be at the top
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'upload_page.dart';

// Make sure there's only one declaration of the CommunityPage class
/////////correct code
// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final List<Map<String, String>> _posts = [];

//   void _addPost(String username, String text, String imageUrl) {
//     setState(() {
//       _posts.add({
//         'username': username,
//         'text': text,
//         'imageUrl': imageUrl,
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: ListView.builder(
//         itemCount: _posts.length,
//         itemBuilder: (context, index) {
//           final post = _posts[index];
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             child: ListTile(
//               leading: post['imageUrl'] != null
//                   ? CachedNetworkImage(
//                       imageUrl: post['imageUrl']!,
//                       width: 50,
//                       height: 50,
//                       placeholder: (context, url) =>
//                           CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                     )
//                   : null,
//               title: Text(post['username']!),
//               subtitle: Text(post['text']!),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => UploadPage(onSubmit: _addPost)),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }
/////////////////correct code end
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final List<Map<String, String>> _posts = [];
//   final ImagePicker _imagePicker = ImagePicker();
//   bool _isLoading = false;

//   void _addPost(String username, String text, String imageUrl) {
//     setState(() {
//       _posts.add({
//         'username': username,
//         'text': text,
//         'imageUrl': imageUrl,
//       });
//     });
//   }

//   Future<void> _uploadImageAndAddPost(String username, String text) async {
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

//         final String imageUrl = await storageRef.getDownloadURL();

//         _addPost(username, text, imageUrl);
//         Fluttertoast.showToast(
//             msg: 'Image uploaded and post added successfully');
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
//         title: Text('Community'),
//       ),
//       body: Stack(
//         children: [
//           ListView.builder(
//             itemCount: _posts.length,
//             itemBuilder: (context, index) {
//               final post = _posts[index];
//               return Card(
//                 margin: EdgeInsets.all(8.0),
//                 child: ListTile(
//                   leading: post['imageUrl'] != null
//                       ? CachedNetworkImage(
//                           imageUrl: post['imageUrl']!,
//                           width: 50,
//                           height: 50,
//                           placeholder: (context, url) =>
//                               CircularProgressIndicator(),
//                           errorWidget: (context, url, error) =>
//                               Icon(Icons.error),
//                         )
//                       : null,
//                   title: Text(post['username']!),
//                   subtitle: Text(post['text']!),
//                 ),
//               );
//             },
//           ),
//           if (_isLoading)
//             Center(
//               child: SpinKitThreeBounce(color: Colors.black, size: 20),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   UploadPage(onSubmit: _uploadImageAndAddPost),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }
///////////////////
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final List<Map<String, String>> _posts = [];
//   final ImagePicker _imagePicker = ImagePicker();
//   bool _isLoading = false;

//   void _addPost(String username, String text, String imageUrl) {
//     setState(() {
//       _posts.add({
//         'username': username,
//         'text': text,
//         'imageUrl': imageUrl,
//       });
//     });
//   }

//   Future<void> _uploadImageAndAddPost(String username, String text) async {
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

//         final String imageUrl = await storageRef.getDownloadURL();

//         _addPost(username, text, imageUrl);
//         Fluttertoast.showToast(
//             msg: 'Image uploaded and post added successfully');
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
//         title: Text('Community'),
//       ),
//       body: Stack(
//         children: [
//           ListView.builder(
//             itemCount: _posts.length,
//             itemBuilder: (context, index) {
//               final post = _posts[index];
//               return Card(
//                 margin: EdgeInsets.all(8.0),
//                 child: ListTile(
//                   leading: post['imageUrl'] != null
//                       ? CachedNetworkImage(
//                           imageUrl: post['imageUrl']!,
//                           width: 50,
//                           height: 50,
//                           placeholder: (context, url) =>
//                               CircularProgressIndicator(),
//                           errorWidget: (context, url, error) =>
//                               Icon(Icons.error),
//                         )
//                       : null,
//                   title: Text(post['username']!),
//                   subtitle: Text(post['text']!),
//                 ),
//               );
//             },
//           ),
//           if (_isLoading)
//             Center(
//               child: SpinKitThreeBounce(color: Colors.black, size: 20),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   UploadPage(onSubmit: _uploadImageAndAddPost),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }
///////////////////
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   final TextEditingController _textController = TextEditingController();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadImageAndText() async {
//     if (_image == null || _textController.text.isEmpty) return;

//     try {
//       // Upload image to Firebase Storage
//       String fileName =
//           'community_images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
//       final ref = FirebaseStorage.instance.ref().child(fileName);
//       await ref.putFile(_image!);
//       final imageUrl = await ref.getDownloadURL();

//       // Store image URL and text in Firestore
//       await FirebaseFirestore.instance.collection('community_posts').add({
//         'text': _textController.text,
//         'imageUrl': imageUrl,
//         'timestamp': Timestamp.now(),
//       });

//       // Clear the image and text after upload
//       setState(() {
//         _image = null;
//         _textController.clear();
//       });
//     } catch (e) {
//       print('Error uploading image and text: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('community_posts')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var post = snapshot.data!.docs[index];
//                     return Card(
//                       child: Column(
//                         children: [
//                           Image.network(post['imageUrl']),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(post['text']),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 if (_image != null)
//                   Image.file(
//                     _image!,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration:
//                         InputDecoration(labelText: 'Enter your text here'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_photo_alternate),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _uploadImageAndText,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
/////////////////////////////////////////////
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   final TextEditingController _textController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadImageAndText() async {
//     if (_image == null || _textController.text.isEmpty) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Upload image to Firebase Storage
//       String fileName =
//           'community_images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
//       final ref = FirebaseStorage.instance.ref().child(fileName);
//       await ref.putFile(_image!);
//       final imageUrl = await ref.getDownloadURL();

//       // Store image URL and text in Firestore
//       await FirebaseFirestore.instance.collection('community_posts').add({
//         'text': _textController.text,
//         'imageUrl': imageUrl,
//         'timestamp': Timestamp.now(),
//       });

//       Fluttertoast.showToast(msg: 'Image and text uploaded successfully!');

//       // Clear the image and text after upload
//       setState(() {
//         _image = null;
//         _textController.clear();
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error uploading image and text: $e');
//       print('Error uploading image and text: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('community_posts')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var post = snapshot.data!.docs[index];
//                     return Card(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (post['imageUrl'] != null)
//                             Image.network(
//                               post['imageUrl'],
//                               width: double.infinity,
//                               height: 200,
//                               fit: BoxFit.cover,
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(post['text'] ?? ''),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 if (_image != null)
//                   Container(
//                     margin: const EdgeInsets.only(right: 8.0),
//                     child: Image.file(
//                       _image!,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter your text here',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_photo_alternate),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _uploadImageAndText,
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: SpinKitThreeBounce(
//                 color: Colors.black,
//                 size: 20,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
/////////////
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   final TextEditingController _textController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadImageAndText() async {
//     if (_image == null || _textController.text.isEmpty) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Upload image to Firebase Storage
//       String fileName =
//           'community_images/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
//       final ref = FirebaseStorage.instance.ref().child(fileName);
//       await ref.putFile(_image!);
//       final imageUrl = await ref.getDownloadURL();

//       // Store image URL and text in Firestore
//       await FirebaseFirestore.instance.collection('community_posts').add({
//         'text': _textController.text,
//         'imageUrl': imageUrl,
//         'timestamp': Timestamp.now(),
//       });

//       Fluttertoast.showToast(msg: 'Image and text uploaded successfully!');

//       // Clear the image and text after upload
//       setState(() {
//         _image = null;
//         _textController.clear();
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error uploading image and text: $e');
//       print('Error uploading image and text: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('community_posts')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var post = snapshot.data!.docs[index];
//                     return Card(
//                       margin: EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (post['imageUrl'] != null)
//                             Image.network(
//                               post['imageUrl'],
//                               width: double.infinity,
//                               height: 200,
//                               fit: BoxFit.cover,
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(post['text'] ?? ''),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 if (_image != null)
//                   Container(
//                     margin: const EdgeInsets.only(right: 8.0),
//                     child: Image.file(
//                       _image!,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter your text here',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_photo_alternate),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _uploadImageAndText,
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: SpinKitThreeBounce(
//                 color: Colors.black,
//                 size: 20,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
///////////////////
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   final TextEditingController _textController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadImageAndText() async {
//     if (_image == null || _textController.text.isEmpty) {
//       Fluttertoast.showToast(msg: 'Please select an image and enter text');
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Upload image to Firebase Storage
//       String fileName =
//           'community_images/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
//       final ref = FirebaseStorage.instance.ref().child(fileName);
//       await ref.putFile(_image!);
//       final imageUrl = await ref.getDownloadURL();

//       // Store image URL and text in Firestore
//       await FirebaseFirestore.instance.collection('community_posts').add({
//         'text': _textController.text,
//         'imageUrl': imageUrl,
//         'timestamp': Timestamp.now(),
//       });

//       Fluttertoast.showToast(msg: 'Image and text uploaded successfully!');

//       // Clear the image and text after upload
//       setState(() {
//         _image = null;
//         _textController.clear();
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error uploading image and text: $e');
//       print('Error uploading image and text: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('community_posts')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var post = snapshot.data!.docs[index];
//                     return Card(
//                       margin: EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (post['imageUrl'] != null)
//                             kIsWeb
//                                 ? Image.network(
//                                     post['imageUrl'],
//                                     width: double.infinity,
//                                     height: 200,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Image.file(
//                                     File(post['imageUrl']),
//                                     width: double.infinity,
//                                     height: 200,
//                                     fit: BoxFit.cover,
//                                   ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(post['text'] ?? ''),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 if (_image != null)
//                   Container(
//                     margin: const EdgeInsets.only(right: 8.0),
//                     child: kIsWeb
//                         ? Image.network(
//                             _image!.path,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           )
//                         : Image.file(
//                             _image!,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter your text here',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_photo_alternate),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _isLoading ? null : _uploadImageAndText,
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: SpinKitThreeBounce(
//                 color: Colors.black,
//                 size: 20,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
/////////////////////////////////////////////////////
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class CommunityPage extends StatefulWidget {
//   @override
//   _CommunityPageState createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   final TextEditingController _textController = TextEditingController();
//   bool _isLoading = false;

//   // Firebase Storage with specific bucket reference
//   final FirebaseStorage _storage = FirebaseStorage.instanceFor(
//     bucket: 'gs://careclimate-95ea3.appspot.com',
//   );

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadImageAndText() async {
//     if (_image == null || _textController.text.isEmpty) {
//       Fluttertoast.showToast(msg: 'Please select an image and enter text');
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // Upload image to Firebase Storage
//       String fileName =
//           'community_images/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
//       final ref = _storage.ref().child(fileName);
//       await ref.putFile(_image!);
//       final imageUrl = await ref.getDownloadURL();

//       // Store image URL and text in Firestore
//       await FirebaseFirestore.instance.collection('community_posts').add({
//         'text': _textController.text,
//         'imageUrl': imageUrl,
//         'timestamp': Timestamp.now(),
//       });

//       Fluttertoast.showToast(msg: 'Image and text uploaded successfully!');

//       // Clear the image and text after upload
//       setState(() {
//         _image = null;
//         _textController.clear();
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error uploading image and text: $e');
//       print('Error uploading image and text: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('community_posts')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var post = snapshot.data!.docs[index];
//                     return Card(
//                       margin: EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (post['imageUrl'] != null)
//                             kIsWeb
//                                 ? Image.network(
//                                     post['imageUrl'],
//                                     width: double.infinity,
//                                     height: 200,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Image.network( // Using Image.network for both platforms
//                                     post['imageUrl'],
//                                     width: double.infinity,
//                                     height: 200,
//                                     fit: BoxFit.cover,
//                                   ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(post['text'] ?? ''),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 if (_image != null)
//                   Container(
//                     margin: const EdgeInsets.only(right: 8.0),
//                     child: kIsWeb
//                         ? Image.network(
//                             _image!.path,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           )
//                         : Image.file(
//                             _image!,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter your text here',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_photo_alternate),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _isLoading ? null : _uploadImageAndText,
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: SpinKitThreeBounce(
//                 color: Colors.black,
//                 size: 20,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
/////////////////////
import 'dart:io' if (kIsWeb) 'dart:typed_data';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedFile;
  Uint8List? _webImage;
  File? _image;
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;

  // Firebase Storage with specific bucket reference
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
    bucket: 'gs://careclimate-95ea3.appspot.com',
  );

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() async {
        _pickedFile = pickedFile;
        if (kIsWeb) {
          _webImage = await pickedFile.readAsBytes();
        } else {
          _image = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _uploadImageAndText() async {
    if ((_pickedFile == null && _image == null) ||
        _textController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select an image and enter text');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Firebase Storage
      String fileName =
          'community_images/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
      final ref = _storage.ref().child(fileName);

      if (kIsWeb) {
        // Upload the file as data on web
        await ref.putData(_webImage!);
      } else {
        // Upload the file directly from the file system on mobile
        await ref.putFile(_image!);
      }

      final imageUrl = await ref.getDownloadURL();

      // Store image URL and text in Firestore
      await FirebaseFirestore.instance.collection('community_posts').add({
        'text': _textController.text,
        'imageUrl': imageUrl,
        'timestamp': Timestamp.now(),
      });

      Fluttertoast.showToast(msg: 'Image and text uploaded successfully!');

      // Clear the image and text after upload
      setState(() {
        _pickedFile = null;
        _image = null;
        _webImage = null;
        _textController.clear();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error uploading image and text: $e');
      print('Error uploading image and text: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('community_posts')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (post['imageUrl'] != null)
                            Image.network(
                              post['imageUrl'],
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(post['text'] ?? ''),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (_pickedFile != null)
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: kIsWeb
                        ? Image.memory(
                            _webImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            _image!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Enter your text here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_photo_alternate),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isLoading ? null : _uploadImageAndText,
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: SpinKitThreeBounce(
                color: Colors.black,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
