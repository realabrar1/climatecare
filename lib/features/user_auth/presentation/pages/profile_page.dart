// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final User? user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (user != null) ...[
//               Text("Username: ${user!.displayName}",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               user!.photoURL != null
//                   ? Image.network(user!.photoURL!)
//                   : Icon(Icons.account_circle, size: 100),
//               SizedBox(height: 20),
//               Text("Saved Records",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('records')
//                       .where('userId', isEqualTo: user!.uid)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                     final records = snapshot.data!.docs;
//                     return ListView.builder(
//                       itemCount: records.length,
//                       itemBuilder: (context, index) {
//                         final record = records[index];
//                         return ListTile(
//                           title: Text(record['task']),
//                           subtitle: Text(record['description']),
//                           trailing: record['imageUrl'] != null
//                               ? Image.network(record['imageUrl'], height: 50)
//                               : null,
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user?.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final userData = snapshot.data!.data() as Map<String, dynamic>;
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(userData['profile_picture'] ??
//                       'https://via.placeholder.com/150'),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   userData['username'] ?? 'No Username',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Age: ${userData['age'] ?? 'N/A'}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 Text(
//                   'Address: ${userData['address'] ?? 'N/A'}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     FirebaseAuth.instance.signOut();
//                     Navigator.pushReplacementNamed(context, '/login');
//                   },
//                   child: Text('Sign Out'),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
///test1////
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   final String username = "John Doe";
//   final String email = "johndoe@example.com";
//   final int points = 150;
//   final List<String> tasks = [
//     'assets/task1.jpg',
//     'assets/task2.jpg',
//     'assets/task3.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return buildSettingsMenu(context);
//                 },
//               );
//             },
//           ),
//         ],
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               buildProfileHeader(),
//               SizedBox(height: 20),
//               buildPointsSection(),
//               SizedBox(height: 20),
//               buildTasksSection(),
//               SizedBox(height: 20),
//               buildFollowSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildProfileHeader() {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 50,
//           backgroundImage: AssetImage('assets/profile.jpg'),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               username,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               email,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildPointsSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Points',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               points.toString(),
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Navigate to Rewards Page
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.orange[600],
//             padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//             textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           child: Text('Rewards'),
//         ),
//       ],
//     );
//   }

//   Widget buildTasksSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Tasks',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.green[700],
//           ),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 150,
//                 margin: EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(tasks[index]),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildFollowSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Followers',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               '300',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Following',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               '180',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildSettingsMenu(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('Help'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Help Page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.edit),
//             title: Text('Edit Profile'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Edit Profile Page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               Navigator.pop(context);
//               // Handle Logout
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(home: ProfilePage()));
/// end test 1 ////
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   User? user;
//   String username = "Loading...";
//   String email = "Loading...";
//   int points = 150;
//   List<String> tasks = [
//     'assets/task1.jpg',
//     'assets/task2.jpg',
//     'assets/task3.jpg',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }

//   Future<void> fetchUserData() async {
//     User? firebaseUser = FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       setState(() {
//         user = firebaseUser;
//         email = firebaseUser.email ?? "No email";
//       });

//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseUser.uid)
//           .get();

//       setState(() {
//         username = userDoc['username'] ?? "No username";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return buildSettingsMenu(context);
//                 },
//               );
//             },
//           ),
//         ],
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               buildProfileHeader(),
//               SizedBox(height: 20),
//               buildPointsSection(),
//               SizedBox(height: 20),
//               buildTasksSection(),
//               SizedBox(height: 20),
//               buildFollowSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildProfileHeader() {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 50,
//           backgroundImage: AssetImage('assets/profile.jpg'),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               username,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               email,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildPointsSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Points',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               points.toString(),
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Navigate to Rewards Page
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.orange[600],
//             padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//             textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           child: Text('Rewards'),
//         ),
//       ],
//     );
//   }

//   Widget buildFollowSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Followers',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               '300',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Following',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               '180',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildTasksSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Tasks',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.green[700],
//           ),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 150,
//                 margin: EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(tasks[index]),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildSettingsMenu(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('Help'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Help Page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.edit),
//             title: Text('Edit Profile'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Edit Profile Page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               Navigator.pop(context);
//               // Handle Logout
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
///test 2//
///end test 2///
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'login_page.dart'; // Ensure this points to your actual login page

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   User? user;
//   String username = "Loading...";
//   String email = "Loading...";
//   int points = 150;
//   List<String> tasks = [
//     'assets/task1.jpg',
//     'assets/task2.jpg',
//     'assets/task3.jpg',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }

//   Future<void> fetchUserData() async {
//     User? firebaseUser = FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       setState(() {
//         user = firebaseUser;
//         email = firebaseUser.email ?? "No email";
//       });

//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseUser.uid)
//           .get();

//       setState(() {
//         username = userDoc['username'] ?? "No username";
//       });
//     }
//   }

//   Future<void> logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return buildSettingsMenu(context);
//                 },
//               );
//             },
//           ),
//         ],
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               buildProfileHeader(),
//               SizedBox(height: 20),
//               buildPointsSection(),
//               SizedBox(height: 20),
//               buildTasksSection(),
//               SizedBox(height: 20),
//               buildFollowSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildProfileHeader() {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 50,
//           backgroundImage: AssetImage('assets/profile.jpg'),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               username,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               email,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildPointsSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Points',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               points.toString(),
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Navigate to Rewards Page
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.orange[600],
//             padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//             textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           child: Text('Rewards'),
//         ),
//       ],
//     );
//   }

