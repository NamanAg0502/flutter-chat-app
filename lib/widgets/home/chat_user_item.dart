import 'package:chat/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_user.dart';
import '../../screens/chat/chat_screen.dart';
import '../../utils/keyboard.dart';

class ChatItemWidget extends StatelessWidget {
  final String currentUserId;
  final DocumentSnapshot? documentSnapshot;

  const ChatItemWidget({
    super.key,
    required this.currentUserId,
    required this.documentSnapshot,
  });

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;

    if (documentSnapshot != null) {
      ChatUser userChat = ChatUser.fromDocument(documentSnapshot!);

      if (userChat.id == currentUserId) {
        return const SizedBox.shrink();
      } else {
        return TextButton(
          onPressed: () {
            if (KeyboardUtils.isKeyboardShowing(context)) {
              KeyboardUtils.closeKeyboard(context);
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  peerId: userChat.id,
                  peerAvatar: userChat.photoUrl,
                  peerNickname: userChat.displayName,
                  userAvatar: firebaseAuth.currentUser!.photoURL!,
                ),
              ),
            );
          },
          child: ListTile(
            leading: userChat.photoUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      userChat.photoUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      loadingBuilder: (BuildContext ctx, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, object, stackTrace) {
                        return const Icon(Icons.account_circle, size: 50);
                      },
                    ),
                  )
                : const Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
            title: Text(
              userChat.displayName,
              style: const TextStyle(color: AppColors.appText),
            ),
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
