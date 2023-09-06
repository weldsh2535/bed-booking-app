import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tewos_app/controllers/roomController.dart';
import 'package:tewos_app/controllers/taskController.dart';
import 'package:tewos_app/models/tasks.dart';
import 'package:tewos_app/ui/Theme.dart';
import 'package:tewos_app/ui/widgets/button.dart';

import '../../models/rooms.dart';
import 'input_field.dart';

class AddRoomsPage extends StatefulWidget {
  const AddRoomsPage({Key? key}) : super(key: key);
  @override
  _AddRoomsPageState createState() => _AddRoomsPageState();
}

class _AddRoomsPageState extends State<AddRoomsPage> {
  final RoomController _roomController = Get.put(RoomController());
  final TextEditingController _roomnameController = TextEditingController();
  final TextEditingController _numberOfPeopleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate1 = DateTime.now();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedTypeOfRoom = "Room";
  List<String> typeOfRoom = ["Room", "Studio", "Apartment", "Bed","House"];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Room ",
                style: headingStyle,
              ),
              MyInputField(
                title: "Room Name",
                hint: "Enter a room name",
                controller: _roomnameController,
              ),
         
              MyInputField(
                title: "Number of people in room",
                hint: "Enter number of people",
                controller: _numberOfPeopleController,
                keyboardType: TextInputType.number,
              ),
                      
              MyInputField(
                title: "Type",
                hint: "$_selectedTypeOfRoom repeat",
                widget: DropdownButton(
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTypeOfRoom = newValue!;
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  items:
                      typeOfRoom.map<DropdownMenuItem<String>>((String values) {
                    return DropdownMenuItem<String>(
                        value: values,
                        child: Text(
                          values,
                          style: TextStyle(color: Colors.grey),
                        ));
                  }).toList(),
                ),
              ),

              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "Create Task", onTap: () => _validateData())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_roomnameController.text.isNotEmpty && _numberOfPeopleController.text.isNotEmpty) {
//add to
      _addTaskToDb();
      Get.back();
    } else if (_roomnameController.text.isNotEmpty ||
        _numberOfPeopleController.text.isNotEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    child: _selectedColor == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back,
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

  _getDataFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2013),
        lastDate: DateTime(2129));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("it's null or something is wrong");
    }
  }

  _getDataFromUserExit() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2013),
        lastDate: DateTime(2129));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate1 = _pickerDate;
      });
    } else {
      print("it's null or something is wrong");
    }
  }
  
  _addTaskToDb() async {
  int value= await _roomController.addRoom(
        rooms: Rooms(
            name: _roomnameController.text,
            numberOfPeople: int.parse(_numberOfPeopleController.text),
            type: _selectedTypeOfRoom,
            color: _selectedColor,
            ));
            print("My id is  $value");
  }
}
