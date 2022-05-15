import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/check_sevice.dart';
import 'package:chat_console_app/service/lang_service.dart';
import 'package:chat_console_app/service/security_service.dart';

class MyApp {
  static Map<String, Menu> routeMenu = {};

  final SecurityService _service = SecurityService();

  MyApp(
      {required Menu home,
      required Language locale,
      required Map<String, Menu> routes}) {
    routeMenu = routes;
    LangService.language = locale;
    Navigator.initialValue = home;
    _runApp(home);
  }

  void _runApp(Menu menu) async {
    bool check = await _service.pasword();
    if (check) {
      while (true) {
        bool password = await validator();
        if (password) {
          break;
        }
      }
    }
    int i = 0;
    while (true) {
      print(i++);
      await menu.build();
    }
  }
}
