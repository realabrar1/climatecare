import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:careclimate/features/user_auth/presentation/pages/taskverificationpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';

import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart'
    as auth_task;
import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart'
    as auth_community;
import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart'
    as auth_profile;

import 'package:careclimate/features/user_auth/presentation/pages/task_page.dart';
import 'package:careclimate/features/user_auth/presentation/pages/community_page.dart';
import 'package:careclimate/features/user_auth/presentation/pages/profile_page.dart';
import 'package:careclimate/features/user_auth/presentation/pages/task_confirmation_page.dart';

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
    // Your existing weekly tasks
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
          CommunityPage(),
          ProfilePage(),
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
            BannerWidget(),
            SizedBox(height: 20),
            buildCO2eqButtons(),
            SizedBox(height: 20),
            buildTodayTaskSection(),
            SizedBox(height: 20),
            buildCommunityPostsSection(),
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
                                  TaskConfirmationPage(taskName: tasks[index]),
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
          width: double.infinity,
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
