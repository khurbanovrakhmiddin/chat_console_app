class User {
  String? id;
  late String? number;
  late String? name;



  User({this.id, required this.name, required this.number});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    number = json["number"];
    name = json["name"];

  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "name": name,

  };

  @override
  String toString() {
    return "ID : $id. Name: $name\t Number: $number\n\n";
  }
}