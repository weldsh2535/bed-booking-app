
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tewos_app/controllers/taskController.dart';
import 'package:tewos_app/services/notification_service.dart';
import 'package:tewos_app/services/theme_service.dart';
import 'package:tewos_app/ui/settings.dart';
import 'AddBookingPage.dart';
import 'MyHeaderDrawer.dart';
import 'AddRoms.dart';
import 'events.dart';
import 'notes.dart';
import 'notifications.dart';
import 'privacy_policy.dart';
import 'send_feedback.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
   var currentPage = DrawerSections.booking;
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
     _taskController.getTask();
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.booking) {
      container = AddBookingPage();
    } else if (currentPage == DrawerSections.addrooms) {
      container = AddRooms();
    } else if (currentPage == DrawerSections.events) {
      container = EventsPage();
    } else if (currentPage == DrawerSections.notes) {
      container = NotesPage();
    } else if (currentPage == DrawerSections.settings) {
      container = SettingsPage();
    } else if (currentPage == DrawerSections.notifications) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.privacy_policy) {
      container = PrivacyPolicyPage();
    } else if (currentPage == DrawerSections.send_feedback) {
      container = SendFeedbackPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Bed Booking"),
      ),
      backgroundColor: context.theme.backgroundColor,
      body:container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeaderDrawer(),
              MyDrawerList()
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList(){
    return   Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Booking", Icons.dashboard_outlined,
              currentPage == DrawerSections.booking ? true : false),
          menuItem(2, "Add Rooms", Icons.add_box,
              currentPage == DrawerSections.addrooms ? true : false),
          menuItem(3, "Events", Icons.event,
              currentPage == DrawerSections.events ? true : false),
          menuItem(4, "Notes", Icons.notes,
              currentPage == DrawerSections.notes ? true : false),
          Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          Divider(),
          menuItem(7, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(8, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  
  }
   Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.booking;
            } else if (id == 2) {
              currentPage = DrawerSections.addrooms;
            } else if (id == 3) {
              currentPage = DrawerSections.events;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 8) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          size: 20,
        ),
        //  CircleAvatar(
        //  backgroundImage:AssetImage("images/profile.png")

        // ),

        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
enum DrawerSections {
  booking,
  addrooms,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}