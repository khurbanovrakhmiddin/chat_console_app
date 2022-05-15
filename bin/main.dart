import 'package:chat_console_app/menu/contacts/add_contact_menu.dart';
import 'package:chat_console_app/menu/contacts/contacts_menu.dart';
import 'package:chat_console_app/menu/contacts/delete_contact_menu.dart';
import 'package:chat_console_app/menu/contacts/read_menu.dart';
import 'package:chat_console_app/menu/home_menu.dart';
import 'package:chat_console_app/menu/message/send_message_menu.dart';
import 'package:chat_console_app/menu/settings/id_service.dart';
import 'package:chat_console_app/menu/settings/lang_menu.dart';
import 'package:chat_console_app/menu/settings/securty_menu.dart';
import 'package:chat_console_app/menu/settings/settings_menu.dart';
import 'package:chat_console_app/service/chat_app_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/lang_service.dart';
import 'package:chat_console_app/service/message_service.dart';

void main()async{
  print(time());
  MyApp(
    home: HomeMenu(),
    locale: await LangService.currentLanguage(),
    routes: {
      HomeMenu.id: HomeMenu(),
      Contacts.id:Contacts(),
      AddContact.id: AddContact(),
      DeleteContact.id: DeleteContact(),
      ReadAllMenu.id:ReadAllMenu(),
      ChatMenu.iD:ChatMenu(),
      SettingsMenu.id: SettingsMenu(),
      LangMenu.id:LangMenu(),
      SecurityMenu.id:SecurityMenu(),
      ID.id:ID(),
    },
  );


}