//   Widget buildFollowSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Followers',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               '300',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Following',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               '180',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildTasksSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Tasks',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.green[700],
//           ),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 150,
//                 margin: EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(tasks[index]),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildSettingsMenu(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('Help'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Help Page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.edit),
//             title: Text('Edit Profile'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Edit Profile Page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               Navigator.pop(context);
//               logout();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
// ///this is good test///
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'login_page.dart'; // Ensure this points to your actual login page

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   User? user;
//   String username = "Loading...";
//   String email = "Loading...";
//   int points = 150;
//   List<String> tasks = [
//     'assets/task1.jpg',
//     'assets/task2.jpg',
//     'assets/task3.jpg',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }

//   Future<void> fetchUserData() async {
//     User? firebaseUser = FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       setState(() {
//         user = firebaseUser;
//         email = firebaseUser.email ?? "No email";
//       });

//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseUser.uid)
//           .get();

//       setState(() {
//         username = userDoc['username'] ?? "No username";
//       });
//     }
//   }

//   Future<void> logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return buildSettingsMenu(context);
//                 },
//               );
//             },
//           ),
//         ],
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               buildProfileHeader(),
//               SizedBox(height: 20),
//               buildPointsSection(),
//               SizedBox(height: 20),
//               // buildFollowSection(),
//               buildTasksSection(),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildProfileHeader() {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 50,
//           backgroundImage: AssetImage('assets/profile.jpg'),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               username,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               email,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget buildPointsSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Points',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.green[700],
//               ),
//             ),
//             Text(
//               points.toString(),
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Navigate to Rewards Page
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.orange[600],
//             padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//             textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           child: Text('Rewards'),
//         ),
//       ],
//     );
//   }

//   ///follower
//   // Widget buildFollowSection() {
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //     children: [
//   //       Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Text(
//   //             'Followers',
//   //             style: TextStyle(
//   //               fontSize: 18,
//   //               fontWeight: FontWeight.w600,
//   //               color: Colors.green[700],
//   //             ),
//   //           ),
//   //           Text(
//   //             '300',
//   //             style: TextStyle(
//   //               fontSize: 24,
//   //               fontWeight: FontWeight.bold,
//   //               color: Colors.black,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //       Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Text(
//   //             'Following',
//   //             style: TextStyle(
//   //               fontSize: 18,
//   //               fontWeight: FontWeight.w600,
//   //               color: Colors.green[700],
//   //             ),
//   //           ),
//   //           Text(
//   //             '180',
//   //             style: TextStyle(
//   //               fontSize: 24,
//   //               fontWeight: FontWeight.bold,
//   //               color: Colors.black,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget buildTasksSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Tasks',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.green[700],
//           ),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 150,
//                 margin: EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(tasks[index]),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildSettingsMenu(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(Icons.help),
//             title: Text('Help'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Help Page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.edit),
//             title: Text('Edit Profile'),
//             onTap: () {
//               Navigator.pop(context);
//               // Navigate to Edit Profile Page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               Navigator.pop(context);
//               logout();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
// ///end  test/// updated code 👇
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart'; // Ensure this points to your actual login page

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  String username = "Loading...";
  String email = "Loading...";
  int points = 150;
  List<String> tasks = [
    'assets/task1.jpg',
    'assets/task2.jpg',
    'assets/task3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      setState(() {
        user = firebaseUser;
        email = firebaseUser.email ?? "No email";
      });

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      setState(() {
        username = userDoc['username'] ?? "No username";
      });
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return buildSettingsMenu(context);
                },
              );
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildProfileHeader(),
              SizedBox(height: 20),
              buildPointsSection(),
              SizedBox(height: 20),
              buildTasksSection(),
              SizedBox(height: 20),
              buildCommunityPostsSection(), // Add this line
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPointsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Points',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),
            Text(
              points.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            // Navigate to Rewards Page
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[600],
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: Text('Rewards'),
        ),
      ],
    );
  }

  Widget buildTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tasks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.green[700],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(tasks[index]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget buildCommunityPostsSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Community Posts',
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.w600,
  //           color: Colors.green[700],
  //         ),
  //       ),
  //       SizedBox(height: 10),
  //       Container(
  //         height: 300, // Adjust height as needed
  //         child: StreamBuilder(
  //           stream: FirebaseFirestore.instance
  //               .collection('community_posts')
  //               .orderBy('timestamp', descending: true)
  //               .snapshots(),
  //           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //             if (!snapshot.hasData) {
  //               return Center(child: CircularProgressIndicator());
  //             }

  //             return ListView.builder(
  //               itemCount: snapshot.data!.docs.length,
  //               itemBuilder: (context, index) {
  //                 var post = snapshot.data!.docs[index];
  //                 return Card(
  //                   margin: EdgeInsets.all(8.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       if (post['imageUrl'] != null)
  //                         Image.network(
  //                           post['imageUrl'],
  //                           width: double.infinity,
  //                           height: 200,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Text(post['text'] ?? ''),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget buildCommunityPostsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Community Posts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.green[700],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 500, // Set the width
          height: 322, // Set the height
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
      ],
    );
  }

  Widget buildSettingsMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Help Page
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Edit Profile Page
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              logout();
            },
          ),
        ],
      ),
    );
  }
}

//////////////////////updated code 👆
