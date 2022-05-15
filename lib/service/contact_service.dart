import 'dart:convert';
import 'dart:io';

import 'package:chat_console_app/model/users_model.dart';
import 'package:chat_console_app/service/data_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/network_service.dart';

class ContactService {
  final Directory _directory =
      Directory(Directory.current.path + "/assets/files ");
  late File _file;
final DataService _service = DataService();
  ///Create
  Future<void> init() async {
    bool isDirectoreyCreated = await _directory.exists();
    if (!isDirectoreyCreated) {
      await _directory.create();
    }
    _file = File(_directory.path + "//contacts.json");
    bool isContactsFileCreatd = await _file.exists();

    if (!isContactsFileCreatd) {
      await _file.create();
      await _file.writeAsString("{}");
    }
  }

//Store
  Future<bool> storeContact({required Map<String, dynamic> contact}) async {
    await init();

    bool result = false;

    Map<String, dynamic> dataBase = contact;

    String source = jsonEncode(dataBase);
    await _file
        .writeAsString(source)
        .whenComplete(() => {result = true})
        .catchError((_) {
      return result;
    });

    return result;
  }

//Read
  Future<String> readContact({required String key}) async {
    await init();
String res = '';
    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isEmpty) {
      dataBase = {};
    } else {
      dataBase = jsonDecode(source);
    }
    dataBase.forEach((keyM, valueM) {
      if (keyM == key) {
        res =valueM;
      }
    });
    return res;
  }

  Future<bool> deleteContact({required String key}) async {
    bool result = false;
    String source = await _file.readAsString();

    if (source.isEmpty) {
      return false;
    }

    Map<String, dynamic> dataBase = jsonDecode(source);

    dataBase.remove(key);
    source = jsonEncode(dataBase);
    await _file
        .writeAsString(source)
        .whenComplete(() => {result = true})
        .catchError((_) {
      result = false;
    });
    return result;
  }

  Future<bool> clearContact() async {
    bool result = false;
    String source = await _file.readAsString();

    if (source.isEmpty) {
      return result;
    }
    await _file
        .writeAsString("{}")
        .whenComplete(() => {result = true})
        .catchError((_) {
      result = false;
    });
    return result;
  }

  Future<Map<String,dynamic>> getContacts() async {
    await init();
    await _downloadContacts();
    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isEmpty) {
      dataBase = {};
    } else {
      dataBase = jsonDecode(source);
    }

    return dataBase;
  }

  Future<Map> readAllContact() async {
    await init();

    await _downloadContacts();
 String myID = '';
    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isEmpty) {
      dataBase = {};
    } else {
      dataBase = jsonDecode(source);
    }
    String id = await _service.readDate(key: "id");
    if (id != "") {
      myID = id;
    }


     dataBase.forEach((key, value) async{

      int colmn = 18 - value[0].toString().length;
      String columnSize = ' ' * colmn;
if(key != myID){
  writeln("ID " +
      key +
      "   " +
      "Name - " +
      value[0] +
      columnSize +
      "Phone - " +
      value[1]);
}

    });
    return dataBase;
  }

  Future<bool> _downloadContacts() async {
    await storeContact(contact: await parseContacts());
    return true;
  }

  Future<Map<String, dynamic>> parseContacts() async {
    String result = await NetworkService.GET(
        NetworkService.apiUsers, NetworkService.headers);

    if(result == '404'){
      writeln("empty".tr);
      return {};
    }
    List data = jsonDecode(result);
    List<User> user = NetworkService.parseUsers(data);

    Map<String, dynamic> map = {};
    for(var element in user){
      map.addAll({
        element.id.toString(): [element.name, element.number]
      });
    }
    return map;
  }
}
