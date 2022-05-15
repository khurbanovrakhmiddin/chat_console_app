import 'dart:convert';
import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/model/message_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/chat_service.dart';
import 'package:chat_console_app/service/contact_service.dart';
import 'package:chat_console_app/service/data_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/network_service.dart';

class SendMessage extends Menu {
  static final String iD = "send_message_menu";

  final DataService _dataService = DataService();
  final ChatService _chat = ChatService();
  final ContactService _contact = ContactService();



  Future<void> sendMessage() async {

    bool status = false;
    bool chatStatus = true;
    List history = [];
    List index = [];
    String? user;
    String msg = 'is empty';
    String text = '';
    String myId = '';
    String? res;

    await _contact.readAllContact();

    do {
      writeln("who".tr);
      user = read();

      String id = await _dataService.readDate(key: "id");

      ///TEkshiriladi id teng emasmi ozimizda bor id ga va
      ///yoki id data service ga kiritlganmi

      if (id == "") {
        writeln('id'.tr);
        myId = read();
        await _dataService.storeData(key: 'id', value: myId);
      } else {
        if (id == user) {
          writeln("error".tr);
          status = true;
        }
        myId = id;
      }

      ///Shu yerdan kutish boshlanadi
    } while (status);

/////


    List chats = await _chat.readChat(key: user!);
    res = await NetworkService.GET(
        NetworkService.apiMessages, NetworkService.headers);
    ///
    if (chats.isNotEmpty) {
      history.addAll(chats);
      history.add(" " * 10 + time());
    } else {
      history.add(" " * 10 + time());
    }

    ///
    ///
    if (res != "404") {
      List list = jsonDecode(res);
      List<Message> m = list.map((e) => Message.fromJson(e)).toList();

      ///
      for (var element in m) {
        if (element.to == myId) {
          history.add(element.message);
          index.add(element.id);
        }
      }
      if (index.isNotEmpty) {
        try {
          await deleteResponse(index);
        } catch (e) {
          print(e);
        }
      }
    }

    writeln("instruction".tr);

    off:do {
      writeln("\n\n\n\n\n");
      for (var element in history) {
        print(element);
      }
      index.clear();
      text = '';

      one:
      while (true) {

        msg = read();

        if(msg == ""){

          res = await NetworkService.GET(
              NetworkService.apiMessages, NetworkService.headers);
          ///
          if (res != "404") {
            List list = jsonDecode(res);
            List<Message> m = list.map((e) => Message.fromJson(e)).toList();

            ///
            for (var element in m) {
              if (element.to == myId) {
                history.add(element.message);
                index.add(element.id);
              }
            }
            if (index.isNotEmpty) {
              try {
                await deleteResponse(index);
              } catch (e) {
                print(e);
              }
            }
          }
          writeln("\n\n\n\n\n\n\n\n");
          for (var element in history) {
            print(element);
          }

        }

        if (msg == ">") {
          break one;
        }

        if (msg.toLowerCase() == "off") {
          text = "off";
          chatStatus = false;
          break off;
        }
        text += msg;
      }
      text += "|" + sendTime() + "\n";
      history.add("\t\t\t\t\t\t\t\t" + text);
      try {
        await NetworkService.POST(
            NetworkService.apiMessages,
            NetworkService.headers,
            {'from': myId, 'to': user, 'message': text});
      } catch (e) {
        print(e);
      }
      d:while (true) {
        if (msg == 'cancel') {
          break;
        }
        await waiting();
        String response = '';
        try {
          response = await NetworkService.GET(
              NetworkService.apiMessages, NetworkService.headers);
        } catch (e) {
          print(e);
        }

        List list = jsonDecode(response);

        List<Message> message = await NetworkService.parseMessage(list);

        a:
        for (var element in message) {
          if (user == element.from.toString()) {
            if (!history.contains(element.message)) {
              if (element.message == "off") {
                msg = 'cancel';
                break a;
              }
              history.add(element.message.toString());
              index.add(element.id.toString());
            }
          }
        }
        if (index.isNotEmpty) {
          break d;
        }
      }

      try {
        await deleteResponse(index);
      } catch (e) {
        print(e);
      }
    } while (msg != "cancel");
    if (!chatStatus) {
      await NetworkService.POST(NetworkService.apiMessages,
          NetworkService.headers, {'from': myId, 'to': user, 'message': text});
    }
    await _chat.storeChat(key: user, value: history);
    await Navigator.pop();
  }

  @override
  Future<void> build() async {
    writeln("");
    await sendMessage();
    writeln("");
  }
}
