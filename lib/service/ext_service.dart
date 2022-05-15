import 'package:chat_console_app/service/lang_service.dart';
import 'package:chat_console_app/service/loc/en_EN.dart';
import 'package:chat_console_app/service/loc/ru_RU.dart';
import 'package:chat_console_app/service/loc/uz_UZ.dart';

extension Ext on String {
  String get tr {
    switch (LangService.language) {
      case Language.en:
        return enEN[this] ?? this;
      case Language.ru:
        return ruRU[this] ?? this;
      case Language.uz:
        return uzUZ[this] ?? this;
    }
  }










}
