// // import 'dart:ffi';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../../global/common/toast.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text("HomePage"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   _createData(UserModel(
//                     username: "Henry",
//                     age: 21,
//                     adress: "London",
//                   ));
//                 },
//                 child: Container(
//                   height: 45,
//                   width: 100,
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Center(
//                     child: Text(
//                       "Create Data",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               StreamBuilder<List<UserModel>>(
//                   stream: _readData(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     if (snapshot.data!.isEmpty) {
//                       return Center(child: Text("No Data Yet"));
//                     }
//                     final users = snapshot.data;
//                     return Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Column(
//                           children: users!.map((user) {
//                         return ListTile(
//                           leading: GestureDetector(
//                             onTap: () {
//                               _deleteData(user.id!);
//                             },
//                             child: Icon(Icons.delete),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               _updateData(UserModel(
//                                 id: user.id,
//                                 username: "John Wick",
//                                 adress: "Pakistan",
//                               ));
//                             },
//                             child: Icon(Icons.update),
//                           ),
//                           title: Text(user.username!),
//                           subtitle: Text(user.adress!),
//                         );
//                       }).toList()),
//                     );
//                   }),
//               GestureDetector(
//                 onTap: () {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.pushNamed(context, "/login");
//                   showToast(message: "Successfully signed out");
//                 },
//                 child: Container(
//                   height: 45,
//                   width: 100,
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Center(
//                     child: Text(
//                       "Sign out",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }

//   Stream<List<UserModel>> _readData() {
//     final userCollection = FirebaseFirestore.instance.collection("users");

//     return userCollection.snapshots().map((qureySnapshot) => qureySnapshot.docs
//         .map(
//           (e) => UserModel.fromSnapshot(e),
//         )
//         .toList());
//   }

//   void _createData(UserModel userModel) {
//     final userCollection = FirebaseFirestore.instance.collection("users");

//     String id = userCollection.doc().id;

//     final newUser = UserModel(
//       username: userModel.username,
//       age: userModel.age,
//       adress: userModel.adress,
//       id: id,
//     ).toJson();

//     userCollection.doc(id).set(newUser);
//   }

//   void _updateData(UserModel userModel) {
//     final userCollection = FirebaseFirestore.instance.collection("users");

//     final newData = UserModel(
//       username: userModel.username,
//       id: userModel.id,
//       adress: userModel.adress,
//       age: userModel.age,
//     ).toJson();

//     userCollection.doc(userModel.id).update(newData);
//   }

//   void _deleteData(String id) {
//     final userCollection = FirebaseFirestore.instance.collection("users");

//     userCollection.doc(id).delete();
//   }
// }

// class UserModel {
//   final String? username;
//   final String? adress;
//   final int? age;
//   final String? id;

//   UserModel({this.id, this.username, this.adress, this.age});

//   static UserModel fromSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     return UserModel(
//       username: snapshot['username'],
//       adress: snapshot['adress'],
//       age: snapshot['age'],
//       id: snapshot['id'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "username": username,
//       "age": age,
//       "id": id,
//       "adress": adress,
//     };
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     HomeContent(),
//     TaskPage(),
//     CommunityPage(),
//     ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("HomePage"),
//       ),
//       body: _pages[_selectedIndex],
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
//         //test
//         //end test
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Image.network('https://via.placeholder.com/300x100', height: 100),
//           SizedBox(height: 10),
//           Image.network('https://via.placeholder.com/300x100', height: 100),
//           // Add more content as needed
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:careclimate/features/user_auth/presentation/pages/taskverificationpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     HomeContent(),
//     TaskPage(),
//     CommunityPage(),
//     ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("HomePage"),
//       ),
//       body: _pages[_selectedIndex],
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
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.white,
//         backgroundColor: Colors.black, // Set the background color to black
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Image.network('https://via.placeholder.com/300x100', height: 100),
//           SizedBox(height: 10),
//           Image.network('https://via.placeholder.com/300x100', height: 100),
//           // Add more content as needed
//         ],
//       ),
//     );
//   }
// }
///////correct code tested ///////
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     HomeContent(),
//     TaskPage(),
//     CommunityPage(),
//     ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Climate Care",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: _pages[_selectedIndex],
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
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.white,
//         backgroundColor: Colors.black,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage('https://via.placeholder.com/800x400'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 10,
//                 left: 10,
//                 child: Text(
//                   'Welcome to Climate Care',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     backgroundColor: Colors.black54,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 Card(
//                   elevation: 5,
//                   child: ListTile(
//                     leading: Icon(Icons.info, color: Colors.blue),
//                     title: Text('Daily Tips'),
//                     subtitle: Text(
//                         'Get daily tips to improve your carbon footprint.'),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Navigate to tips page
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Card(
//                   elevation: 5,
//                   child: ListTile(
//                     leading: Icon(Icons.trending_up, color: Colors.green),
//                     title: Text('Global Challenges'),
//                     subtitle:
//                         Text('Join global challenges to make a difference.'),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Navigate to challenges page
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
///////End  correct code tested ///////
///
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     HomeContent(),
//     TaskPage(),
//     CommunityPage(),
//     ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("HomePage"),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: _pages[_selectedIndex],
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
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Image.network('https://via.placeholder.com/300x100', height: 100),
//           SizedBox(height: 10),
//           Image.network('https://via.placeholder.com/300x100', height: 100),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   int _currentBannerIndex = 0;
//   final List<String> _bannerImages = [
//     'https://img.freepik.com/free-vector/hand-drawn-flat-design-climate-change-facebook-cover_23-2149092322.jpg',
//     'https://img.freepik.com/free-vector/hand-drawn-flat-design-climate-change-facebook-cover_23-2149092322.jpg'
//   ];
//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Simulated task data
//   final Map<String, List<String>> _tasks = {
//     'Mon': ['Task 1', 'Task 2', 'Task 3'],
//     'Tue': ['Task 4', 'Task 5', 'Task 6'],
//     'Wed': ['Task 7', 'Task 8', 'Task 9'],
//     'Thu': ['Task 10', 'Task 11', 'Task 12'],
//     'Fri': ['Task 13', 'Task 14', 'Task 15'],
//     'Sat': ['Task 16', 'Task 17', 'Task 18'],
//     'Sun': ['Task 19', 'Task 20', 'Task 21'],
//   };

//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       setState(() {
//         _currentBannerIndex = (_currentBannerIndex + 1) % _bannerImages.length;
//       });
//     });
//   }

//   String getTodayTask() {
//     String today = DateTime.now().weekday.toString();
//     return today;
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     switch (today) {
//       case '1':
//         return _tasks['Mon']!;
//       case '2':
//         return _tasks['Tue']!;
//       case '3':
//         return _tasks['Wed']!;
//       case '4':
//         return _tasks['Thu']!;
//       case '5':
//         return _tasks['Fri']!;
//       case '6':
//         return _tasks['Sat']!;
//       case '7':
//         return _tasks['Sun']!;
//       default:
//         return [];
//     }
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           CommunityPage(),
//           ProfilePage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildBannerSection(),
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue),
//       ),
//       child: Stack(
//         children: [
//           Center(
//             child: Image.network(
//               _bannerImages[_currentBannerIndex],
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           Positioned(
//             left: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex - 1 + _bannerImages.length) %
//                           _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex + 1) % _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_forward_ios),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//           ),
//           child: ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(tasks[index]),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost('Shawn Mendes', 'https://example.com/photo1.jpg',
//             '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost(
//             'User 2', 'https://example.com/photo2.jpg', '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imageUrl, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.network(
//             imageUrl,
//             height: 100,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// class TaskPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//       ),
//       body: Center(
//         child: Text('Tasks Page'),
//       ),
//     );
//   }
// }

// class CommunityPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community'),
//       ),
//       body: Center(
//         child: Text('Community Page'),
//       ),
//     );
//   }
// }

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Text('Profile Page'),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
// import 'package:flutter/material.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart'
//     as auth_community;
// import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart'
//     as auth_profile;
// // Remove the conflicting imports or rename the conflicting classes if necessary

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   int _currentBannerIndex = 0;
//   final List<String> _bannerImages = [
//     'https://img.freepik.com/free-vector/hand-drawn-flat-design-climate-change-facebook-cover_23-2149092322.jpg',
//     'https://img.freepik.com/free-vector/hand-drawn-flat-design-climate-change-facebook-cover_23-2149092322.jpg'
//   ];
//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Simulated task data
//   final Map<String, List<String>> _tasks = {
//     'Mon': ['Task 1', 'Task 2', 'Task 3'],
//     'Tue': ['Task 4', 'Task 5', 'Task 6'],
//     'Wed': ['Task 7', 'Task 8', 'Task 9'],
//     'Thu': ['Task 10', 'Task 11', 'Task 12'],
//     'Fri': ['Task 13', 'Task 14', 'Task 15'],
//     'Sat': ['Task 16', 'Task 17', 'Task 18'],
//     'Sun': ['Task 19', 'Task 20', 'Task 21'],
//   };

//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       setState(() {
//         _currentBannerIndex = (_currentBannerIndex + 1) % _bannerImages.length;
//       });
//     });
//   }

//   String getTodayTask() {
//     String today = DateTime.now().weekday.toString();
//     return today;
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     switch (today) {
//       case '1':
//         return _tasks['Mon']!;
//       case '2':
//         return _tasks['Tue']!;
//       case '3':
//         return _tasks['Wed']!;
//       case '4':
//         return _tasks['Thu']!;
//       case '5':
//         return _tasks['Fri']!;
//       case '6':
//         return _tasks['Sat']!;
//       case '7':
//         return _tasks['Sun']!;
//       default:
//         return [];
//     }
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           auth_community.CommunityPage(),
//           auth_profile.ProfilePage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildBannerSection(),
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue),
//       ),
//       child: Stack(
//         children: [
//           Center(
//             child: Image.network(
//               _bannerImages[_currentBannerIndex],
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           Positioned(
//             left: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex - 1 + _bannerImages.length) %
//                           _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex + 1) % _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_forward_ios),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//           ),
//           child: ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(tasks[index]),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost('Shawn Mendes', 'https://example.com/photo1.jpg',
//             '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost(
//             'User 2', 'https://example.com/photo2.jpg', '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imageUrl, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.network(
//             imageUrl,
//             height: 100,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// class TaskPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//       ),
//       body: Center(
//         child: Text('Tasks Page'),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
///////tttt///////////
// import 'package:flutter/material.dart';
// import 'dart:async';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   int _currentBannerIndex = 0;
//   final List<String> _banners = ['Banner 1', 'Banner 2'];
//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Simulated task data
//   final Map<String, List<String>> _tasks = {
//     'Mon': ['Task 1', 'Task 2', 'Task 3'],
//     'Tue': ['Task 4', 'Task 5', 'Task 6'],
//     'Wed': ['Task 7', 'Task 8', 'Task 9'],
//     'Thu': ['Task 10', 'Task 11', 'Task 12'],
//     'Fri': ['Task 13', 'Task 14', 'Task 15'],
//     'Sat': ['Task 16', 'Task 17', 'Task 18'],
//     'Sun': ['Task 19', 'Task 20', 'Task 21'],
//   };

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       setState(() {
//         _currentBannerIndex = (_currentBannerIndex + 1) % _banners.length;
//       });
//     });
//   }

//   String getTodayTask() {
//     String today = DateTime.now().weekday.toString();
//     return today;
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     switch (today) {
//       case '1':
//         return _tasks['Mon']!;
//       case '2':
//         return _tasks['Tue']!;
//       case '3':
//         return _tasks['Wed']!;
//       case '4':
//         return _tasks['Thu']!;
//       case '5':
//         return _tasks['Fri']!;
//       case '6':
//         return _tasks['Sat']!;
//       case '7':
//         return _tasks['Sun']!;
//       default:
//         return [];
//     }
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildBannerSection(),
//               SizedBox(height: 20),
//               buildCO2eqButtons(),
//               SizedBox(height: 20),
//               buildTodayTaskSection(),
//               SizedBox(height: 20),
//               buildCommunitySection(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue),
//       ),
//       child: Stack(
//         children: [
//           Center(
//               child: Text(_banners[_currentBannerIndex],
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
//           Positioned(
//             left: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex - 1 + _banners.length) %
//                           _banners.length;
//                 });
//               },
//               child: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex + 1) % _banners.length;
//                 });
//               },
//               child: Icon(Icons.arrow_forward_ios),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//           ),
//           child: ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(tasks[index]),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost('Shawn Mendes', 'photo', '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost('User 2', 'photo', '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imagePath, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Container(
//             height: 100,
//             color: Colors.grey,
//             child: Center(child: Text(imagePath)),
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
/////
///test3
import 'package:flutter/material.dart';
import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart'
    as auth_task;
import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart'
    as auth_community;
import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart'
    as auth_profile;

// // Remove the conflicting imports or rename the conflicting classes if necessary

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   int _currentBannerIndex = 0;
//   final List<String> _bannerImages = [
//     'https://img.freepik.com/free-vector/hand-drawn-flat-design-climate-change-facebook-cover_23-2149092322.jpg',
//     'https://img.freepik.com/free-vector/hand-drawn-flat-design-climate-change-facebook-cover_23-2149092322.jpg'
//   ];
//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Simulated task data
//   final Map<String, List<String>> _tasks = {
//     'Mon': ['Task 1', 'Task 2', 'Task 3'],
//     'Tue': ['Task 4', 'Task 5', 'Task 6'],
//     'Wed': ['Task 7', 'Task 8', 'Task 9'],
//     'Thu': ['Task 10', 'Task 11', 'Task 12'],
//     'Fri': ['Task 13', 'Task 14', 'Task 15'],
//     'Sat': ['Task 16', 'Task 17', 'Task 18'],
//     'Sun': ['Task 19', 'Task 20', 'Task 21'],
//   };

//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       setState(() {
//         _currentBannerIndex = (_currentBannerIndex + 1) % _bannerImages.length;
//       });
//     });
//   }

//   String getTodayTask() {
//     String today = DateTime.now().weekday.toString();
//     return today;
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     switch (today) {
//       case '1':
//         return _tasks['Mon']!;
//       case '2':
//         return _tasks['Tue']!;
//       case '3':
//         return _tasks['Wed']!;
//       case '4':
//         return _tasks['Thu']!;
//       case '5':
//         return _tasks['Fri']!;
//       case '6':
//         return _tasks['Sat']!;
//       case '7':
//         return _tasks['Sun']!;
//       default:
//         return [];
//     }
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           auth_community.CommunityPage(),
//           auth_profile.ProfilePage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildBannerSection(),
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue),
//       ),
//       child: Stack(
//         children: [
//           Center(
//             child: Image.network(
//               _bannerImages[_currentBannerIndex],
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           Positioned(
//             left: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex - 1 + _bannerImages.length) %
//                           _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex + 1) % _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_forward_ios),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//           ),
//           child: ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(tasks[index]),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost('Shawn Mendes', 'https://example.com/photo1.jpg',
//             '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost(
//             'User 2', 'https://example.com/photo2.jpg', '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imageUrl, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.network(
//             imageUrl,
//             height: 100,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// class TaskPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//       ),
//       body: Center(
//         child: Text('Tasks Page'),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
///end test3
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     HomeContent(),
//     TaskPage(),
//     CommunityPage(),
//     ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Climate Care",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: _pages[_selectedIndex],
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
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage('https://via.placeholder.com/800x400'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 10,
//                 left: 10,
//                 child: Text(
//                   'Welcome to Climate Care',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     backgroundColor: Colors.black54,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 Card(
//                   elevation: 5,
//                   child: ListTile(
//                     leading: Icon(Icons.info, color: Colors.blue),
//                     title: Text('Daily Tips'),
//                     subtitle: Text(
//                         'Get daily tips to improve your carbon footprint.'),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Navigate to tips page
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Card(
//                   elevation: 5,
//                   child: ListTile(
//                     leading: Icon(Icons.trending_up, color: Colors.green),
//                     title: Text('Global Challenges'),
//                     subtitle:
//                         Text('Join global challenges to make a difference.'),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Navigate to challenges page
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
/////////////////correct code 55555
// import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart'
//     as auth_community;
// import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart'
//     as auth_profile; // Ensure this import is correct

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   int _currentBannerIndex = 0;
//   final List<Widget> _pages = [
//     HomePage(),
//     TaskPage(),
//     CommunityPage(),
//     ProfilePage(),
//   ];
//   final List<String> _bannerImages = [
//     'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngtree.com%2Ffree-business-banner&psig=AOvVaw0qB6Ag3wJZNPfcuxyNMVgf&ust=1723114686307000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIj8wsnc4ocDFQAAAAAdAAAAABAE',
//     'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fbanner-design&psig=AOvVaw0qB6Ag3wJZNPfcuxyNMVgf&ust=1723114686307000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIj8wsnc4ocDFQAAAAAdAAAAABAQ'
//   ];
//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Simulated task data
//   final Map<String, List<String>> _tasks = {
//     'Mon': ['Task 1', 'Task 2', 'Task 3'],
//     'Tue': ['Task 4', 'Task 5', 'Task 6'],
//     'Wed': ['Task 7', 'Task 8', 'Task 9'],
//     'Thu': ['Task 10', 'Task 11', 'Task 12'],
//     'Fri': ['Task 13', 'Task 14', 'Task 15'],
//     'Sat': ['Task 16', 'Task 17', 'Task 18'],
//     'Sun': ['Task 19', 'Task 20', 'Task 21'],
//   };

//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       setState(() {
//         _currentBannerIndex = (_currentBannerIndex + 1) % _bannerImages.length;
//       });
//     });
//   }

//   String getTodayTask() {
//     String today = DateTime.now().weekday.toString();
//     return today;
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     switch (today) {
//       case '1':
//         return _tasks['Mon']!;
//       case '2':
//         return _tasks['Tue']!;
//       case '3':
//         return _tasks['Wed']!;
//       case '4':
//         return _tasks['Thu']!;
//       case '5':
//         return _tasks['Fri']!;
//       case '6':
//         return _tasks['Sat']!;
//       case '7':
//         return _tasks['Sun']!;
//       default:
//         return [];
//     }
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           auth_community.CommunityPage(),
//           auth_profile.ProfilePage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildBannerSection(),
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue),
//       ),
//       child: Stack(
//         children: [
//           Center(
//             child: Image.network(
//               _bannerImages[_currentBannerIndex],
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           Positioned(
//             left: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex - 1 + _bannerImages.length) %
//                           _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex + 1) % _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_forward_ios),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//           ),
//           child: ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(tasks[index]),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost(
//             'Shawn Mendes',
//             'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fbanner-design&psig=AOvVaw0qB6Ag3wJZNPfcuxyNMVgf&ust=1723114686307000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIj8wsnc4ocDFQAAAAAdAAAAABAQ',
//             '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost(
//             'User 2',
//             'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fbanner-design&psig=AOvVaw0qB6Ag3wJZNPfcuxyNMVgf&ust=1723114686307000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIj8wsnc4ocDFQAAAAAdAAAAABAQ',
//             '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imageUrl, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.network(
//             imageUrl,
//             height: 100,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
///////////// updated code where borders are remove 666666
// import 'package:flutter/material.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart'
//     as auth_community;
// import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart'
//     as auth_profile;

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   int _currentBannerIndex = 0;
//   final List<Widget> _pages = [
//     HomePage(),
//     TaskPage(),
//     CommunityPage(),
//     ProfilePage(),
//   ];
//   final List<String> _bannerImages = [
//     'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngtree.com%2Ffree-business-banner&psig=AOvVaw0qB6Ag3wJZNPfcuxyNMVgf&ust=1723114686307000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIj8wsnc4ocDFQAAAAAdAAAAABAE',
//     'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fbanner-design&psig=AOvVaw0qB6Ag3wJZNPfcuxyNMVgf&ust=1723114686307000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIj8wsnc4ocDFQAAAAAdAAAAABAQ'
//   ];
//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Simulated task data
//   final Map<String, List<String>> _tasks = {
//     'Mon': ['Task 1', 'Task 2', 'Task 3'],
//     'Tue': ['Task 4', 'Task 5', 'Task 6'],
//     'Wed': ['Task 7', 'Task 8', 'Task 9'],
//     'Thu': ['Task 10', 'Task 11', 'Task 12'],
//     'Fri': ['Task 13', 'Task 14', 'Task 15'],
//     'Sat': ['Task 16', 'Task 17', 'Task 18'],
//     'Sun': ['Task 19', 'Task 20', 'Task 21'],
//   };

//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       setState(() {
//         _currentBannerIndex = (_currentBannerIndex + 1) % _bannerImages.length;
//       });
//     });
//   }

//   String getTodayTask() {
//     int today = DateTime.now().weekday;
//     switch (today) {
//       case DateTime.monday:
//         return 'Mon';
//       case DateTime.tuesday:
//         return 'Tue';
//       case DateTime.wednesday:
//         return 'Wed';
//       case DateTime.thursday:
//         return 'Thu';
//       case DateTime.friday:
//         return 'Fri';
//       case DateTime.saturday:
//         return 'Sat';
//       case DateTime.sunday:
//         return 'Sun';
//       default:
//         return '';
//     }
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     return _tasks[today] ?? [];
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           auth_community.CommunityPage(),
//           auth_profile.ProfilePage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildBannerSection(),
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//           // Remove border decoration
//           ),
//       child: Stack(
//         children: [
//           Center(
//             child: Image.network(
//               _bannerImages[_currentBannerIndex],
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           Positioned(
//             left: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex - 1 + _bannerImages.length) %
//                           _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex + 1) % _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_forward_ios),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           height: 150,
//           // Remove border decoration
//           child: ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(tasks[index]),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost(
//             'Shawn Mendes',
//             'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fbanner-design&psig=AOvVaw0qB6Ag3wJZNPfcuxyNMVgf&ust=1723114686307000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIj8wsnc4ocDFQAAAAAdAAAAABAQ',
//             '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost(
//             'User 2',
//             'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fbanner-design&psig=AOvVaw0qB6Ag3wJZNPfcuxyNMVgf&ust=1723114686307000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIj8wsnc4ocDFQAAAAAdAAAAABAQ',
//             '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imageUrl, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           // Remove border decoration
//           ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.network(
//             imageUrl,
//             height: 100,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
/////////////////end correct code 777777
// import 'package:flutter/material.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart'
//     as auth_community;
// import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart'
//     as auth_profile;
// import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   int _currentBannerIndex = 0;
//   final List<Widget> _pages = [
//     HomePage(),
//     TaskPage(),
//     auth_community.CommunityPage(),
//     auth_profile.ProfilePage(),
//   ];
//   final List<String> _bannerImages = [
//     'C:\Users\DELL\Downloads\careclimate\lib\assets\image.png',
//     // 'https://firebasestorage.googleapis.com/v0/b/careclimate-95ea3.appspot.com/Screenshot 2024-08-06 202013.png',
//   ];

//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Replace with your own implementation
//   final Map<String, List<String>> _weeklyTasks = {
//     'Mon': [
//       '1. Unplug all electronics not in use 🔌',
//       '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//       '3. Swap out one incandescent lightbulb 💡 for an LED',
//       '4. Take a shorter shower 🚿',
//       '5. Air dry dishes instead of using the dishwasher',
//     ],
//     'Tue': [
//       '1. Bring reusable bags to the grocery store 🛍️',
//       '2. Start a compost bin 🗑️ for food scraps',
//       '3. Recycle ♻️ paper, plastic, and glass',
//       '4. Avoid single-use plastics',
//       '5. Pack a reusable lunch',
//     ],
//     'Wed': [
//       '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//       '2. Use public transportation 🚌 if available',
//       '3. Carpool with a coworker or friend 🚗',
//       '4. Combine errands to reduce trips',
//       '5. Check tire pressure to improve fuel efficiency',
//     ],
//     'Thu': [
//       '1. Buy local and seasonal produce 🛒',
//       '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//       '3. Repair 🛠️ instead of replace items when possible',
//       '4. Choose products with minimal packaging',
//       '5. Donate unwanted items to charity 🤝',
//     ],
//     'Fri': [
//       '1. Fix any leaky faucets or pipes 🚰',
//       '2. Collect rainwater for watering plants 💧',
//       '3. Take shorter showers 🚿',
//       '4. Turn off the water while brushing your teeth 🚰',
//       '5. Use a broom 🧹 instead of a hose to clean outdoor areas',
//     ],
//     'Sat': [
//       '1. Share climate change information on social media 🌍',
//       '2. Contact your elected officials about climate policies',
//       '3. Support businesses with sustainable practices',
//       '4. Join a local environmental group 🤝',
//       '5. Plant 🌱 a tree or participate in a community clean-up',
//     ],
//     'Sun': [
//       '1. Review 👀 your week\'s actions and identify areas for improvement',
//       '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//       '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//       '4. Explore additional ways to reduce your carbon footprint 🐾',
//       '5. Celebrate your achievements and inspire others 🎉🥳🎊',
//     ],
//   };

//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       setState(() {
//         _currentBannerIndex = (_currentBannerIndex + 1) % _bannerImages.length;
//       });
//     });
//   }

//   String getTodayTask() {
//     int today = DateTime.now().weekday;
//     switch (today) {
//       case DateTime.monday:
//         return 'Mon';
//       case DateTime.tuesday:
//         return 'Tue';
//       case DateTime.wednesday:
//         return 'Wed';
//       case DateTime.thursday:
//         return 'Thu';
//       case DateTime.friday:
//         return 'Fri';
//       case DateTime.saturday:
//         return 'Sat';
//       case DateTime.sunday:
//         return 'Sun';
//       default:
//         return '';
//     }
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     return _weeklyTasks[today] ?? [];
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           auth_community.CommunityPage(),
//           auth_profile.ProfilePage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildBannerSection(),
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//           // Remove border decoration
//           ),
//       child: Stack(
//         children: [
//           Center(
//             child: Image.network(
//               _bannerImages[_currentBannerIndex],
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           Positioned(
//             left: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex - 1 + _bannerImages.length) %
//                           _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 90,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentBannerIndex =
//                       (_currentBannerIndex + 1) % _bannerImages.length;
//                 });
//               },
//               child: Icon(Icons.arrow_forward_ios),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           padding: EdgeInsets.all(16.0), // Add padding inside the border
//           decoration: BoxDecoration(
//             color: Colors.white, // Background color of the container
//             border: Border.all(
//               color: Colors.green, // Border color
//               width: 2.0, // Border width
//             ),
//             borderRadius: BorderRadius.circular(10.0), // Rounded corners
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 150,
//                 child: ListView.builder(
//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(tasks[index]),
//                       trailing: IconButton(
//                         icon: Icon(Icons.add, color: Colors.green),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   TaskVerificationPage(taskName: tasks[index]),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost('Shawn Mendes',
//             'https://www.example.com/community1.png', '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost('User 2', 'https://www.example.com/community2.png',
//             '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imageUrl, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           // Remove border decoration
//           ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.network(
//             imageUrl,
//             height: 100,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
///////////////////////////// 8888888
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Auto-changing Banner Widget
//             BannerWidget(),

//             // Tasks List with Checkboxes
//             TaskList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BannerWidget extends StatefulWidget {
//   @override
//   _BannerWidgetState createState() => _BannerWidgetState();
// }

// class _BannerWidgetState extends State<BannerWidget> {
//   int _currentIndex = 0;
//   final List<String> _imageUrls = [
//     'https://ichef.bbci.co.uk/news/976/cpsprodpb/2B08/production/_127561011_climate_5_cc_index_and_article_image_template_976-ncclimate_change_article_image_template_976-nc.png',
//     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwS3g0_vRZx1PNb81amvmpWfpiNWGLeV4zVA&s',
//     'https://ichef.bbci.co.uk/news/976/cpsprodpb/2B08/production/_127561011_climate_5_cc_index_and_article_image_template_976-ncclimate_change_article_image_template_976-nc.png',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: PageView.builder(
//         itemCount: _imageUrls.length,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         itemBuilder: (context, index) {
//           return CachedNetworkImage(
//             imageUrl: _imageUrls[index],
//             placeholder: (context, url) =>
//                 Center(child: CircularProgressIndicator()),
//             errorWidget: (context, url, error) => Icon(Icons.error),
//             fit: BoxFit.cover,
//           );
//         },
//       ),
//     );
//   }
// }

// class TaskList extends StatelessWidget {
//   final List<String> tasks = [
//     'Plant a tree or water plants',
//     'Use public transport',
//     'Avoid using AC',
//     'Don\'t waste food',
//     'Reuse clothes',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: tasks
//           .map((task) => TaskItem(
//                 task: task,
//               ))
//           .toList(),
//     );
//   }
// }

// class TaskItem extends StatefulWidget {
//   final String task;

//   const TaskItem({Key? key, required this.task}) : super(key: key);

//   @override
//   _TaskItemState createState() => _TaskItemState();
// }

// class _TaskItemState extends State<TaskItem> {
//   bool _isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(widget.task),
//       trailing: Checkbox(
//         value: _isChecked,
//         onChanged: (value) {
//           setState(() {
//             _isChecked = value ?? false;
//           });
//         },
//       ),
//     );
//   }
// }
////////////////////////////// updated code 👇 999999
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';
// import 'dart:async';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();

//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Replace with your own implementation
//   final Map<String, List<String>> _weeklyTasks = {
//     'Mon': [
//       '1. Unplug all electronics not in use 🔌',
//       '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//       '3. Swap out one incandescent lightbulb 💡 for an LED',
//       '4. Take a shorter shower 🚿',
//       '5. Air dry dishes instead of using the dishwasher',
//     ],
//     'Tue': [
//       '1. Bring reusable bags to the grocery store 🛍️',
//       '2. Start a compost bin 🗑️ for food scraps',
//       '3. Recycle ♻️ paper, plastic, and glass',
//       '4. Avoid single-use plastics',
//       '5. Pack a reusable lunch',
//     ],
//     'Wed': [
//       '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//       '2. Use public transportation 🚌 if available',
//       '3. Carpool with a coworker or friend 🚗',
//       '4. Combine errands to reduce trips',
//       '5. Check tire pressure to improve fuel efficiency',
//     ],
//     'Thu': [
//       '1. Buy local and seasonal produce 🛒',
//       '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//       '3. Repair 🛠️ instead of replace items when possible',
//       '4. Choose products with minimal packaging',
//       '5. Donate unwanted items to charity 🤝',
//     ],
//     'Fri': [
//       '1. Fix any leaky faucets or pipes 🚰',
//       '2. Collect rainwater for watering plants 💧',
//       '3. Take shorter showers 🚿',
//       '4. Turn off the water while brushing your teeth 🚰',
//       '5. Use a broom 🧹 instead of a hose to clean outdoor areas',
//     ],
//     'Sat': [
//       '1. Share climate change information on social media 🌍',
//       '2. Contact your elected officials about climate policies',
//       '3. Support businesses with sustainable practices',
//       '4. Join a local environmental group 🤝',
//       '5. Plant 🌱 a tree or participate in a community clean-up',
//     ],
//     'Sun': [
//       '1. Review 👀 your week\'s actions and identify areas for improvement',
//       '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//       '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//       '4. Explore additional ways to reduce your carbon footprint 🐾',
//       '5. Celebrate your achievements and inspire others 🎉🥳🎊',
//     ],
//   };

//   @override
//   void initState() {
//     super.initState();
//   }

//   String getTodayTask() {
//     int today = DateTime.now().weekday;
//     switch (today) {
//       case DateTime.monday:
//         return 'Mon';
//       case DateTime.tuesday:
//         return 'Tue';
//       case DateTime.wednesday:
//         return 'Wed';
//       case DateTime.thursday:
//         return 'Thu';
//       case DateTime.friday:
//         return 'Fri';
//       case DateTime.saturday:
//         return 'Sat';
//       case DateTime.sunday:
//         return 'Sun';
//       default:
//         return '';
//     }
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     return _weeklyTasks[today] ?? [];
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           auth_community.CommunityPage(),
//           auth_profile.ProfilePage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BannerWidget(), // Use the new BannerWidget
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           padding: EdgeInsets.all(16.0), // Add padding inside the border
//           decoration: BoxDecoration(
//             color: Colors.white, // Background color of the container
//             border: Border.all(
//               color: Colors.green, // Border color
//               width: 2.0, // Border width
//             ),
//             borderRadius: BorderRadius.circular(10.0), // Rounded corners
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 150,
//                 child: ListView.builder(
//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(tasks[index]),
//                       trailing: IconButton(
//                         icon: Icon(Icons.add, color: Colors.green),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   TaskVerificationPage(taskName: tasks[index]),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost('Shawn Mendes',
//             'https://www.example.com/community1.png', '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost('User 2', 'https://www.example.com/community2.png',
//             '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imageUrl, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           // Remove border decoration
//           ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.network(
//             imageUrl,
//             height: 100,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// class BannerWidget extends StatefulWidget {
//   @override
//   _BannerWidgetState createState() => _BannerWidgetState();
// }

// class _BannerWidgetState extends State<BannerWidget> {
//   int _currentIndex = 0;
//   final List<String> _imageUrls = [
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/climate%20change%20challengea.jpeg',
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/daily%20challenge.jpeg',
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/google%20climate%20care%20challenge.jpeg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: PageView.builder(
//         itemCount: _imageUrls.length,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         itemBuilder: (context, index) {
//           return CachedNetworkImage(
//             imageUrl: _imageUrls[index],
//             placeholder: (context, url) =>
//                 Center(child: CircularProgressIndicator()),
//             errorWidget: (context, url, error) => Icon(Icons.error),
//             fit: BoxFit.cover,
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
///////////////////////////updateed code 44444444444
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Ensure this is imported
import 'dart:async';

import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';
import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart'; // Ensure the correct import for CommunityPage
import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart'; // Ensure the correct import for ProfilePage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  int _reducedCO2eq =
      100; // This should dynamically update based on task completion

  final Map<String, List<String>> _weeklyTasks = {
    'Mon': [
      '1. Unplug all electronics not in use 🔌',
      '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
      '3. Swap out one incandescent lightbulb 💡 for an LED',
      '4. Take a shorter shower 🚿',
      '5. Air dry dishes instead of using the dishwasher',
    ],
    'Tue': [
      '1. Bring reusable bags to the grocery store 🛍️',
      '2. Start a compost bin 🗑️ for food scraps',
      '3. Recycle ♻️ paper, plastic, and glass',
      '4. Avoid single-use plastics',
      '5. Pack a reusable lunch',
    ],
    'Wed': [
      '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
      '2. Use public transportation 🚌 if available',
      '3. Carpool with a coworker or friend 🚗',
      '4. Combine errands to reduce trips',
      '5. Check tire pressure to improve fuel efficiency',
    ],
    'Thu': [
      '1. Buy local and seasonal produce 🛒',
      '2. Reduce meat consumption by trying a vegetarian meal 🍴',
      '3. Repair 🛠️ instead of replace items when possible',
      '4. Choose products with minimal packaging',
      '5. Donate unwanted items to charity 🤝',
    ],
    'Fri': [
      '1. Fix any leaky faucets or pipes 🚰',
      '2. Collect rainwater for watering plants 💧',
      '3. Take shorter showers 🚿',
      '4. Turn off the water while brushing your teeth 🚰',
      '5. Use a broom 🧹 instead of a hose to clean outdoor areas',
    ],
    'Sat': [
      '1. Share climate change information on social media 🌍',
      '2. Contact your elected officials about climate policies',
      '3. Support businesses with sustainable practices',
      '4. Join a local environmental group 🤝',
      '5. Plant 🌱 a tree or participate in a community clean-up',
    ],
    'Sun': [
      '1. Review 👀 your week\'s actions and identify areas for improvement',
      '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
      '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
      '4. Explore additional ways to reduce your carbon footprint 🐾',
      '5. Celebrate your achievements and inspire others 🎉🥳🎊',
    ],
  };

  @override
  void initState() {
    super.initState();
  }

  String getTodayTask() {
    int today = DateTime.now().weekday;
    switch (today) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  List<String> getTodayTasks() {
    String today = getTodayTask();
    return _weeklyTasks[today] ?? [];
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Climate Care'),
        backgroundColor: Colors.green[700],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          buildHomePage(),
          TaskPage(),
          CommunityPage(), // Correct import for CommunityPage
          ProfilePage(), // Correct import for ProfilePage
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget buildHomePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerWidget(), // Use the new BannerWidget
            SizedBox(height: 20),
            buildCO2eqButtons(),
            SizedBox(height: 20),
            buildTodayTaskSection(),
            SizedBox(height: 20),
            buildCommunityPostsSection(), // Updated method
          ],
        ),
      ),
    );
  }

  Widget buildCO2eqButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Column(
            children: [
              Text('Total CO2eq'),
              Text('37.15 BMT'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Column(
            children: [
              Text('Reduce CO2eq'),
              Text('$_reducedCO2eq'),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTodayTaskSection() {
    List<String> tasks = getTodayTasks();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.green,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Container(
                height: 150,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskVerificationPage(taskName: tasks[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
          width: 500,
          height: 322,
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
                          CachedNetworkImage(
                            imageUrl: post['imageUrl'],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
}

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0;
  final List<String> _imageUrls = [
    'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/climate%20change%20challengea.jpeg',
    'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/daily%20challenge.jpeg',
    'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/google%20climate%20care%20challenge.jpeg',
  ];

  Timer? _timer;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentIndex < _imageUrls.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        setState(() {
          _currentIndex = 0;
        });
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _imageUrls.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: _imageUrls[index],
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
// //////////////////////////////////////////////////////////////////////////

////////////////////////////////////////updated code 👇
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Ensure this is imported
// import 'dart:async';

// import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart'; // Ensure the correct import for CommunityPage
// import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart'; // Ensure the correct import for ProfilePage

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();

//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   final Map<String, List<String>> _weeklyTasks = {
//     'Mon': [
//       '1. Unplug all electronics not in use 🔌',
//       '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//       '3. Swap out one incandescent lightbulb 💡 for an LED',
//       '4. Take a shorter shower 🚿',
//       '5. Air dry dishes instead of using the dishwasher',
//     ],
//     'Tue': [
//       '1. Bring reusable bags to the grocery store 🛍️',
//       '2. Start a compost bin 🗑️ for food scraps',
//       '3. Recycle ♻️ paper, plastic, and glass',
//       '4. Avoid single-use plastics',
//       '5. Pack a reusable lunch',
//     ],
//     'Wed': [
//       '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//       '2. Use public transportation 🚌 if available',
//       '3. Carpool with a coworker or friend 🚗',
//       '4. Combine errands to reduce trips',
//       '5. Check tire pressure to improve fuel efficiency',
//     ],
//     'Thu': [
//       '1. Buy local and seasonal produce 🛒',
//       '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//       '3. Repair 🛠️ instead of replace items when possible',
//       '4. Choose products with minimal packaging',
//       '5. Donate unwanted items to charity 🤝',
//     ],
//     'Fri': [
//       '1. Fix any leaky faucets or pipes 🚰',
//       '2. Collect rainwater for watering plants 💧',
//       '3. Take shorter showers 🚿',
//       '4. Turn off the water while brushing your teeth 🚰',
//       '5. Use a broom 🧹 instead of a hose to clean outdoor areas',
//     ],
//     'Sat': [
//       '1. Share climate change information on social media 🌍',
//       '2. Contact your elected officials about climate policies',
//       '3. Support businesses with sustainable practices',
//       '4. Join a local environmental group 🤝',
//       '5. Plant 🌱 a tree or participate in a community clean-up',
//     ],
//     'Sun': [
//       '1. Review 👀 your week\'s actions and identify areas for improvement',
//       '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//       '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//       '4. Explore additional ways to reduce your carbon footprint 🐾',
//       '5. Celebrate your achievements and inspire others 🎉🥳🎊',
//     ],
//   };

//   @override
//   void initState() {
//     super.initState();
//   }

//   String getTodayTask() {
//     int today = DateTime.now().weekday;
//     switch (today) {
//       case DateTime.monday:
//         return 'Mon';
//       case DateTime.tuesday:
//         return 'Tue';
//       case DateTime.wednesday:
//         return 'Wed';
//       case DateTime.thursday:
//         return 'Thu';
//       case DateTime.friday:
//         return 'Fri';
//       case DateTime.saturday:
//         return 'Sat';
//       case DateTime.sunday:
//         return 'Sun';
//       default:
//         return '';
//     }
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     return _weeklyTasks[today] ?? [];
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           CommunityPage(), // Correct import for CommunityPage
//           ProfilePage(), // Correct import for ProfilePage
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BannerWidget(), // Use the new BannerWidget
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunityPostsSection(), // Updated method
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           padding: EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(
//               color: Colors.green,
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 150,
//                 child: ListView.builder(
//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(tasks[index]),
//                       trailing: IconButton(
//                         icon: Icon(Icons.add, color: Colors.green),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   TaskVerificationPage(taskName: tasks[index]),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunityPostsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Community Posts',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.green[700],
//           ),
//         ),
//         SizedBox(height: 10),
//         Container(
//           width: 500,
//           height: 322,
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('community_posts')
//                 .orderBy('timestamp', descending: true)
//                 .snapshots(),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }

//               return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   var post = snapshot.data!.docs[index];
//                   return Card(
//                     margin: EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (post['imageUrl'] != null)
//                           CachedNetworkImage(
//                             imageUrl: post['imageUrl'],
//                             width: double.infinity,
//                             height: 200,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) =>
//                                 Center(child: CircularProgressIndicator()),
//                             errorWidget: (context, url, error) =>
//                                 Icon(Icons.error),
//                           ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(post['text'] ?? ''),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BannerWidget extends StatefulWidget {
//   @override
//   _BannerWidgetState createState() => _BannerWidgetState();
// }

// class _BannerWidgetState extends State<BannerWidget> {
//   int _currentIndex = 0;
//   final List<String> _imageUrls = [
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/climate%20change%20challengea.jpeg',
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/daily%20challenge.jpeg',
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/google%20climate%20care%20challenge.jpeg',
//   ];

//   Timer? _timer;
//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     _startAutoSlide();
//   }

//   void _startAutoSlide() {
//     _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
//       if (_currentIndex < _imageUrls.length - 1) {
//         setState(() {
//           _currentIndex++;
//         });
//       } else {
//         setState(() {
//           _currentIndex = 0;
//         });
//       }
//       _pageController.animateToPage(
//         _currentIndex,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: PageView.builder(
//         controller: _pageController,
//         itemCount: _imageUrls.length,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         itemBuilder: (context, index) {
//           return CachedNetworkImage(
//             imageUrl: _imageUrls[index],
//             placeholder: (context, url) =>
//                 Center(child: CircularProgressIndicator()),
//             errorWidget: (context, url, error) => Icon(Icons.error),
//             fit: BoxFit.cover,
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
// ///////////////////////////updated code 👆
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';
// import 'dart:async';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();

//   int _reducedCO2eq =
//       100; // This should dynamically update based on task completion

//   // Replace with your own implementation
//   final Map<String, List<String>> _weeklyTasks = {
//     'Mon': [
//       '1. Unplug all electronics not in use 🔌',
//       '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//       '3. Swap out one incandescent lightbulb 💡 for an LED',
//       '4. Take a shorter shower 🚿',
//       '5. Air dry dishes instead of using the dishwasher',
//     ],
//     'Tue': [
//       '1. Bring reusable bags to the grocery store 🛍️',
//       '2. Start a compost bin 🗑️ for food scraps',
//       '3. Recycle ♻️ paper, plastic, and glass',
//       '4. Avoid single-use plastics',
//       '5. Pack a reusable lunch',
//     ],
//     'Wed': [
//       '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//       '2. Use public transportation 🚌 if available',
//       '3. Carpool with a coworker or friend 🚗',
//       '4. Combine errands to reduce trips',
//       '5. Check tire pressure to improve fuel efficiency',
//     ],
//     'Thu': [
//       '1. Buy local and seasonal produce 🛒',
//       '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//       '3. Repair 🛠️ instead of replace items when possible',
//       '4. Choose products with minimal packaging',
//       '5. Donate unwanted items to charity 🤝',
//     ],
//     'Fri': [
//       '1. Fix any leaky faucets or pipes 🚰',
//       '2. Collect rainwater for watering plants 💧',
//       '3. Take shorter showers 🚿',
//       '4. Turn off the water while brushing your teeth 🚰',
//       '5. Use a broom 🧹 instead of a hose to clean outdoor areas',
//     ],
//     'Sat': [
//       '1. Share climate change information on social media 🌍',
//       '2. Contact your elected officials about climate policies',
//       '3. Support businesses with sustainable practices',
//       '4. Join a local environmental group 🤝',
//       '5. Plant 🌱 a tree or participate in a community clean-up',
//     ],
//     'Sun': [
//       '1. Review 👀 your week\'s actions and identify areas for improvement',
//       '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//       '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//       '4. Explore additional ways to reduce your carbon footprint 🐾',
//       '5. Celebrate your achievements and inspire others 🎉🥳🎊',
//     ],
//   };

//   @override
//   void initState() {
//     super.initState();
//   }

//   String getTodayTask() {
//     int today = DateTime.now().weekday;
//     switch (today) {
//       case DateTime.monday:
//         return 'Mon';
//       case DateTime.tuesday:
//         return 'Tue';
//       case DateTime.wednesday:
//         return 'Wed';
//       case DateTime.thursday:
//         return 'Thu';
//       case DateTime.friday:
//         return 'Fri';
//       case DateTime.saturday:
//         return 'Sat';
//       case DateTime.sunday:
//         return 'Sun';
//       default:
//         return '';
//     }
//   }

//   List<String> getTodayTasks() {
//     String today = getTodayTask();
//     return _weeklyTasks[today] ?? [];
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Climate Care'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           buildHomePage(),
//           TaskPage(),
//           auth_community.CommunityPage(),
//           auth_profile.ProfilePage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Task',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget buildHomePage() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BannerWidget(), // Use the new BannerWidget
//             SizedBox(height: 20),
//             buildCO2eqButtons(),
//             SizedBox(height: 20),
//             buildTodayTaskSection(),
//             SizedBox(height: 20),
//             buildCommunitySection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCO2eqButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Total CO2eq'),
//               Text('37.15 BMT'),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {},
//           child: Column(
//             children: [
//               Text('Reduce CO2eq'),
//               Text('$_reducedCO2eq'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTodayTaskSection() {
//     List<String> tasks = getTodayTasks();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Today\'s Tasks', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         Container(
//           padding: EdgeInsets.all(16.0), // Add padding inside the border
//           decoration: BoxDecoration(
//             color: Colors.white, // Background color of the container
//             border: Border.all(
//               color: Colors.green, // Border color
//               width: 2.0, // Border width
//             ),
//             borderRadius: BorderRadius.circular(10.0), // Rounded corners
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 150,
//                 child: ListView.builder(
//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(tasks[index]),
//                       trailing: IconButton(
//                         icon: Icon(Icons.add, color: Colors.green),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   TaskVerificationPage(taskName: tasks[index]),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCommunitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Community', style: TextStyle(fontSize: 18)),
//         SizedBox(height: 10),
//         buildCommunityPost('Shawn Mendes',
//             'https://www.example.com/community1.png', '1,200,548 likes'),
//         SizedBox(height: 10),
//         buildCommunityPost('User 2', 'https://www.example.com/community2.png',
//             '845,230 likes'),
//       ],
//     );
//   }

//   Widget buildCommunityPost(String username, String imageUrl, String likes) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           // Remove border decoration
//           ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(child: Text(username[0])),
//               SizedBox(width: 10),
//               Text(username),
//             ],
//           ),
//           SizedBox(height: 10),
//           Image.network(
//             imageUrl,
//             height: 100,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           SizedBox(height: 10),
//           Text(likes),
//         ],
//       ),
//     );
//   }
// }

// class BannerWidget extends StatefulWidget {
//   @override
//   _BannerWidgetState createState() => _BannerWidgetState();
// }

// class _BannerWidgetState extends State<BannerWidget> {
//   int _currentIndex = 0;
//   final List<String> _imageUrls = [
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/climate%20change%20challengea.jpeg',
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/daily%20challenge.jpeg',
//     'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/google%20climate%20care%20challenge.jpeg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: PageView.builder(
//         itemCount: _imageUrls.length,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         itemBuilder: (context, index) {
//           return CachedNetworkImage(
//             imageUrl: _imageUrls[index],
//             placeholder: (context, url) =>
//                 Center(child: CircularProgressIndicator()),
//             errorWidget: (context, url, error) => Icon(Icons.error),
//             fit: BoxFit.cover,
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }
