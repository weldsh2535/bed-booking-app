// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  int? id;
  String? fullName;
  int? phoneNumber;
  int? kebele;
  int? houseNumber;
  int? roomNumber;
  String? registerDate;
  String? exitDate;
  int? color;
  Task({
   this.id,
   this.fullName,
   this.phoneNumber,
   this.kebele,
   this.houseNumber,
   this.roomNumber,
   this.registerDate,
   this.exitDate,
   this.color
  });
  Task.fromJson(Map<String,dynamic> json){
    id = json['id'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    kebele = json['Kebele'];
    houseNumber = json['houseNumber'];
    roomNumber = json['roomNumber'];
    registerDate = json['registerDate'];
    exitDate = json['exitDate'];
    color = json['color'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id']= this.id;
    data['fullName']=this.fullName;
    data['phoneNumber'] =this.phoneNumber;
    data['Kebele']=this.kebele;
    data['houseNumber']=this.houseNumber;
    data['roomNumber']= this.roomNumber;
    data['registerDate']=this.registerDate;
    data['exitDate']=this.exitDate;
    data['color']=this.color;

    return data;
  }
}
