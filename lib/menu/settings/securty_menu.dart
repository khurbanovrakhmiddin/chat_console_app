import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/check_sevice.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/security_service.dart';

class SecurityMenu extends Menu {

  static final String id = '/security_menu';

  final SecurityService _service = SecurityService();

  bool _status = true;

  Future<void> selectMenu(String select) async {

    switch (select) {

      case "I":
        await password();
        break;

        case "II":
        await deletePasword();
        break;

      case "III":
        await Navigator.pop();
        break;

      case "IV":
        await Navigator.popUntil();
        break;

        default:
          writeln("error".tr);
          await build();
    }
  }

  ///parol bulsa agar
  Future<void> password() async {
    bool chekPassword = true;

      writeln("password_update".tr);
      writeln("yes".tr + "- 1");
      writeln("no".tr + "- 0");

      String password1 = read();

      if (password1 == "0") {
       return;
      }

      writeln("password_set".tr);

      String password = read();

      await _service.setPassword(password);

      chekPassword = await _service.setPassword(password);
      if(!chekPassword){
        writeln("try_agin".tr);
        _status = false;
        await passwordNull();
      }
      writeln("success_update".tr);
      return;

  }

  //parol bulmasa

  Future<void> deletePasword() async {
                 bool check = await _service.pasword();
            if (!check) {
           writeln("password_not_found".tr);

            return;
    }
    // await validator();
           writeln("password_delete".tr);
           writeln("yes".tr + "- 1");
           writeln("no".tr + "- 0");

      String password1 = read();

    if (password1 == "0") {
      await Navigator.pop();
    }
    await _service.deletePassword();

    writeln("success_update".tr);
  }

  Future<void> passwordSet() async {
    writeln("password_update".tr);
    writeln("yes".tr + "- 1");
    writeln("no".tr + "- 0");

    String password1 = read();

    if (password1 == "0") {
      await Navigator.pop();
    }
    writeln("password_set".tr);
    String password = read();
    await _service.setPassword(password);
    writeln("success_set".tr);
    writeln("success_update".tr);
  }

  ///Agar Password bulmasa

  Future<void> selectMenuWithNullPassword(String select) async {
    switch (select) {
      case "I":
        await passwordNull();
        break;
      case "II":
        await Navigator.pop();
        break;
      case "III":
        await Navigator.popUntil();
        break;
      default:
        {
          writeln("error".tr);
          await build();
        }
    }
  }

       Future<void> passwordNull() async {
bool? chekPassword;
    if(_status) {
      writeln("password_set".tr + "?");
      writeln("yes".tr + "- 1");
      writeln("no".tr + "- 0");

      String question = read();

      if (question == "0") {
        return;
      }
    }
     writeln("password_set".tr);
     String password = read();
     await _service.setPassword(password);

    chekPassword = await _service.setPassword(password);
    if(!chekPassword){
      writeln("try_agin".tr);
      _status = false;
      await passwordNull();
    }
writeln("success_set".tr);
   }



  @override
  Future<void> build() async {
    writeln("");
    bool pas = await _service.pasword();

    if (pas) {
      await validator();

      writeln("I.  " + "password_update!".tr);
      writeln("II. " + "password_delete!".tr);
      writeln("III." + "back".tr);
      writeln("IV. " + "back_home".tr);

      String select = read();

      writeln("");

      await selectMenu(select);

    } else {

      writeln("I.  " + "password_set!".tr);
      writeln("II." + "back".tr);
      writeln("III. " + "back_home".tr);

      String select = read();

      writeln("");

      await selectMenuWithNullPassword(select);
      writeln("");
    }
  }
}
