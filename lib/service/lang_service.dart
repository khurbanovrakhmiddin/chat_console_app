import 'package:chat_console_app/service/data_service.dart';


enum Language {ru,uz,en}

class LangService{
  static Language _language = Language.uz;

  static final DataService _dataService = DataService();

  static Future<Language> currentLanguage() async {
    await _dataService.init();
    var result = await _dataService.readDate(key: "language");
    if(result != null) {
      _language = _stringLanguage(result);
    }
    return _language;
  }
  // setter
  static set language(Language language) {
    _language = language;
     _dataService.storeData(key: "language", value: _language.name).whenComplete(() => {});

  }

  // getter
  static Language get language => _language;

 static Language _stringLanguage(String lang){
    switch(lang){
      case "uz": return Language.uz;
      case "ru": return Language.ru;
      case "en": return Language.en;
      default: return Language.uz;
    }
  }




}