import 'dart:collection';
import 'dart:convert';
import 'dart:io';

class DataService {
  final  Directory _dirData = Directory(Directory.current.path + "/assets");
 final Directory _directory = Directory(Directory.current.path + "/assets/data");
  late File _file;

  ///Create
  Future<void> init() async {
    bool isDirAssetsCreated =  await _dirData.exists();
    if(!isDirAssetsCreated)
    {
      await _dirData.create();
    }

    bool isDirectoreyCreated = await _directory.exists();
    if(!isDirectoreyCreated)
   {
    await _directory.create();
   }
    _file = File(_directory.path + "//data.json");
    bool isContactsFileCreatd = await _file.exists();

    if (!isContactsFileCreatd) {
      await _file.create();
      await _file.writeAsString("{}");

    }
  }
//Store
  Future<bool> storeData({required String key, required dynamic value}) async {
    await init();
    bool result = false;
    bool vaildator = _vailidatorType(value);
    if (vaildator) {
      return false;
    }

    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isNotEmpty) {
      dataBase = jsonDecode(source);
    } else {
      dataBase = {};
    }
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
  Future<String> readDate({required String key}) async {
    await init();

    Map<String, dynamic> dataBase;
    String source = await _file.readAsString();
    if (source.isEmpty) {
     dataBase = {};
    } else {
      dataBase = jsonDecode(source);
    }
    String? res = dataBase[key];
    if(res == null){
      return "";
    }
    return res;
  }


  Future<bool> deleteData({required String key})async{
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


  Future<bool> clearDate()async{

    bool result = false;
    String source = await _file.readAsString();

    if(source.isEmpty){
      return result;
    }
    await _file.writeAsString("{}").whenComplete(() => {result = true}).catchError((_){result = false;});
    return result;

  }
}

bool _vailidatorType(dynamic x) {
  if (x != String &&
      x != num &&
      x != int &&
      x != double &&
      x != List &&
      x != Map &&
      x != Queue &&
      x != Runes) {
    return false;
  }
  return true;
}
