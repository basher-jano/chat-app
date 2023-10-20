import 'package:chat_app/constants.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromeJson(jsonData) {
    return Message(jsonData[kmessage], jsonData['id']);
  }
}
