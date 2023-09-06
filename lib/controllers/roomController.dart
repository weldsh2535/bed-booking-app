import 'package:get/get.dart';
import 'package:tewos_app/db/db_helper.dart';

import '../models/rooms.dart';
import '../models/tasks.dart';

class RoomController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var roomList = <Rooms>[].obs;

  Future<int> addRoom({Rooms? rooms}) async{
    print(rooms?.toJson());
    var room = await DBHelper.insertRooms(rooms);
    getRooms();
    return room;
  }
  void getRooms() async {
    print("Call get function");
    List<Map<String,dynamic>> tasks = await DBHelper.queryRooms();
    roomList.assignAll(tasks.map((data) => new Rooms.fromJson(data)).toList());
   // print("Task List length is ${taskList.length}");
  }
  void delete(Rooms rooms){
    DBHelper.deleteRoom(rooms);
    getRooms();
  }
  Future<void> markTaskCompleted(int id) async {
   await DBHelper.updateRoom(id);
   getRooms();
  }
}