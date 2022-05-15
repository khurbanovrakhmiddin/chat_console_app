import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/data_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/lang_service.dart';

class LangMenu extends Menu {
  static final String id = "/lang_menu";

  DataService _serv = DataService();

  Future<void> selectLang(String select) async {
    switch (select) {
      case "I":
        {
          LangService.language = Language.uz;
          await _serv.storeData(key: "language", value: "uz");
        }
        break;
      case "II":
        {
          LangService.language = Language.ru;
          await _serv.storeData(key: "language", value: "ru");
        }
        break;
      case "III":
        {
          LangService.language = Language.en;
          await _serv.storeData(key: "language", value: "en");
        }
        break;
      case "IV":
        {
          await  Navigator.pop();
        }
        break;
      case "V":
        {
          await Navigator.popUntil();
        }
        break;
      default:
        {
          writeln("error_chose".tr);
          await build();
        }
    }
  }

  @override
  Future<void> build() async {
    writeln("I.  " + "uzb".tr);
    writeln("II. " + "rus".tr);
    writeln("III." + "eng".tr);
    writeln("IV." + "back".tr);
    writeln("V." + "back_home".tr);

    String select = read();
    writeln("");
    await selectLang(select);
    writeln("");
    await Navigator.pop();
  }
}
