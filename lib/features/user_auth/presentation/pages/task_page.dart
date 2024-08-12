// import 'package:flutter/material.dart';

// class TaskPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//       ),
//       body: Center(
//         child: Text('Task Page Content'),
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
//         currentIndex: 1, // Set the current index for TaskPage
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
//////////test
// import 'package:flutter/material.dart';

// class TaskPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to Daily Tasks
//                   },
//                   child: Text('Daily Tasks'),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to Global Challenge
//                   },
//                   child: Text('Global Challenge'),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Add Daily Task or Global Challenge details here
//         ],
//       ),
//     );
//   }
// }
// lib/features/user_auth/presentation/pages/task_page.dart
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'task_detail_page.dart'; // Add this import

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   bool _showWeekDays = false;
//   String _selectedDay = '';

//   void _showTasks(String day) {
//     setState(() {
//       _selectedDay = day;
//       _showWeekDays = true;
//     });
//   }

//   void _navigateToTaskDetails(String taskName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => TaskDetailsPage(taskName: taskName), // Corrected
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _showTasks('Daily Task'),
//                   child: Text('Daily Task'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => _showTasks('Global Challenge'),
//                   child: Text('Global Challenge'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (_showWeekDays)
//             Container(
//               height: 50,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   _buildDayButton('Mon'),
//                   _buildDayButton('Tue'),
//                   _buildDayButton('Wed'),
//                   _buildDayButton('Thu'),
//                   _buildDayButton('Fri'),
//                   _buildDayButton('Sat'),
//                   _buildDayButton('Sun'),
//                 ],
//               ),
//             ),
//           Expanded(
//             child: _selectedDay.isNotEmpty
//                 ? StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('tasks')
//                         .where('day', isEqualTo: _selectedDay)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       final tasks = snapshot.data!.docs;
//                       return ListView.builder(
//                         itemCount: tasks.length,
//                         itemBuilder: (context, index) {
//                           final task = tasks[index];
//                           return ListTile(
//                             title: Text(task['name']),
//                             trailing: IconButton(
//                               icon: Icon(Icons.add),
//                               onPressed: () =>
//                                   _navigateToTaskDetails(task['name']),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   )
//                 : Center(child: Text('Select a day to view tasks')),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDayButton(String day) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: ElevatedButton(
//         onPressed: () => setState(() {
//           _selectedDay = day;
//         }),
//         child: Text(day),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _selectedDay == day ? Colors.blue : Colors.grey,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//       ),
//     );
//   }
// }
///////////test 2 /////
// import 'package:flutter/material.dart';

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   // Variables to store selected options
//   String? selectedTaskCategory;
//   String? selectedTaskType;
//   double taskDuration = 0.5;
//   double taskWeight = 1500.0;
//   double numberOfOffsets = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My GHG Savings'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TaskCategorySelector(
//                 onChanged: (value) {
//                   setState(() {
//                     selectedTaskCategory = value;
//                   });
//                 },
//               ),
//               if (selectedTaskCategory == 'Appliances')
//                 ApplianceTask(
//                   taskDuration: taskDuration,
//                   onDurationChanged: (value) {
//                     setState(() {
//                       taskDuration = value;
//                     });
//                   },
//                 ),
//               if (selectedTaskCategory == 'Products')
//                 ProductTask(
//                   taskWeight: taskWeight,
//                   onWeightChanged: (value) {
//                     setState(() {
//                       taskWeight = value;
//                     });
//                   },
//                 ),
//               if (selectedTaskCategory == 'Travel')
//                 TravelTask(),
//               if (selectedTaskCategory == 'Aid')
//                 AidTask(
//                   numberOfOffsets: numberOfOffsets,
//                   onOffsetsChanged: (value) {
//                     setState(() {
//                       numberOfOffsets = value;
//                     });
//                   },
//                 ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Save record logic
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green[700],
//                 ),
//                 child: Text('Save Record'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TaskCategorySelector extends StatelessWidget {
//   final Function(String?) onChanged;

//   TaskCategorySelector({required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'My Savings',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         DropdownButton<String>(
//           hint: Text('Select Category'),
//           items: <String>['Appliances', 'Products', 'Travel', 'Aid']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }

// class ApplianceTask extends StatelessWidget {
//   final double taskDuration;
//   final Function(double) onDurationChanged;

//   ApplianceTask({required this.taskDuration, required this.onDurationChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Appliances',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Text('Cooking: Oven'),
//         DropdownButton<String>(
//           hint: Text('Select Task Type'),
//           items: <String>['Did not use oven', 'Used oven']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {},
//         ),
//         Text('Duration'),
//         Slider(
//           value: taskDuration,
//           min: 0,
//           max: 24,
//           divisions: 48,
//           label: '$taskDuration hours',
//           onChanged: onDurationChanged,
//         ),
//         SizedBox(height: 20),
//         MoreSpecs(),
//         OptionalDetails(),
//       ],
//     );
//   }
// }

// class ProductTask extends StatelessWidget {
//   final double taskWeight;
//   final Function(double) onWeightChanged;

//   ProductTask({required this.taskWeight, required this.onWeightChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Products',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Text('Transport'),
//         DropdownButton<String>(
//           hint: Text('Select Task Type'),
//           items: <String>['Car', 'Bike', 'Public Transport']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {},
//         ),
//         Text('Weight'),
//         Slider(
//           value: taskWeight,
//           min: 0,
//           max: 5000,
//           divisions: 100,
//           label: '$taskWeight kg',
//           onChanged: onWeightChanged,
//         ),
//         SizedBox(height: 20),
//         MoreSpecs(),
//         OptionalDetails(),
//       ],
//     );
//   }
// }

// class TravelTask extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Travel',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Text('Distance Travelled (Km)'),
//         TextField(
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             hintText: 'Enter distance',
//           ),
//         ),
//         Text('Travelled By'),
//         DropdownButton<String>(
//           hint: Text('Select Mode of Transport'),
//           items: <String>['Electric Bicycle', 'Car (alone)', 'Car (shared)']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {},
//         ),
//         MoreSpecs(),
//         OptionalDetails(),
//       ],
//     );
//   }
// }

// class AidTask extends StatelessWidget {
//   final double numberOfOffsets;
//   final Function(double) onOffsetsChanged;

//   AidTask({required this.numberOfOffsets, required this.onOffsetsChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Personal Social Responsibility',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Text('Forestry / Tree Plantation'),
//         DropdownButton<String>(
//           hint: Text('Select Task Type'),
//           items: <String>['Purchased Carbon Offsets', 'Forestry']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {},
//         ),
//         Text('Number of Carbon Offsets'),
//         Slider(
//           value: numberOfOffsets,
//           min: 0,
//           max: 10,
//           divisions: 10,
//           label: '$numberOfOffsets',
//           onChanged: onOffsetsChanged,
//         ),
//         SizedBox(height: 20),
//         OptionalDetails(),
//       ],
//     );
//   }
// }

// class MoreSpecs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       title: Text('More Specs'),
//       children: [
//         Text('Additional specifications can be added here.'),
//       ],
//     );
//   }
// }

// class OptionalDetails extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       title: Text('Optional Details'),
//       children: [
//         Text('Additional optional details can be added here.'),
//       ],
//     );
//   }
// }

////////// end test 2 ////
//////this test is good///
// import 'package:flutter/material.dart';

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String? selectedTaskCategory;
//   String? selectedTaskType;
//   double taskDuration = 0.5;
//   double taskWeight = 1500.0;
//   double numberOfOffsets = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task To Reduce C02eq'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildHeader(),
//               SizedBox(height: 20),
//               buildTaskCategorySelector(),
//               SizedBox(height: 20),
//               if (selectedTaskCategory == 'Appliances') buildApplianceTask(),
//               if (selectedTaskCategory == 'Products') buildProductTask(),
//               if (selectedTaskCategory == 'Travel') buildTravelTask(),
//               if (selectedTaskCategory == 'Aid') buildAidTask(),
//               SizedBox(height: 20),
//               buildSaveButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildHeader() {
//     return Text(
//       'My Savings',
//       style: TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: Colors.green[700],
//       ),
//     );
//   }

