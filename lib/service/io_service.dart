import 'dart:async';
import 'dart:io';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:intl/intl.dart';

import 'network_service.dart';

write<T>(T str) {
  stdout.write(str);
}

writeln<T>(T str) {
  print(str);
}

read<T>() {
  return stdin.readLineSync();
}
String time(){
  final DateTime now = DateTime.now();
  final DateTime res = DateTime(now.hour + 3);
  final DateFormat formatter = DateFormat('yyyy-MM-dd h:m');
  final String formatted = formatter.format(now);

  return formatted;
}
String lockTime(){
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('h.m');
  final String formatted = formatter.format(now);
  return formatted;
}
String sendTime(){
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('h:m');
  final String formatted = formatter.format(now);

  return formatted;
}


Future waiting(){
  return Future.delayed(Duration(seconds: 1));
}
Future waitingCont(){
  return Future.delayed(Duration(seconds: 3));
}

Future<bool> deleteResponse(List index)async{
  for(int i = 0; i < index.length;i++) {
    await NetworkService.DELETE(
        "/tg/api/v1/message/${index[i]}", NetworkService.headers);
  }
  return true;
}
String validPhone(){
  String phone = read();
if(phone == ""){
  validPhone();
}
  if(phone.length < 9){
    writeln('number_short'.tr);
    validPhone();
  }
  else if(phone.length > 12){
    writeln('number_long'.tr);
    validPhone();
  }
  try {
    int a = int.parse(phone);
  } catch(e) {
    print("error_number".tr);
    print("try_agin".tr);
 validPhone();
  }
  return phone;
}


