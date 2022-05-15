


import 'dart:convert';
import 'package:chat_console_app/menu/home_menu.dart';
import 'package:chat_console_app/model/home_model.dart';
import 'package:chat_console_app/model/message_model.dart';
import 'package:chat_console_app/pages/navigate_menu.dart';
import 'package:chat_console_app/service/chat_service.dart';
import 'package:chat_console_app/service/contact_service.dart';
import 'package:chat_console_app/service/data_service.dart';
import 'package:chat_console_app/service/ext_service.dart';
import 'package:chat_console_app/service/io_service.dart';
import 'package:chat_console_app/service/network_service.dart';

class ChatMenu extends Menu {
  static final String iD = "send_message_menu";

  final DataService _dataService = DataService();
  final ChatService _chat = ChatService();
  final ContactService _contact = ContactService();

  Future<void> sendMessage() async {
    bool status = false;
    bool chatStatus = true;
    bool statusMessage = false;
    bool loopStatus = false;

    List history = [];
    List index = [];
    String? user;
    String msg = 'is empty';
    String text1 = '';
    String myId = '';
    String? res;

    await _contact.readAllContact();

    do {
      writeln("who".tr);
      user = read();

      myId = await _dataService.readDate(key: "id");

      ///TEkshiriladi id teng emasmi ozimizda bor id ga va
      ///yoki id data service ga kiritlganmi

      if (myId == "") {
        writeln('id'.tr);
        myId = read();
        await _dataService.storeData(key: 'id', value: myId);
      } else {
        if (myId == user) {
          writeln("error".tr);
          status = true;
        }else{
          status = false;
        }
      }

      ///Shu yerdan kutish boshlanadi
    } while (status);
    writeln("\n\n\n\n\n");

/////

    List chats = await _chat.readChat(key: user!);

    ///
    if (chats.isNotEmpty) {
      history.addAll(chats);
      history.add(" " * 10 + time());
    } else {
      history.add(" " * 10 + time());
    }

    ///
    ///

    writeln("instruction".tr);

    do {
      res = await NetworkService.GET(
          NetworkService.apiMessages, NetworkService.headers);

     s:if (res != "404" || statusMessage) {
        if (!loopStatus) {
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
        } else {
          while (true) {

            await waiting();

            List list = jsonDecode(res!);
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
              }catch (e) {
                print(e);
              }
              break s;
            }
            res = await NetworkService.GET(
                NetworkService.apiMessages, NetworkService.headers);
          }
        }
      }

      index.clear();
      text1 = '';
      String text2 = '';

      writeln("\n" * 25);
      for (var element in history) {
        writeln(element);
      }
      while (true) {
        msg = read();

        if (msg == "check") {
          statusMessage = false;
          loopStatus = false;
          break;
        }

        if (msg == ">") {
          statusMessage = true;
          loopStatus = true;
          break;
        }
        if (msg.toLowerCase() == "off") {
          text1 = "off";
          chatStatus = false;
          break;
        }
        text1 += "\n" + msg;
        text2 += "\n\t\t\t\t\t\t\t\t" + msg;
        msg = '';
      }

      if (loopStatus) {
        text2 += " |" + sendTime() + "\n";
        history.add(text2);
        try {
          await NetworkService.POST(
              NetworkService.apiMessages,
              NetworkService.headers,
              {'from': myId, 'to': user, 'message': text1 + " |" + sendTime()});
        } catch (e) {
          print(e);
        }
      }
    } while (chatStatus);

    if (!chatStatus) {
      await NetworkService.POST(NetworkService.apiMessages,
          NetworkService.headers, {'from': myId, 'to': user, 'message': text1});
    }
    if (history.isNotEmpty) {
      await _chat.storeChat(key: user, value: history);
    }
  }

  @override
  Future<void> build() async {
    writeln("");
    await sendMessage();
    await Navigator.push(HomeMenu());
    writeln("");
  }
}
