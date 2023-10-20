import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessages);
  void sendMessage({required message, required email}) {
    try {
      messages.add({
        kmessage: message,
        kcreatedAt: DateTime.now(),
        kid: email,
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void getMessages() {
    messages.orderBy(kcreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];

      for (var doc in event.docs) {
        messagesList.add(Message.fromeJson(doc));
      }

      emit(ChatSuccess(messagesList: messagesList));
    });
  }
}
// if (_controller.hasClients && endOfList == false) {
//           _controller.jumpTo(0);
//           endOfList = true;
//         }
//         if (snapshot.hasData) {
//           List<Message> messagesList = [];
//           for (int i = 0; i < snapshot.data!.docs.length; i++) {
//             messagesList.add(Message.fromeJson(snapshot.data!.docs[i]));
//             if (_controller.hasClients) {
//               _controller.animateTo(
//                 0,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeIn,
//               );
//             }
//           }