//   Widget buildTaskCategorySelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Category',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Category'),
//           items: <String>['Appliances', 'Products', 'Travel', 'Aid']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedTaskCategory = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildApplianceTask() {
//     return buildTaskContainer(
//       title: 'Appliances',
//       children: [
//         buildDropdown(
//           title: 'Cooking: Oven',
//           items: ['Did not use oven', 'Used oven'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Duration (hours)',
//           value: taskDuration,
//           min: 0,
//           max: 24,
//           divisions: 48,
//           onChanged: (value) {
//             setState(() {
//               taskDuration = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildProductTask() {
//     return buildTaskContainer(
//       title: 'Products',
//       children: [
//         buildDropdown(
//           title: 'Transport',
//           items: ['Car', 'Bike', 'Public Transport'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Weight (kg)',
//           value: taskWeight,
//           min: 0,
//           max: 5000,
//           divisions: 100,
//           onChanged: (value) {
//             setState(() {
//               taskWeight = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTravelTask() {
//     return buildTaskContainer(
//       title: 'Travel',
//       children: [
//         buildTextField(
//           title: 'Distance Travelled (Km)',
//           keyboardType: TextInputType.number,
//           onChanged: (value) {},
//         ),
//         buildDropdown(
//           title: 'Travelled By',
//           items: ['Electric Bicycle', 'Car (alone)', 'Car (shared)'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildAidTask() {
//     return buildTaskContainer(
//       title: 'Personal Social Responsibility',
//       children: [
//         buildDropdown(
//           title: 'Forestry / Tree Plantation',
//           items: ['Purchased Carbon Offsets', 'Forestry'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Number of Carbon Offsets',
//           value: numberOfOffsets,
//           min: 0,
//           max: 10,
//           divisions: 10,
//           onChanged: (value) {
//             setState(() {
//               numberOfOffsets = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTaskContainer(
//       {required String title, required List<Widget> children}) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 3,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700]),
//           ),
//           SizedBox(height: 10),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget buildDropdown({
//     required String title,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Task Type'),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSlider({
//     required String title,
//     required double value,
//     required double min,
//     required double max,
//     required int divisions,
//     required Function(double) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         Slider(
//           value: value,
//           min: min,
//           max: max,
//           divisions: divisions,
//           label: '$value',
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildTextField({
//     required String title,
//     required TextInputType keyboardType,
//     required Function(String) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         TextField(
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSaveButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           // Save record logic
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green[700],
//           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//           textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         child: Text('Save Record'),
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(home: TaskPage()));
// end task///
// import 'package:flutter/material.dart';
// import 'task_details_page.dart';

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String? selectedTaskCategory;
//   String? selectedTaskType;
//   double taskDuration = 0.5;
//   double taskWeight = 1500.0;
//   double numberOfOffsets = 1.0;
//   String selectedDay = 'Mon';
//   final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task To Reduce CO2eq'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildHeader(),
//               SizedBox(height: 20),
//               buildWeekSelector(),
//               SizedBox(height: 20),
//               buildTaskCategorySelector(),
//               SizedBox(height: 20),
//               if (selectedTaskCategory == 'Appliances') buildApplianceTask(),
//               if (selectedTaskCategory == 'Products') buildProductTask(),
//               if (selectedTaskCategory == 'Travel') buildTravelTask(),
//               if (selectedTaskCategory == 'Aid') buildAidTask(),
//               SizedBox(height: 20),
//               buildSaveButton(),
//               SizedBox(height: 20),
//               buildGlobalChallengeButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildHeader() {
//     return Text(
//       'My Savings',
//       style: TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: Colors.green[700],
//       ),
//     );
//   }

//   Widget buildWeekSelector() {
//     return Container(
//       height: 50,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: daysOfWeek.map((day) {
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedDay = day;
//               });
//             },
//             child: Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: selectedDay == day ? Colors.green[700] : Colors.grey[200],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               child: Text(
//                 day,
//                 style: TextStyle(
//                   color: selectedDay == day ? Colors.white : Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget buildTaskCategorySelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Category',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Category'),
//           items: <String>['Appliances', 'Products', 'Travel', 'Aid']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedTaskCategory = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildApplianceTask() {
//     return buildTaskContainer(
//       title: 'Appliances',
//       children: [
//         buildDropdown(
//           title: 'Cooking: Oven',
//           items: ['Did not use oven', 'Used oven'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Duration (hours)',
//           value: taskDuration,
//           min: 0,
//           max: 24,
//           divisions: 48,
//           onChanged: (value) {
//             setState(() {
//               taskDuration = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildProductTask() {
//     return buildTaskContainer(
//       title: 'Products',
//       children: [
//         buildDropdown(
//           title: 'Transport',
//           items: ['Car', 'Bike', 'Public Transport'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Weight (kg)',
//           value: taskWeight,
//           min: 0,
//           max: 5000,
//           divisions: 100,
//           onChanged: (value) {
//             setState(() {
//               taskWeight = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTravelTask() {
//     return buildTaskContainer(
//       title: 'Travel',
//       children: [
//         buildTextField(
//           title: 'Distance Travelled (Km)',
//           keyboardType: TextInputType.number,
//           onChanged: (value) {},
//         ),
//         buildDropdown(
//           title: 'Travelled By',
//           items: ['Electric Bicycle', 'Car (alone)', 'Car (shared)'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildAidTask() {
//     return buildTaskContainer(
//       title: 'Personal Social Responsibility',
//       children: [
//         buildDropdown(
//           title: 'Forestry / Tree Plantation',
//           items: ['Purchased Carbon Offsets', 'Forestry'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Number of Carbon Offsets',
//           value: numberOfOffsets,
//           min: 0,
//           max: 10,
//           divisions: 10,
//           onChanged: (value) {
//             setState(() {
//               numberOfOffsets = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTaskContainer({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 3,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700]),
//           ),
//           SizedBox(height: 10),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget buildDropdown({
//     required String title,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Task Type'),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSlider({
//     required String title,
//     required double value,
//     required double min,
//     required double max,
//     required int divisions,
//     required Function(double) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         Slider(
//           value: value,
//           min: min,
//           max: max,
//           divisions: divisions,
//           label: '$value',
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildTextField({
//     required String title,
//     required TextInputType keyboardType,
//     required Function(String) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         TextField(
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSaveButton### Updated `task_page.dart` with UI/UX Changes and New Features
// ```dart
// import 'package:flutter/material.dart';
// import 'task_details_page.dart';

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String? selectedTaskCategory;
//   String? selectedTaskType;
//   double taskDuration = 0.5;
//   double taskWeight = 1500.0;
//   double numberOfOffsets = 1.0;
//   String selectedDay = 'Mon';
//   final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task To Reduce CO2eq'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildHeader(),
//               SizedBox(height: 20),
//               buildWeekSelector(),
//               SizedBox(height: 20),
//               buildTaskCategorySelector(),
//               SizedBox(height: 20),
//               if (selectedTaskCategory == 'Appliances') buildApplianceTask(),
//               if (selectedTaskCategory == 'Products') buildProductTask(),
//               if (selectedTaskCategory == 'Travel') buildTravelTask(),
//               if (selectedTaskCategory == 'Aid') buildAidTask(),
//               SizedBox(height: 20),
//               buildSaveButton(),
//               SizedBox(height: 20),
//               buildGlobalChallengeButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildHeader() {
//     return Text(
//       'My Savings',
//       style: TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: Colors.green[700],
//       ),
//     );
//   }

//   Widget buildWeekSelector() {
//     return Container(
//       height: 50,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: daysOfWeek.map((day) {
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedDay = day;
//               });
//             },
//             child: Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: selectedDay == day ? Colors.green[700] : Colors.grey[200],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               child: Text(
//                 day,
//                 style: TextStyle(
//                   color: selectedDay == day ? Colors.white : Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget buildTaskCategorySelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Category',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Category'),
//           items: <String>['Appliances', 'Products', 'Travel', 'Aid']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedTaskCategory = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildApplianceTask() {
//     return buildTaskContainer(
//       title: 'Appliances',
//       children: [
//         buildDropdown(
//           title: 'Cooking: Oven',
//           items: ['Did not use oven', 'Used oven'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Duration (hours)',
//           value: taskDuration,
//           min: 0,
//           max: 24,
//           divisions: 48,
//           onChanged: (value) {
//             setState(() {
//               taskDuration = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildProductTask() {
//     return buildTaskContainer(
//       title: 'Products',
//       children: [
//         buildDropdown(
//           title: 'Transport',
//           items: ['Car', 'Bike', 'Public Transport'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Weight (kg)',
//           value: taskWeight,
//           min: 0,
//           max: 5000,
//           divisions: 100,
//           onChanged: (value) {
//             setState(() {
//               taskWeight = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTravelTask() {
//     return buildTaskContainer(
//       title: 'Travel',
//       children: [
//         buildTextField(
//           title: 'Distance Travelled (Km)',
//           keyboardType: TextInputType.number,
//           onChanged: (value) {},
//         ),
//         buildDropdown(
//           title: 'Travelled By',
//           items: ['Electric Bicycle', 'Car (alone)', 'Car (shared)'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildAidTask() {
//     return buildTaskContainer(
//       title: 'Personal Social Responsibility',
//       children: [
//         buildDropdown(
//           title: 'Forestry / Tree Plantation',
//           items: ['Purchased Carbon Offsets', 'Forestry'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Number of Carbon Offsets',
//           value: numberOfOffsets,
//           min: 0,
//           max: 10,
//           divisions: 10,
//           onChanged: (value) {
//             setState(() {
//               numberOfOffsets = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTaskContainer({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 3,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700]),
//           ),
//           SizedBox(height: 10),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget buildDropdown({
//     required String title,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Task Type'),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSlider({
//     required String title,
//     required double value,
//     required double min,
//     required double max,
//     required int divisions,
//     required Function(double) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         Slider(
//           value: value,
//           min: min,
//           max: max,
//           divisions: divisions,
//           label: '$value',
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildTextField({
//     required String title,
//     required TextInputType keyboardType,
//     required Function(String) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         TextField(
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSaveButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           // Save record logic
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green[700],
// ```dart
//           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//           textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         child: Text('Save Record'),
//       ),
//     );
//   }

//   Widget buildGlobalChallengeButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue[700],
//           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//           textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         child: Text('Global Challenge'),
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(home: TaskPage()));
////////test code
// import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Task To Reduce C02eq'),
//       //   backgroundColor: Colors.green[700],
//       // ),
//       body: Column(
//         children: [
//           buildTabs(),
//           buildWeekdaySelector(),
//           Expanded(child: buildTaskList()),
//         ],
//       ),
//     );
//   }

//   Widget buildTabs() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         buildTabButton('daily Task', Colors.green[700]!),
//         buildTabButton('All Task', Colors.grey),
//         buildTabButton('Global challenge', Colors.grey),
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

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Update state to show tasks for the selected day
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = [
//       '1. Plant a Tree',
//       '2. 1hr Refrigerator (don\'t use)',
//       '3. don\'t waste Food',
//       '4. switch off Ac',
//       '5. travel'
//     ];

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class TaskDetailsPage extends StatefulWidget {
//   @override
//   _TaskDetailsPageState createState() => _TaskDetailsPageState();
// }

// class _TaskDetailsPageState extends State<TaskDetailsPage> {
//   String? selectedTaskCategory;
//   String? selectedTaskType;
//   double taskDuration = 0.5;
//   double taskWeight = 1500.0;
//   double numberOfOffsets = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Details'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildTaskDetailsHeader(),
//               SizedBox(height: 20),
//               buildTaskCategorySelector(),
//               if (selectedTaskCategory == 'Appliances') buildApplianceTask(),
//               if (selectedTaskCategory == 'Products') buildProductTask(),
//               if (selectedTaskCategory == 'Travel') buildTravelTask(),
//               if (selectedTaskCategory == 'Aid') buildAidTask(),
//               SizedBox(height: 20),
//               buildSaveButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTaskDetailsHeader() {
//     return Text(
//       'Task Details',
//       style: TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: Colors.green[700],
//       ),
//     );
//   }

//   Widget buildTaskCategorySelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Category',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Category'),
//           items: <String>['Appliances', 'Products', 'Travel', 'Aid']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedTaskCategory = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildApplianceTask() {
//     return buildTaskContainer(
//       title: 'Appliances',
//       children: [
//         buildDropdown(
//           title: 'Cooking: Oven',
//           items: ['Did not use oven', 'Used oven'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Duration (hours)',
//           value: taskDuration,
//           min: 0,
//           max: 24,
//           divisions: 48,
//           onChanged: (value) {
//             setState(() {
//               taskDuration = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildProductTask() {
//     return buildTaskContainer(
//       title: 'Products',
//       children: [
//         buildDropdown(
//           title: 'Transport',
//           items: ['Car', 'Bike', 'Public Transport'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Weight (kg)',
//           value: taskWeight,
//           min: 0,
//           max: 5000,
//           divisions: 100,
//           onChanged: (value) {
//             setState(() {
//               taskWeight = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTravelTask() {
//     return buildTaskContainer(
//       title: 'Travel',
//       children: [
//         buildTextField(
//           title: 'Distance Travelled (Km)',
//           keyboardType: TextInputType.number,
//           onChanged: (value) {},
//         ),
//         buildDropdown(
//           title: 'Travelled By',
//           items: ['Electric Bicycle', 'Car (alone)', 'Car (shared)'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildAidTask() {
//     return buildTaskContainer(
//       title: 'Personal Social Responsibility',
//       children: [
//         buildDropdown(
//           title: 'Forestry / Tree Plantation',
//           items: ['Purchased Carbon Offsets', 'Forestry'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Number of Carbon Offsets',
//           value: numberOfOffsets,
//           min: 0,
//           max: 10,
//           divisions: 10,
//           onChanged: (value) {
//             setState(() {
//               numberOfOffsets = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTaskContainer({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 3,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700]),
//           ),
//           SizedBox(height: 10),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget buildDropdown({
//     required String title,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Task Type'),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSlider({
//     required String title,
//     required double value,
//     required double min,
//     required double max,
//     required int divisions,
//     required Function(double) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         Slider(
//           value: value,
//           min: min,
//           max: max,
//           divisions: divisions,
//           label: value.toString(),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildTextField({
//     required String title,
//     required TextInputType keyboardType,
//     required Function(String) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         TextField(
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSaveButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           // Save task details
//         },
//         child: Text('Save Record'),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green[700],
//           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//           textStyle: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
///end test Corrected
// import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Task To Reduce C02eq'),
//       //   backgroundColor: Colors.green[700],
//       // ),
//       body: Column(
//         children: [
//           buildTabs(),
//           buildWeekdaySelector(),
//           Expanded(child: buildTaskList()),
//         ],
//       ),
//     );
//   }

//   Widget buildTabs() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         buildTabButton('daily Task', Colors.green[700]!),
//         buildTabButton('All Task', Colors.grey),
//         buildTabButton('Global challenge', Colors.grey),
//       ],
//     );
//   }

//   Widget buildTabButton(String title, Color color) {
//     return TextButton(
//       onPressed: () {
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//         // Handle other buttons if needed
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Update state to show tasks for the selected day
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = [
//       '1. Plant a Tree',
//       '2. 1hr Refrigerator (don\'t use)',
//       '3. don\'t waste Food',
//       '4. switch off Ac',
//       '5. travel'
//     ];

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class TaskDetailsPage extends StatefulWidget {
//   @override
//   _TaskDetailsPageState createState() => _TaskDetailsPageState();
// }

// class _TaskDetailsPageState extends State<TaskDetailsPage> {
//   String? selectedTaskCategory;
//   String? selectedTaskType;
//   double taskDuration = 0.5;
//   double taskWeight = 1500.0;
//   double numberOfOffsets = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Details'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildTaskDetailsHeader(),
//               SizedBox(height: 20),
//               buildTaskCategorySelector(),
//               if (selectedTaskCategory == 'Appliances') buildApplianceTask(),
//               if (selectedTaskCategory == 'Products') buildProductTask(),
//               if (selectedTaskCategory == 'Travel') buildTravelTask(),
//               if (selectedTaskCategory == 'Aid') buildAidTask(),
//               SizedBox(height: 20),
//               buildSaveButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTaskDetailsHeader() {
//     return Text(
//       'Task Details',
//       style: TextStyle(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: Colors.green[700],
//       ),
//     );
//   }

//   Widget buildTaskCategorySelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Category',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Category'),
//           items: <String>['Appliances', 'Products', 'Travel', 'Aid']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedTaskCategory = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildApplianceTask() {
//     return buildTaskContainer(
//       title: 'Appliances',
//       children: [
//         buildDropdown(
//           title: 'Cooking: Oven',
//           items: ['Did not use oven', 'Used oven'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Duration (hours)',
//           value: taskDuration,
//           min: 0,
//           max: 24,
//           divisions: 48,
//           onChanged: (value) {
//             setState(() {
//               taskDuration = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildProductTask() {
//     return buildTaskContainer(
//       title: 'Products',
//       children: [
//         buildDropdown(
//           title: 'Transport',
//           items: ['Car', 'Bike', 'Public Transport'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Weight (kg)',
//           value: taskWeight,
//           min: 0,
//           max: 5000,
//           divisions: 100,
//           onChanged: (value) {
//             setState(() {
//               taskWeight = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTravelTask() {
//     return buildTaskContainer(
//       title: 'Travel',
//       children: [
//         buildTextField(
//           title: 'Distance Travelled (Km)',
//           keyboardType: TextInputType.number,
//           onChanged: (value) {},
//         ),
//         buildDropdown(
//           title: 'Travelled By',
//           items: ['Electric Bicycle', 'Car (alone)', 'Car (shared)'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildAidTask() {
//     return buildTaskContainer(
//       title: 'Personal Social Responsibility',
//       children: [
//         buildDropdown(
//           title: 'Forestry / Tree Plantation',
//           items: ['Purchased Carbon Offsets', 'Forestry'],
//           onChanged: (value) {
//             setState(() {
//               selectedTaskType = value;
//             });
//           },
//         ),
//         buildSlider(
//           title: 'Number of Carbon Offsets',
//           value: numberOfOffsets,
//           min: 0,
//           max: 10,
//           divisions: 10,
//           onChanged: (value) {
//             setState(() {
//               numberOfOffsets = value;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildTaskContainer({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 3,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700]),
//           ),
//           SizedBox(height: 10),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget buildDropdown({
//     required String title,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           hint: Text('Select Task Type'),
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSlider({
//     required String title,
//     required double value,
//     required double min,
//     required double max,
//     required int divisions,
//     required Function(double) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         Slider(
//           value: value,
//           min: min,
//           max: max,
//           divisions: divisions,
//           label: value.toString(),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildTextField({
//     required String title,
//     required TextInputType keyboardType,
//     required Function(String) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         TextField(
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//           onChanged: onChanged,
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget buildSaveButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           // Save task details
//         },
//         child: Text('Save Record'),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green[700],
//           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//           textStyle: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
///////////
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           buildWeekdaySelector(),
//           Expanded(child: buildTaskList()),
//         ],
//       ),
//     );
//   }

//   Widget buildTabs() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         buildTabButton('daily Task', Colors.green[700]!),
//         buildTabButton('All Task', Colors.grey),
//         buildTabButton('Global challenge', Colors.grey),
//       ],
//     );
//   }

//   Widget buildTabButton(String title, Color color) {
//     return TextButton(
//       onPressed: () {
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => TaskVerificationPage(taskName: '')),
//           );
//         }
//         // Handle other buttons if needed
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Update state to show tasks for the selected day
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = [
//       '1. Plant a Tree',
//       '2. 1hr Refrigerator (don\'t use)',
//       '3. don\'t waste Food',
//       '4. switch off Ac',
//       '5. travel'
//     ];

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TaskVerificationPage(
//                     taskName: tasks[index],
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

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   XFile? _image;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _image = pickedImage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Verification'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.taskName,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green[700],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'You have reduced 11 kg of CO2eq',
//                 style: TextStyle(fontSize: 18, color: Colors.black),
//               ),
//               SizedBox(height: 20),
//               _image == null
//                   ? Text('No image selected.')
//                   : Image.file(File(_image!.path)),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Capture Photo'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green[700],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Save record logic
//                   },
//                   child: Text('Save Record'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green[700],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//////////////////
// import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';

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
//           buildWeekdaySelector(),
//           Expanded(child: buildTaskList(selectedWeekday)),
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
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskVerificationPage()),
//           );
//         }
//         // Handle other buttons if needed
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList(String weekday) {
//     // Here you can filter tasks based on the selected weekday and user's calendar/time zone
//     List<String> tasks = getTasksForDay(weekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     // Example tasks for each day of the week
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3.  Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk🚶‍♀️ or bike🚴‍♂️ instead of driving🚗 for short distances',
//         '2. Use public transportation🚌 if available.',
//         '3. Carpool with a coworker or friend🚗',
//         '4. Combine errands to reduce trips.',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal🍴',
//         '3. Repair🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes🚰',
//         '2. Collect rainwater for watering plants💧',
//         '3. Take shorter showers🚿',
//         '4.Turn off the water while brushing your teeth🚰',
//         '5. Use a broom🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media🌍.',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group🤝',
//         '5. Plant🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your weeks actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine🤝',
//         '3. Share your experiences with friends and family👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint🐾',
//         '5.  Celebrate your achievements and inspire others🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[weekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String? taskName;

//   TaskVerificationPage({this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
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
//               widget.taskName ?? 'Task Details',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             Text('You have reduced 11 kg of CO2eq'),
//             SizedBox(height: 20),
//             // Add camera access and save record functionality here
//             // buildCameraAccess(),
//             // buildSaveButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   // Example functions for camera access and save button
//   // Widget buildCameraAccess() { ... }
//   // Widget buildSaveButton() { ... }
// }
/////////////////////good//
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Task To Reduce CO2eq'),
//       //   backgroundColor: Colors.green[700],
//       // ),
//       body: Column(
//         children: [
//           buildTabs(),
//           buildWeekdaySelector(),
//           Expanded(child: buildTaskList(selectedWeekday)),
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
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//         // Handle other buttons if needed
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList(String weekday) {
//     List<String> tasks = getTasksForDay(weekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[weekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String? taskName;

//   TaskVerificationPage({this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
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
//               widget.taskName ?? 'Task Details',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             Text('You have reduced 11 kg of CO2eq'),
//             SizedBox(height: 20),
//             // Add camera access and save record functionality here
//             // buildCameraAccess(),
//             // buildSaveButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   // Example functions for camera access and save button
//   // Widget buildCameraAccess() { ... }
//   // Widget buildSaveButton() { ... }
// }
////////////////// correct code (9/8/24-10:09)
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           buildWeekdaySelector(),
//           Expanded(child: buildTaskList(selectedWeekday)),
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
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//         // Handle other buttons if needed
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList(String weekday) {
//     List<String> tasks = getTasksForDay(weekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[weekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = ''; // Store user feedback

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   void _saveRecord() {
//     if (_image != null && feedback.isNotEmpty) {
//       // Implement the logic to save the record
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Record Saved!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please provide an image and feedback.')),
//       );
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
//               'You are reducing 11 kg of CO2eq',
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
//             ElevatedButton(
//               onPressed: _pickImageFromGallery,
//               child: Text('Choose from Gallery'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildFeedbackField(),
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
///////////////////
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
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
//         setState(() {
//           selectedTab = title;
//           // Reset weekday selection if switching to 'All Task' or another tab
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//         });
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = ''; // Store user feedback

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   void _saveRecord() {
//     if (_image != null && feedback.isNotEmpty) {
//       // Implement the logic to save the record
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Record Saved!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please provide an image and feedback.')),
//       );
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
//               'You are reducing 11 kg of CO2eq',
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
//             ElevatedButton(
//               onPressed: _pickImageFromGallery,
//               child: Text('Choose from Gallery'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildFeedbackField(),
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
////////////////correct code
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
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
//         setState(() {
//           selectedTab = title;
//           // Reset weekday selection if switching to 'All Task'
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = ''; // Store user feedback

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   void _saveRecord() {
//     if (_image != null && feedback.isNotEmpty) {
//       // Implement the logic to save the record
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Record Saved!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please provide an image and feedback.')),
//       );
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
//               'You are reducing 11 kg of CO2eq',
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
//             ElevatedButton(
//               onPressed: _pickImageFromGallery,
//               child: Text('Choose from Gallery'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildFeedbackField(),
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
//////////////////////////////updated code 👇
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showBanner = false; // Track if banner should be shown

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showBanner) buildBannerSection(), // Conditionally show banner
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
//         setState(() {
//           selectedTab = title;
//           // Reset weekday selection if switching to 'All Task'
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           // Show or hide banner based on tab selected
//           if (title == 'Global Challenge') {
//             showBanner = !showBanner;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return GestureDetector(
//       onTap: () {
//         // Handle banner tap here
//         print('Banner tapped');
//       },
//       child: Container(
//         width: double.infinity,
//         height: 50, // Height of the banner
//         child: Image.network(
//           'https://via.placeholder.com/320x50', // Replace with your image URL
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = ''; // Store user feedback

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   void _saveRecord() {
//     if (_image != null && feedback.isNotEmpty) {
//       // Implement the logic to save the record
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Record Saved!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please provide an image and feedback.')),
//       );
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
//               'You are reducing 11 kg of CO2eq',
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
//             ElevatedButton(
//               onPressed: _pickImageFromGallery,
//               child: Text('Choose from Gallery'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildFeedbackField(),
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
///////////////////////////
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showBanner = false; // Track if banner should be shown

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showBanner) buildBannerSection(), // Conditionally show banner
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
//         setState(() {
//           selectedTab = title;
//           // Reset weekday selection if switching to 'All Task'
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           // Show or hide banner based on tab selected
//           if (title == 'Global Challenge') {
//             showBanner = !showBanner;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildBannerSection() {
//     return GestureDetector(
//       onTap: () {
//         // Handle banner tap here
//         print('Banner tapped');
//       },
//       child: Container(
//         width: double.infinity,
//         height: 50, // Height of the banner
//         child: Image.network(
//           'https://via.placeholder.com/320x50', // Replace with your image URL
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = ''; // Store user feedback

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   void _saveRecord() {
//     if (_image != null && feedback.isNotEmpty) {
//       // Implement the logic to save the record
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Record Saved!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please provide an image and feedback.')),
//       );
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
//               'You are reducing 11 kg of CO2eq',
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
//             ElevatedButton(
//               onPressed: _pickImageFromGallery,
//               child: Text('Choose from Gallery'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildFeedbackField(),
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
// import 'package:flutter/material.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           Expanded(
//               child: selectedTab == 'Global Challenge'
//                   ? buildGlobalChallengePage()
//                   : buildTaskList()),
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
//         setState(() {
//           selectedTab = title;
//           // Reset weekday selection if switching to 'All Task'
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget buildGlobalChallengePage() {
//     // Replace with your image URLs
//     List<String> imageUrls = [
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+1',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU',
//     ];

//     return ListView.builder(
//       itemCount: imageUrls.length,
//       itemBuilder: (context, index) {
//         return Center(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => TaskVerificationPage(
//                     taskName: 'Task for Image ${index + 1}',
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               margin: EdgeInsets.symmetric(vertical: 10),
//               width: 320,
//               height: 50,
//               child: Image.network(imageUrls[index], fit: BoxFit.cover),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[weekday] ??
//         []; // Ensure a non-null list is always returned
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = ''; // Store user feedback

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   void _saveRecord() {
//     if (_image != null && feedback.isNotEmpty) {
//       // Implement the logic to save the record
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Record Saved!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please provide an image and feedback.')),
//       );
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
//               'You are reducing 11 kg of CO2eq',
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
//             ElevatedButton(
//               onPressed: _pickImageFromGallery,
//               child: Text('Choose from Gallery'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildFeedbackField(),
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
/////////////////////// updated code
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() => runApp(MaterialApp(home: TaskPage()));

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showGlobalChallengePage =
//       false; // Track if Global Challenge page should be shown

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showGlobalChallengePage)
//             buildGlobalChallengePage(), // Conditionally show Global Challenge page
//           if (!showGlobalChallengePage)
//             Expanded(
//                 child:
//                     buildTaskList()), // Show task list only if not showing Global Challenge
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
//         setState(() {
//           selectedTab = title;
//           // Reset weekday selection if switching to 'All Task'
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           // Show or hide Global Challenge page based on tab selected
//           if (title == 'Global Challenge') {
//             showGlobalChallengePage = !showGlobalChallengePage;
//           } else {
//             showGlobalChallengePage = false;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

// ///////////////////////
//   Widget buildGlobalChallengePage() {
//     List<String> imageUrls = [
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+1',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+2',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+3',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+4',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+5'
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0), // Add space from the top
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (var url in imageUrls) // Display 5 clickable images
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   vertical: 8.0), // Space between each image
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskVerificationPage(
//                           taskName: 'Global Challenge Task'),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 80, // Increased height of the image
//                   child: Image.network(
//                     url,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

// ////////////////////////
//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = ''; // Store user feedback

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   void _saveRecord() {
//     if (_image != null && feedback.isNotEmpty) {
//       // Implement the logic to save the record
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Record saved successfully!'),
//         ),
//       );
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please capture a photo and provide feedback.'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Verification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Task: ${widget.taskName}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: GestureDetector(
//                 onTap: _takePhoto,
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   color: Colors.grey[200],
//                   child: _image == null
//                       ? Icon(Icons.camera_alt, size: 50)
//                       : Image.file(_image!),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   feedback = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Feedback',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 4,
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _saveRecord,
//                 child: Text('Save Record'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ///////////////////////////////////////////////
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: TaskPage()));
// }

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showGlobalChallengePage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showGlobalChallengePage) buildGlobalChallengePage(),
//           if (!showGlobalChallengePage) Expanded(child: buildTaskList()),
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
//         setState(() {
//           selectedTab = title;
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           if (title == 'Global Challenge') {
//             showGlobalChallengePage = !showGlobalChallengePage;
//           } else {
//             showGlobalChallengePage = false;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildGlobalChallengePage() {
//     List<String> imageUrls = [
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+1',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+2',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+3',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+4',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+5'
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (var url in imageUrls)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskVerificationPage(
//                           taskName: 'Global Challenge Task'),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 80,
//                   child: Image.network(url, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String feedback = '';

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<String?> _uploadImage() async {
//     if (_image == null) return null;

//     try {
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('task_images/${DateTime.now().millisecondsSinceEpoch}');
//       final uploadTask = storageRef.putFile(_image!);
//       final snapshot = await uploadTask.whenComplete(() {});
//       final imageUrl = await snapshot.ref.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return null;
//     }
//   }

//   void _saveRecord() async {
//     if (_image != null && feedback.isNotEmpty) {
//       final imageUrl = await _uploadImage();
//       if (imageUrl != null) {
//         // Implement the logic to save the record including the image URL and feedback
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Record saved successfully!'),
//           ),
//         );
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to upload image.'),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please capture a photo and provide feedback.'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Verification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Task: ${widget.taskName}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: GestureDetector(
//                 onTap: _takePhoto,
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   color: Colors.grey[200],
//                   child: _image == null
//                       ? Icon(Icons.camera_alt, size: 50)
//                       : Image.network(_image! as String),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   feedback = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Feedback',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 4,
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _saveRecord,
//                 child: Text('Save Record'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ////////////////////
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: TaskPage()));
// }

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showGlobalChallengePage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showGlobalChallengePage) buildGlobalChallengePage(),
//           if (!showGlobalChallengePage) Expanded(child: buildTaskList()),
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
//         setState(() {
//           selectedTab = title;
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           if (title == 'Global Challenge') {
//             showGlobalChallengePage = !showGlobalChallengePage;
//           } else {
//             showGlobalChallengePage = false;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildGlobalChallengePage() {
//     List<String> imageUrls = [
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+1',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+2',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+3',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+4',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+5'
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (var url in imageUrls)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskVerificationPage(
//                           taskName: 'Global Challenge Task'),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 80,
//                   child: Image.network(url, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   String? _imageUrl;
//   final ImagePicker _picker = ImagePicker();
//   final FirebaseStorage _storage = FirebaseStorage.instanceFor(
//     bucket: 'gs://careclimate-95ea3.appspot.com',
//   );
//   String feedback = '';

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<String?> _uploadImage() async {
//     if (_image == null) return null;

//     try {
//       final storageRef = _storage
//           .ref()
//           .child('task_images/${DateTime.now().millisecondsSinceEpoch}');
//       final uploadTask = storageRef.putFile(_image!);
//       final snapshot = await uploadTask.whenComplete(() {});
//       final imageUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         _imageUrl = imageUrl; // Store the image URL
//       });
//       return imageUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return null;
//     }
//   }

//   void _saveRecord() async {
//     if (_imageUrl != null && feedback.isNotEmpty) {
//       // Implement the logic to save the record including the image URL and feedback
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Record saved successfully!'),
//         ),
//       );
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please capture a photo and provide feedback.'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Verification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Task: ${widget.taskName}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: GestureDetector(
//                 onTap: _takePhoto,
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   color: Colors.grey[200],
//                   child: _imageUrl != null
//                       ? Image.network(_imageUrl!) // Display the uploaded image from URL
//                       : Icon(Icons.camera_alt, size: 50),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   feedback = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Feedback',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 4,
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await _uploadImage();
//                   _saveRecord();
//                 },
//                 child: Text('Save Record'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//////////
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: TaskPage()));
// }

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showGlobalChallengePage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showGlobalChallengePage) buildGlobalChallengePage(),
//           if (!showGlobalChallengePage) Expanded(child: buildTaskList()),
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
//         setState(() {
//           selectedTab = title;
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           if (title == 'Global Challenge') {
//             showGlobalChallengePage = !showGlobalChallengePage;
//           } else {
//             showGlobalChallengePage = false;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildGlobalChallengePage() {
//     List<String> imageUrls = [
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+1',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+2',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+3',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+4',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+5'
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (var url in imageUrls)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskVerificationPage(
//                           taskName: 'Global Challenge Task'),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 80,
//                   child: Image.network(url, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   String? _imageUrl;
//   final ImagePicker _picker = ImagePicker();
//   final FirebaseStorage _storage = FirebaseStorage.instanceFor(
//     bucket: 'gs://careclimate-95ea3.appspot.com',
//   );
//   String feedback = '';

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<String?> _uploadImage() async {
//     if (_image == null) return null;

//     try {
//       final storageRef = _storage
//           .ref()
//           .child('task_images/${DateTime.now().millisecondsSinceEpoch}');
//       final uploadTask = storageRef.putFile(_image!);
//       final snapshot = await uploadTask.whenComplete(() {});
//       final imageUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         _imageUrl = imageUrl; // Store the image URL
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
//               Image.network(
//                 _image! as String,
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
//                   // Use imageUrl for further actions like sending to backend, etc.
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Task verified and image uploaded!')),
//                   );
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Submit Verification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: TaskPage()));
// }

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showGlobalChallengePage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showGlobalChallengePage) buildGlobalChallengePage(),
//           if (!showGlobalChallengePage) Expanded(child: buildTaskList()),
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
//         setState(() {
//           selectedTab = title;
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           if (title == 'Global Challenge') {
//             showGlobalChallengePage = !showGlobalChallengePage;
//           } else {
//             showGlobalChallengePage = false;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildGlobalChallengePage() {
//     List<String> imageUrls = [
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU'
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (var url in imageUrls)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskVerificationPage(
//                           taskName: 'Global Challenge Task'),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 80,
//                   child: Image.network(url, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   String? _imageUrl;
//   final ImagePicker _picker = ImagePicker();
//   late FirebaseStorage _storage;
//   late FirebaseDatabase _database;
//   String feedback = '';

//   @override
//   void initState() {
//     super.initState();
//     _storage = FirebaseStorage.instance;
//     _database = FirebaseDatabase.instance;
//   }

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<String?> _uploadImage() async {
//     if (_image == null) return null;

//     try {
//       String fileName =
//           'community_images/${DateTime.now().millisecondsSinceEpoch}.png';
//       final Reference ref = _storage.ref().child(fileName);
//       final UploadTask uploadTask = ref.putFile(_image!);
//       final TaskSnapshot snapshot = await uploadTask;
//       final String downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return null;
//     }
//   }

//   Future<void> _saveTaskToDatabase(String imageUrl) async {
//     final String userId = 'user_unique_id'; // Replace with actual user ID logic
//     final String taskId = DateTime.now().millisecondsSinceEpoch.toString();
//     final DatabaseReference ref = _database.ref('tasks/$userId/$taskId');

//     await ref.set({
//       'taskName': widget.taskName,
//       'feedback': feedback,
//       'imageUrl': imageUrl,
//     });
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
//               Image.asset(
//                 'assets/placeholder_image.png', // Replace with the actual asset path
//                 height: 200,
//                 fit: BoxFit.cover,
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
//                   await _saveTaskToDatabase(imageUrl);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Task verified and image uploaded!')),
//                   );
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Submit Verification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////////////////
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: TaskPage()));
// }

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showGlobalChallengePage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showGlobalChallengePage) buildGlobalChallengePage(),
//           if (!showGlobalChallengePage) Expanded(child: buildTaskList()),
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
//         setState(() {
//           selectedTab = title;
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           if (title == 'Global Challenge') {
//             showGlobalChallengePage = !showGlobalChallengePage;
//           } else {
//             showGlobalChallengePage = false;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildGlobalChallengePage() {
//     List<String> imageUrls = [
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+1',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+2',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+3',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+4',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+5'
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (var url in imageUrls)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskVerificationPage(
//                           taskName: 'Global Challenge Task'),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 80,
//                   child: Image.network(url, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   File? _image;
//   String? _imageUrl;
//   final ImagePicker _picker = ImagePicker();
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseDatabase _databrase = FirebaseDatabase.instance;
//   String feedback = '';

//   Future<void> _takePhoto() async {
//     final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       setState(() {
//         _image = File(photo.path);
//       });
//     }
//   }

//   Future<String?> _uploadImage() async {
//     if (_image == null) return null;

//     try {
//       String fileName =
//           'community_images/${DateTime.now().millisecondsSinceEpoch}.png';
//       final Reference ref = _storage.ref().child(fileName);
//       final UploadTask uploadTask = ref.putFile(_image!);
//       final TaskSnapshot snapshot = await uploadTask;
//       final String downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
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
//               Image.asset(
//                 'assets/placeholder.png', // Placeholder image
//                 height: 200,
//                 fit: BoxFit.cover,
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
//                   // Use imageUrl for further actions like sending to backend, etc.
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Task verified and image uploaded!')),
//                   );
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Submit Verification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//////////////////////// here is the updated code 1 👇
// import 'dart:typed_data'; // For Uint8List
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: TaskPage()));
// }

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showGlobalChallengePage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showGlobalChallengePage) buildGlobalChallengePage(),
//           if (!showGlobalChallengePage) Expanded(child: buildTaskList()),
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
//         setState(() {
//           selectedTab = title;
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           if (title == 'Global Challenge') {
//             showGlobalChallengePage = !showGlobalChallengePage;
//           } else {
//             showGlobalChallengePage = false;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildGlobalChallengePage() {
//     List<String> imageUrls = [
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+1',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+2',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+3',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+4',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM75vbrLOmiPqZisvTe50bisuko2ybDHjIVA&usqp=CAU?text=Image+5'
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (var url in imageUrls)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskVerificationPage(
//                           taskName: 'Global Challenge Task'),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 80,
//                   child: Image.network(url, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   Uint8List? _imageBytes;
//   String? _uploadedImageUrl;
//   final ImagePicker _picker = ImagePicker();
//   final FirebaseStorage _storage = FirebaseStorage.instanceFor(
//     app: Firebase.app(),
//     bucket: 'careclimate-95ea3.appspot.com',
//   );
//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   String feedback = '';

//   Future<void> _pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       setState(() {
//         _imageBytes = bytes;
//       });
//     }
//   }

//   Future<void> _uploadImage() async {
//     if (_imageBytes == null) {
//       print('No image selected.');
//       return;
//     }

//     try {
//       final String fileName =
//           '${DateTime.now().millisecondsSinceEpoch}_${widget.taskName}';
//       final Reference ref = _storage.ref().child(fileName);
//       final UploadTask uploadTask = ref.putData(_imageBytes!);
//       final TaskSnapshot snapshot = await uploadTask;
//       final String downloadUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         _uploadedImageUrl = downloadUrl;
//       });
//       _saveDataToDatabase(downloadUrl);
//     } catch (e) {
//       print('Image upload failed: $e');
//     }
//   }

//   void _saveDataToDatabase(String imageUrl) {
//     String userId = 'user_id_example'; // Replace with your user ID logic
//     DatabaseReference ref = _database.ref('task_verifications/$userId');

//     ref.set({
//       'task_name': widget.taskName,
//       'feedback': feedback,
//       'image_url': imageUrl,
//     });
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
//             if (_uploadedImageUrl != null)
//               Image.network(
//                 _uploadedImageUrl!,
//                 height: 200,
//                 fit: BoxFit.cover,
//               )
//             else
//               Container(
//                 height: 200,
//                 color: Colors.grey[300],
//                 child: Icon(Icons.camera_alt, size: 100),
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await _pickImage(); // Ensure image is picked
//                 if (_imageBytes != null) {
//                   await _uploadImage(); // Upload the image
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please capture a photo first.')),
//                   );
//                 }
//               },
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
//                 if (_uploadedImageUrl != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Task verified and image uploaded!')),
//                   );
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please capture a photo first.')),
//                   );
//                 }
//               },
//               child: Text('Submit Verification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
/////////////////////here is the updated code 👇
// import 'dart:typed_data'; // For Uint8List
// import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: TaskPage()));
// }

// class TaskPage extends StatefulWidget {
//   @override
//   _TaskPageState createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedWeekday = 'Mon';
//   String selectedTab = 'Daily Task';
//   bool showGlobalChallengePage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           buildTabs(),
//           if (selectedTab == 'Daily Task') buildWeekdaySelector(),
//           if (showGlobalChallengePage) buildGlobalChallengePage(),
//           if (!showGlobalChallengePage) Expanded(child: buildTaskList()),
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
//         setState(() {
//           selectedTab = title;
//           if (title != 'Daily Task') {
//             selectedWeekday = 'Mon';
//           }
//           if (title == 'Global Challenge') {
//             showGlobalChallengePage = !showGlobalChallengePage;
//           } else {
//             showGlobalChallengePage = false;
//           }
//         });
//         if (title == 'All Task') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskDetailsPage()),
//           );
//         }
//       },
//       child: Text(
//         title,
//         style: TextStyle(color: color, fontSize: 18),
//       ),
//     );
//   }

//   Widget buildWeekdaySelector() {
//     List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: weekdays.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekday = weekdays[index];
//                 });
//               },
//               child: Text(weekdays[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildGlobalChallengePage() {
//     List<String> imageUrls = [
//       'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/climate%20change%20challengea.jpeg',
//       'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/daily%20challenge.jpeg',
//       'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/google%20climate%20care%20challenge.jpeg',
//     ];

//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           for (var url in imageUrls)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskVerificationPage(
//                           taskName: 'Global Challenge Task'),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 150,
//                   child: Image.network(url, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildTaskList() {
//     List<String> tasks = getTasksForDay(selectedWeekday);

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         TaskVerificationPage(taskName: tasks[index])),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   List<String> getTasksForDay(String weekday) {
//     Map<String, List<String>> weeklyTasks = {
//       'Mon': [
//         '1. Unplug all electronics not in use 🔌',
//         '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
//         '3. Swap out one incandescent lightbulb 💡 for an LED',
//         '4. Take a shorter shower 🚿',
//         '5. Air dry dishes instead of using the dishwasher'
//       ],
//       'Tue': [
//         '1. Bring reusable bags to the grocery store 🛍️',
//         '2. Start a compost bin 🗑️ for food scraps',
//         '3. Recycle ♻️ paper, plastic, and glass',
//         '4. Avoid single-use plastics',
//         '5. Pack a reusable lunch'
//       ],
//       'Wed': [
//         '1. Walk 🚶‍♀️ or bike 🚴‍♂️ instead of driving 🚗 for short distances',
//         '2. Use public transportation 🚌 if available',
//         '3. Carpool with a coworker or friend 🚗',
//         '4. Combine errands to reduce trips',
//         '5. Check tire pressure to improve fuel efficiency'
//       ],
//       'Thu': [
//         '1. Buy local and seasonal produce 🛒',
//         '2. Reduce meat consumption by trying a vegetarian meal 🍴',
//         '3. Repair 🛠️ instead of replace items when possible',
//         '4. Choose products with minimal packaging',
//         '5. Donate unwanted items to charity 🤝'
//       ],
//       'Fri': [
//         '1. Fix any leaky faucets or pipes 🚰',
//         '2. Collect rainwater for watering plants 💧',
//         '3. Take shorter showers 🚿',
//         '4. Turn off the water while brushing your teeth 🚰',
//         '5. Use a broom 🧹 instead of a hose to clean outdoor areas'
//       ],
//       'Sat': [
//         '1. Share climate change information on social media 🌍',
//         '2. Contact your elected officials about climate policies',
//         '3. Support businesses with sustainable practices',
//         '4. Join a local environmental group 🤝',
//         '5. Plant 🌱 a tree or participate in a community clean-up'
//       ],
//       'Sun': [
//         '1. Review 👀 your week\'s actions and identify areas for improvement',
//         '2. Choose one new climate-friendly habit to incorporate into your routine 🤝',
//         '3. Share your experiences with friends and family 👨‍👩‍👧‍👦',
//         '4. Explore additional ways to reduce your carbon footprint 🐾',
//         '5. Celebrate your achievements and inspire others 🎉🥳🎊'
//       ],
//     };

//     return weeklyTasks[selectedWeekday] ?? [];
//   }
// }

// class TaskVerificationPage extends StatefulWidget {
//   final String taskName;

//   TaskVerificationPage({required this.taskName});

//   @override
//   _TaskVerificationPageState createState() => _TaskVerificationPageState();
// }

// class _TaskVerificationPageState extends State<TaskVerificationPage> {
//   Uint8List? _imageBytes;
//   String? _uploadedImageUrl;
//   final ImagePicker _picker = ImagePicker();
//   final FirebaseStorage _storage = FirebaseStorage.instanceFor(
//     app: Firebase.app(),
//     bucket: 'careclimate-95ea3.appspot.com',
//   );
//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   String feedback = '';

//   Future<void> _pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       setState(() {
//         _imageBytes = bytes;
//       });
//     }
//   }

//   Future<void> _uploadImage() async {
//     if (_imageBytes == null) {
//       print('No image selected.');
//       return;
//     }

//     try {
//       final String fileName =
//           '${DateTime.now().millisecondsSinceEpoch}_${widget.taskName}';
//       final Reference ref = _storage.ref().child('task_images').child(fileName);
//       final UploadTask uploadTask = ref.putData(_imageBytes!);
//       final TaskSnapshot snapshot = await uploadTask;
//       final String downloadUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         _uploadedImageUrl = downloadUrl;
//       });
//       _saveDataToDatabase(downloadUrl);
//     } catch (e) {
//       print('Image upload failed: $e');
//     }
//   }

//   void _saveDataToDatabase(String imageUrl) {
//     String userId = 'user_id_example'; // Replace with your user ID logic
//     DatabaseReference ref = _database.ref('task_verifications/$userId');

//     ref.set({
//       'task_name': widget.taskName,
//       'feedback': feedback,
//       'image_url': imageUrl,
//     });
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
//             if (_uploadedImageUrl != null)
//               Image.network(
//                 _uploadedImageUrl!,
//                 height: 200,
//                 fit: BoxFit.cover,
//               )
//             else
//               Container(
//                 height: 200,
//                 color: Colors.grey[300],
//                 child: Icon(Icons.camera_alt, size: 100),
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await _pickImage(); // Ensure image is picked
//                 if (_imageBytes != null) {
//                   await _uploadImage(); // Upload the image
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please capture a photo first.')),
//                   );
//                 }
//               },
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
//                 if (_uploadedImageUrl != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Task verified and image uploaded!')),
//                   );
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please capture a photo first.')),
//                   );
//                 }
//               },
//               child: Text('Submit Verification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /////////////////////here is the updated code 👆
import 'dart:typed_data'; // For Uint8List
import 'package:careclimate/features/user_auth/presentation/pages/task_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
// Import the necessary packages for making HTTP requests
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: TaskPage()));
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String selectedWeekday = 'Mon';
  String selectedTab = 'Daily Task';
  bool showGlobalChallengePage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTabs(),
          if (selectedTab == 'Daily Task') buildWeekdaySelector(),
          if (showGlobalChallengePage) buildGlobalChallengePage(),
          if (!showGlobalChallengePage) Expanded(child: buildTaskList()),
        ],
      ),
    );
  }

  Widget buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildTabButton('Daily Task', Colors.green[700]!),
        buildTabButton('All Task', Colors.grey),
        buildTabButton('Global Challenge', Colors.grey),
      ],
    );
  }

  Widget buildTabButton(String title, Color color) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedTab = title;
          if (title != 'Daily Task') {
            selectedWeekday = 'Mon';
          }
          if (title == 'Global Challenge') {
            showGlobalChallengePage = !showGlobalChallengePage;
          } else {
            showGlobalChallengePage = false;
          }
        });
        if (title == 'All Task') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailsPage()),
          );
        }
      },
      child: Text(
        title,
        style: TextStyle(color: color, fontSize: 18),
      ),
    );
  }

  Widget buildWeekdaySelector() {
    List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedWeekday = weekdays[index];
                });
              },
              child: Text(weekdays[index]),
            ),
          );
        },
      ),
    );
  }

  Widget buildGlobalChallengePage() {
    List<String> imageUrls = [
      'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/climate%20change%20challengea.jpeg',
      'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/daily%20challenge.jpeg',
      'https://raw.githubusercontent.com/realabrar1/Climate-Care/main/google%20climate%20care%20challenge.jpeg',
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var url in imageUrls)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskConfirmationPage(
                          taskName: 'Global Challenge Task'),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  child: Image.network(url, fit: BoxFit.cover),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildTaskList() {
    List<String> tasks = getTasksForDay(selectedWeekday);

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tasks[index]),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TaskConfirmationPage(taskName: tasks[index])),
              );
            },
          ),
        );
      },
    );
  }

  Future<List<String>> fetchTasksFromGeminiAPI(String weekday) async {
    final url = Uri.parse('https://your-gemini-api-endpoint/tasks'); // Update with your actual API endpoint

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer YOUR_GEMINI_API_KEY', // Replace with your API key
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return List<String>.from(data['tasks']);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  List<String> getTasksForDay(String weekday) {
    Map<String, List<String>> weeklyTasks = {
      'Mon': [
        '1. Unplug all electronics not in use 🔌',
        '2. Adjust your thermostat down by 2 degrees (or up by 2 degrees in summer)',
        '3. Swap out one incandescent lightbulb 💡 for an LED',
        '4. Take a shorter shower 🚿',
        '5. Air dry dishes instead of using the dishwasher'
      ],
      // Other weekdays...
    };

    return weeklyTasks[selectedWeekday] ?? [];
  }
}

