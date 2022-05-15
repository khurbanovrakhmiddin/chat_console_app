import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/data_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';

class ID extends Menu {
  static final String id = '/id_menu';

  final DataService _service = DataService();

  Future<void> checkID() async {
    String id = await _service.readDate(key: "id");

    if (id != "") {
      await _service.deleteData(key: 'id');
      writeln("succes".tr);
    }else
      {
        writeln("empty".tr);
      }
  }

  @override
  Future<void> build() async {
    await checkID();
    await Navigator.pop();
  }
}
