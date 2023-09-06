import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tewos_app/models/rooms.dart';
import 'package:tewos_app/ui/widgets/button.dart';

import '../controllers/roomController.dart';
import '../controllers/taskController.dart';
import 'Theme.dart';
import 'widgets/add_rooms_bar.dart';
import 'widgets/room_tile.dart';
import 'widgets/task_tile.dart';

class AddRooms extends StatefulWidget {
   const AddRooms({Key? key}) : super(key: key);

  @override
  State<AddRooms> createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {
  final _roomController = Get.put(RoomController());
    @override
  void initState() {
    super.initState();
     _roomController.getRooms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      child: Center(
        child: Column(
          children: [
           SizedBox(height: 12,),
          _showTask()
        ]),
      ),
     ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: bluishClr,
      onPressed: () {
          Get.to(() => AddRoomsPage());
        _roomController.getRooms();    
      },
      child: Icon(Icons.add,),
    ),
    );
  }
    _showTask() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _roomController.roomList.length,
          itemBuilder: (_, index) {
            Rooms rooms = _roomController.roomList[index];
            //print(task.toJson());
            
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                    child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                         _showBottonSheet(context, rooms);
                        },
                        child: RoomTile(rooms),
                      )
                    ],
                  ),
                )),
              );
            
          });
    }));
  }

    _showBottonSheet(BuildContext context, Rooms task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.type == "Room"
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGeryClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          Spacer(),
          task.type == "Bed"
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _roomController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: primaryClr,
                  context: context
                  ),
          _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _roomController.delete(task);
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context
              ),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
              isClose: true,
              context: context),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }

_bottomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose == true
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : clr),
            borderRadius: BorderRadius.circular(20),
            color: isClose == true ? Colors.transparent : clr,
          ),
          child: Center(
            child: Text(
              label,
              style: isClose
                  ? titleStyle
                  : titleStyle.copyWith(color: Colors.white),
            ),
          )),
    );
  }


}
