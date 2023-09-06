// ignore_for_file: public_member_api_docs, sort_constructors_first
class Rooms {
  int? id;
  String? name;
  int? numberOfPeople;
  String? type;
  int? color;
  Rooms({
   this.id,
   this.name,
   this.numberOfPeople,
   this.type,
   this.color
  });
  Rooms.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    numberOfPeople = json['numberOfPeople'];
    type = json['type'];
    color = json['color'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['numberOfPeople'] = this.numberOfPeople;
    data['type'] = this.type;
    data['color'] = this.color;

    return data;
  }
}
