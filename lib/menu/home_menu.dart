import 'dart:async';
import 'dart:io';
import 'package:chat_console_app/menu/contacts/contacts_menu.dart';
import 'package:chat_console_app/menu/message/send_message_menu.dart';
import 'package:chat_console_app/menu/settings/settings_menu.dart';
import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/message_service.dart';

class HomeMenu extends Menu {

  static const String id = "/home_menu";


  Future<void> selectFunction(String select) async {
    switch (select) {
      case "I":
        {
          await Navigator.push(Contacts());
        }
        break;
      case "II":
        {
          await Navigator.push(ChatMenu());
        }
        break;
      case "III":
        {
          await Navigator.push(SettingsMenu());
        }
        break;
      case "IV":
        {
          exit(0);
        }
    }
  }

  @override
  Future<void> build() async {

    try{

      writeln("");
      writeln("welcome".tr);
      writeln("I. " + "contact".tr);
      writeln("II. " + "send_message".tr);
      writeln("III. " + "settings".tr);
      writeln("IV. " + "exit".tr);
      writeln("");
      String selectedMenu = read();
      await selectFunction(selectedMenu);
      writeln("");
    }catch(e){
     await build();
    }
  }
}
