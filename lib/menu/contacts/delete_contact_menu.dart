import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/service/contact_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/network_service.dart';

import '../../pages/navigate_menu.dart';

class DeleteContact extends Menu {
  static final String id = "/delete_contact_menu";

  final ContactService _service = ContactService();

  Future<void> deleteCont() async {
    writeln("");
    Map res = await _service.readAllContact();
    if (res.isEmpty) {
      writeln("empty".tr);
      write("....25");
      await waiting();
      write("....50");
      await waiting();
      write("....75");
      await waiting();
      writeln("....100");
      await  Navigator.pop();
    }
    writeln("");
    writeln("chose".tr);
    writeln("");
    String selecte = read();
    if (selecte == "exit") {
      await Navigator.pop();
    }

    await NetworkService.DELETE(
        NetworkService.apiUsers + "/" + selecte, NetworkService.headers);

    await _service.init();
    writeln("");
    writeln("success_update".tr);
    writeln("");
  }

  @override
  Future<void> build() async {
    writeln("delete_one".tr);
    await deleteCont();
    writeln("");
    await Navigator.pop();
  }
}
