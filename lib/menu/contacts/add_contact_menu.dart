import 'package:chat_console_app/menu/home_menu.dart';
import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/contact_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/network_service.dart';

class AddContact extends Menu {
  static final String id = "add_contact_menu";

 final ContactService _contact = ContactService();

  Future<void> add() async {
    Map res =  await _contact.readAllContact();
    if(res.isEmpty){
      write("....");
      await waitingCont();
      write("....");
      writeln("empty".tr);
    }
    writeln("");
    write("phone".tr + ": ");
    String phone = validPhone();
    writeln("");
    write("name".tr + ": ");
    String name = read();
    writeln("");
try {
  await NetworkService.POST(NetworkService.apiUsers, NetworkService.headers,
      {"name": name, "number": phone});
}catch(e){
  print(e);
  await Navigator.push(HomeMenu());
}
  }

  @override
  Future<void> build() async {
    writeln("");
    await add();
    writeln("");
    await Navigator.push(HomeMenu());  }
}