class TaskConfirmationPage extends StatefulWidget {
  final String taskName;

  TaskConfirmationPage({required this.taskName});

  @override
  _TaskConfirmationPageState createState() => _TaskConfirmationPageState();
}

class _TaskConfirmationPageState extends State<TaskConfirmationPage> {
  Uint8List? _imageBytes;
  String? _uploadedImageUrl;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
    app: Firebase.app(),
    bucket: 'careclimate-95ea3.appspot.com',
  );
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String feedback = '';

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageBytes == null) {
      print('No image selected.');
      return;
    }

    try {
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${widget.taskName}';
      final Reference ref = _storage.ref().child('task_images').child(fileName);
      final UploadTask uploadTask = ref.putData(_imageBytes!);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _uploadedImageUrl = downloadUrl;
      });
      _saveDataToDatabase(downloadUrl);
    } catch (e) {
      print('Image upload failed: $e');
    }
  }

  void _saveDataToDatabase(String imageUrl) {
    String userId = 'user_id_example'; // Replace with your user ID logic
    DatabaseReference ref = _database.ref('task_verifications/$userId');

    ref.set({
      'task_name': widget.taskName,
      'feedback': feedback,
      'image_url': imageUrl,
    });
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
            if (_uploadedImageUrl != null)
              Image.network(
                _uploadedImageUrl!,
                height: 200,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 200,
                color: Colors.grey[300],
                child: Icon(Icons.camera_alt, size: 100),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _pickImage(); // Ensure image is picked
                if (_imageBytes != null) {
                  await _uploadImage(); // Upload the image
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please capture a photo first.')),
                  );
                }
              },
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
                if (_uploadedImageUrl != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Task verified and image uploaded!')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please capture a photo first.')),
                  );
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
