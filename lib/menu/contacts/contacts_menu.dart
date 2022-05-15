import 'package:chat_console_app/menu/contacts/add_contact_menu.dart';
import 'package:chat_console_app/menu/contacts/delete_contact_menu.dart';
import 'package:chat_console_app/menu/contacts/read_menu.dart';
import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/contact_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';

import '../home_menu.dart';

class Contacts extends Menu {
  static final String id = "/contacts_menu";
ContactService aw = ContactService();
  Future<void> selectMenu(String select) async {
    switch (select) {
      case "I":
        {
          await Navigator.push(AddContact());
        }
        break;
      case "II":
        {
          await Navigator.push(DeleteContact());
        }
        break;
      case "III":
        {
           await Navigator.push(ReadAllMenu());
        }
        break;
      case "IV":
        {
        await  Navigator.pushReplacementNamed(HomeMenu.id);
        }
        break;
      default:
        {
          writeln("error".tr);
          await build();
        }
    }
  }

  @override
  Future<void> build() async {
    writeln("");
    writeln("I.  " + "add_contact".tr);
    writeln("II. " + "delete_contact".tr);
    writeln("III." + "read_all".tr);
    writeln("IV." + "back_home".tr);
    writeln("");
    String select = read();
    await selectMenu(select);
    writeln("");
  }
}
