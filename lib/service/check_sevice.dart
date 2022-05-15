import 'dart:async';
import 'dart:io';

import 'package:chat_console_app/service/data_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/security_service.dart';

DataService _service = DataService();
SecurityService _servic_security = SecurityService();
Future<bool> cheek()async{
  String result = await _service.readDate(key: "lock");
  double? time;
  if(result.isEmpty){
    return true;
  }else{
     time = double.parse(result) -  double.parse(lockTime());
    writeln(time);
    return false;
  }
}

Future<bool> confirm()async{
  bool check = await _servic_security.pasword();
  bool result = false;
    if (check) {
        result =await validator();
  }
return result;
}


Future<bool> validator()async{
  bool? checkPassword;
  while(true){
    writeln("password_confirm".tr);
      String password = read();
      checkPassword   = await _servic_security.checkPassword(password);
      if(checkPassword){
        return true;
      }
      writeln("account_lock".tr);
  await _service.storeData(key: "lock-$time()", value: lockTime());
    write("....");
    await waiting();
    write("....");
    await waiting();
    write("....");
    await waiting();
    writeln("....");
    if(password == "exit"){
      exit(101);
    }
}


    return true;
}