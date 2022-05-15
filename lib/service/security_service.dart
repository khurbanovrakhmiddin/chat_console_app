
import 'package:chat_console_app/service/data_service.dart';

import 'io_service.dart';

class SecurityService {
  final DataService _dataService = DataService();

  // setPassword
  Future<bool> pasword()async{
    String source =await _dataService.readDate(key: "password");
    if(source.isNotEmpty){
      return true;
    }
    return false;
  }
  Future<bool> setPassword(String password) async {
    if(password.length >= 4) {
      await _dataService.storeData(key: "password", value: password);
      return true;
    }
    return false;
  }

  // checkPassword
  Future<bool> checkPassword(String password) async {
    String installedPassword = await _dataService.readDate(key: "password");
    return password == installedPassword;
  }

  // deletePassword
  Future<void> deletePassword() async {
    writeln("\n\n\n\n\n\n\n\n\n\n\n\n");

    await _dataService.deleteData(key: "password");
  }
}