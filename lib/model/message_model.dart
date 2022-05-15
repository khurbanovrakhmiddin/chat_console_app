

class Message {
  String? from;
  String? to;
  String? message;
  String? id;


  Message(
      {required this.from,required this.to,required this.message,this.id});

  Message.fromJson(Map<String, dynamic> json) :
    from = json['from'].toString(),
    to = json['to'].toString(),
    id = json['id'].toString(),
    message = json['message'].toString();


   Map<String, dynamic> toJson()=> {

    'from':from,
    'to':to,
    'message':message,
     'id':id,

  };
}