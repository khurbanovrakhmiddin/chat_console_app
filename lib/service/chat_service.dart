import 'dart:convert';
import 'dart:io';


class ChatService  {
  Directory _directory = Directory(Directory.current.path + "/assets/files ");
  late File _file;

  ///Create
  Future<void> init() async {
    bool isDirectoreyCreated = await _directory.exists();
    if(!isDirectoreyCreated)
    {
      await _directory.create();
    }
    _file = File(_directory.path + "//chats.json");
    bool isContactsFileCreatd = await _file.exists();

    if (!isContactsFileCreatd) {
      await _file.create();
      await _file.writeAsString("{}");

    }
  }
//Store
  Future<bool> storeChat({required String key, required List value}) async {
    await init();
    bool result = false;


    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isNotEmpty) {
      dataBase = jsonDecode(source);
    } else {
      dataBase = {};
    }
    bool find = dataBase.containsKey(key);
    if(find){
    dataBase.forEach((keyM, valueM) {
      if(keyM == key){
        value.addAll(valueM);
      }
    });
    }
    print(find);
    dataBase.addAll({key: value});

    source = jsonEncode(dataBase);

    await _file
        .writeAsString(source)
        .whenComplete(() => {result = true})
        .catchError((_) {
      return result;
    });

    return result;
  }
//Read
  Future<List> readChat({required String key}) async {
    await init();

    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isEmpty) {
     dataBase = {};
    } else {
      dataBase = jsonDecode(source);
    }
    List result = [];
    dataBase.forEach((keyM, valueM) {
      if(keyM == key){
        result.addAll(valueM);
      }
    });
    return result;
  }


  Future<bool> deleteChat({required String key})async{
    bool result = false;
    String source = await _file.readAsString();

    if(source.isEmpty){
      return false;
    }

    Map<String,dynamic> dataBase = jsonDecode(source);

    dataBase.remove(key);
    source =  jsonEncode(dataBase);
    await _file.writeAsString(source).whenComplete(() => {result = true}).catchError((_){result = false;});
    return result;


  }


  Future<bool> clearChat()async{

    bool result = false;
    String source = await _file.readAsString();

    if(source.isEmpty){
      return result;
    }
    await _file.writeAsString("{}").whenComplete(() => {result = true}).catchError((_){result = false;});
    return result;

  }
}


