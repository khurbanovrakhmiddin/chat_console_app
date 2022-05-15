import 'package:chat_console_app/menu/home_menu.dart';
import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/contact_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';

class ReadAllMenu extends Menu {
  static final String id = "/read_menu";

  final ContactService _contact = ContactService();

  Future<void> readall() async {
    Map res =  await _contact.readAllContact();
    if(res.isEmpty){
      write("....");
      await waitingCont();
      write("....");
      writeln("empty".tr);
    }
  }

  @override
  Future<void> build() async {
    writeln("");
    await readall();
    writeln("");
   await Navigator.push(HomeMenu());
  }
}
