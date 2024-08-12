// import 'package:firebase_database/firebase_database.dart';

// class FirebaseService {
//   final DatabaseReference _databaseReference =
//       FirebaseDatabase.instance.reference();

//   void saveTask(String day, Map<String, dynamic> taskData) {
//     _databaseReference.child('tasks').child(day).push().set(taskData);
//   }

//   Future<Map<String, dynamic>> getTasks() async {
//     DataSnapshot snapshot = await _databaseReference.child('tasks').once();
//     if (snapshot.value != null) {
//       return Map<String, dynamic>.from(snapshot.value);
//     } else {
//       return {};
//     }
//   }
// }
// import 'dart:io';

// import 'package:careclimate/features/user_auth/presentation/pages/post.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class FirebaseService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseDatabase _database = FirebaseDatabase.instance;

//   Future<void> uploadImageAndText(File image, String text) async {
//     // Generate a unique ID for the post
//     String postId = DateTime.now().millisecondsSinceEpoch.toString();

//     // Upload image to Firebase Storage
//     Reference ref = _storage.ref().child('posts/$postId.jpg');
//     UploadTask uploadTask = ref.putFile(image);
//     TaskSnapshot snapshot = await uploadTask;
//     String imageUrl = await snapshot.ref.getDownloadURL();

//     // Save post data to Firebase Realtime Database
//     DatabaseReference postsRef = _database.ref('posts');
//     await postsRef.child(postId).set({
//       'imageUrl': imageUrl,
//       'text': text,
//     });
//   }

//   Stream<List<Post>> getPosts() {
//     DatabaseReference postsRef = _database.ref('posts');
//     return postsRef.onValue.map((event) {
//       List<Post> posts = [];
//       for (DataSnapshot child in event.snapshot.children) {
//         Post post = Post.fromJson(child.value as Map<String, dynamic>);
//         post.id = child.key;
//         posts.add(post);
//       }
//       return posts;
//     });
//   }
// }
