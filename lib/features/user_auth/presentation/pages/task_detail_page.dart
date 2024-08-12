// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart';
// import 'dart:io';

// class TaskDetailPage extends StatefulWidget {
//   final String task;

//   TaskDetailPage({required this.task});

//   @override
//   _TaskDetailPageState createState() => _TaskDetailPageState();
// }

// class _TaskDetailPageState extends State<TaskDetailPage> {
//   final _inputController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   File? _image;

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   void _saveRecord() {
//     // Save the record to Firebase and navigate to ProfilePage
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ProfilePage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Task Details"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Task: ${widget.task}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             TextField(
//               controller: _inputController,
//               decoration: InputDecoration(
//                 labelText: 'Input Text',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text("Upload Photo"),
//             ),
//             _image != null ? Image.file(_image!, height: 200) : Container(),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _saveRecord,
//               child: Text("Save Record"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class TaskDetailsPage extends StatefulWidget {
//   @override
//   _TaskDetailsPageState createState() => _TaskDetailsPageState();
// }

// class _TaskDetailsPageState extends State<TaskDetailsPage> {
//   final _taskNameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   File? _image;

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   void _saveTask() {
//     if (_taskNameController.text.isEmpty ||
//         _descriptionController.text.isEmpty ||
//         _image == null) {
//       // Show error message
//       return;
//     }
//     // Save task data and image to Firebase
//     Navigator.of(context).pop(); // Navigate back after saving
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Details'),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _taskNameController,
//               decoration: InputDecoration(labelText: 'Task Name'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//               maxLines: 3,
//             ),
//             SizedBox(height: 20),
//             _image != null
//                 ? Image.file(_image!)
//                 : TextButton(
//                     onPressed: _pickImage,
//                     child: Text('Pick Image'),
//                   ),
//             Spacer(),
//             ElevatedButton(
//               onPressed: _saveTask,
//               child: Text('Save Task'),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// lib/features/user_auth/presentation/pages/task_details_page.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:io';

// class TaskDetailsPage extends StatefulWidget {
//   final String taskName;

//   TaskDetailsPage({required this.taskName});

//   @override
//   _TaskDetailsPageState createState() => _TaskDetailsPageState();
// }

// class _TaskDetailsPageState extends State<TaskDetailsPage> {
//   final _taskNameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   File? _image;

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   Future<void> _saveTask() async {
//     if (_image == null) {
//       // Show error message
//       return;
//     }

//     final user = FirebaseAuth.instance.currentUser;
//     final storageRef = FirebaseStorage.instance
//         .ref()
//         .child('task_images')
//         .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
//     await storageRef.putFile(_image!);
//     final imageUrl = await storageRef.getDownloadURL();

//     FirebaseFirestore.instance.collection('task_details').add({
//       'task_name': _taskNameController.text,
//       'description': _descriptionController.text,
//       'image_url': imageUrl,
//       'user_id': user?.uid,
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.taskName),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             TextField(
//               controller: _taskNameController,
//               decoration: InputDecoration(
//                 labelText: 'Task Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _descriptionController,
//               maxLines: 4,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             _image != null
//                 ? Image.file(_image!)
//                 : Container(
//                     height: 200,
//                     color: Colors.grey[300],
//                     child: Center(child: Text('No image selected')),
//                   ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Upload Photo'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _saveTask,
//               child: Text('Save Record'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ///end
import 'package:flutter/material.dart';

// class TaskDetailsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Global Challenge'),
//         backgroundColor: Colors.blue[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Current Global Challenges',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue[700],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildChallengeCard(
//               title: 'Reduce Single-Use Plastics',
//               description: 'Avoid using single-use plastics for a week.',
//               progress: 0.7,
//             ),
//             SizedBox(height: 20),
//             buildChallengeCard(
//               title: 'Carpool or Use Public Transport',
//               description:
//                   'Reduce carbon footprint by carpooling or using public transport.',
//               progress: 0.5,
//             ),
//             SizedBox(height: 20),
//             buildChallengeCard(
//               title: 'Plant a Tree',
//               description: 'Participate in a tree-planting activity.',
//               progress: 0.3,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildChallengeCard({
//     required String title,
//     required String description,
//     required double progress,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue[700],
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               description,
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             LinearProgressIndicator(
//               value: progress,
//               backgroundColor: Colors.grey[200],
//               color: Colors.blue[700],
//               minHeight: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(home: TaskDetailsPage()));
///////////////////////////////////
class TaskDetailsPage extends StatefulWidget {
  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  String? selectedTaskCategory;
  String? selectedTaskType;
  double taskDuration = 0.5;
  double taskWeight = 1500.0;
  double numberOfOffsets = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTaskDetailsHeader(),
              SizedBox(height: 20),
              buildTaskCategorySelector(),
              if (selectedTaskCategory == 'Appliances') buildApplianceTask(),
              if (selectedTaskCategory == 'Products') buildProductTask(),
              if (selectedTaskCategory == 'Travel') buildTravelTask(),
              if (selectedTaskCategory == 'Aid') buildAidTask(),
              SizedBox(height: 20),
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTaskDetailsHeader() {
    return Text(
      'Task Details',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.green[700],
      ),
    );
  }

  Widget buildTaskCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Category',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          hint: Text('Select Category'),
          items: <String>['Appliances', 'Products', 'Travel', 'Aid']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedTaskCategory = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildApplianceTask() {
    return buildTaskContainer(
      title: 'Appliances',
      children: [
        buildDropdown(
          title: 'Cooking: Oven',
          items: ['Did not use oven', 'Used oven'],
          onChanged: (value) {
            setState(() {
              selectedTaskType = value;
            });
          },
        ),
        buildSlider(
          title: 'Duration (hours)',
          value: taskDuration,
          min: 0,
          max: 24,
          divisions: 48,
          onChanged: (value) {
            setState(() {
              taskDuration = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildProductTask() {
    return buildTaskContainer(
      title: 'Products',
      children: [
        buildDropdown(
          title: 'Transport',
          items: ['Car', 'Bike', 'Public Transport'],
          onChanged: (value) {
            setState(() {
              selectedTaskType = value;
            });
          },
        ),
        buildSlider(
          title: 'Weight (kg)',
          value: taskWeight,
          min: 0,
          max: 5000,
          divisions: 100,
          onChanged: (value) {
            setState(() {
              taskWeight = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildTravelTask() {
    return buildTaskContainer(
      title: 'Travel',
      children: [
        buildTextField(
          title: 'Distance Travelled (Km)',
          keyboardType: TextInputType.number,
          onChanged: (value) {},
        ),
        buildDropdown(
          title: 'Travelled By',
          items: ['Electric Bicycle', 'Car (alone)', 'Car (shared)'],
          onChanged: (value) {
            setState(() {
              selectedTaskType = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildAidTask() {
    return buildTaskContainer(
      title: 'Personal Social Responsibility',
      children: [
        buildDropdown(
          title: 'Forestry / Tree Plantation',
          items: ['Purchased Carbon Offsets', 'Forestry'],
          onChanged: (value) {
            setState(() {
              selectedTaskType = value;
            });
          },
        ),
        buildSlider(
          title: 'Number of Carbon Offsets',
          value: numberOfOffsets,
          min: 0,
          max: 10,
          divisions: 10,
          onChanged: (value) {
            setState(() {
              numberOfOffsets = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildTaskContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700]),
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget buildDropdown({
    required String title,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          hint: Text('Select Task Type'),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildSlider({
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: value.toString(),
          onChanged: onChanged,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildTextField({
    required String title,
    required TextInputType keyboardType,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onChanged,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Save task details
        },
        child: Text('Save Record'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[700],
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
