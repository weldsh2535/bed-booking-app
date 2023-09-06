import 'package:get/get.dart';
import 'package:tewos_app/db/db_helper.dart';

import '../models/tasks.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    print(task?.toJson());
    return await DBHelper.insert(task);
  }
  void getTask() async {
    print("Call get function");
    List<Map<String,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
   // print("Task List length is ${taskList.length}");
  }
  void delete(Task task){
    DBHelper.delete(task);
    getTask();
  }
  Future<void> markTaskCompleted(int id) async {
   await DBHelper.update(id);
   getTask();
  }
}