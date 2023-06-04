import 'package:flutter/material.dart';

import '../constants/index.dart';

Widget errorContainer() {
  return Container(
    clipBehavior: Clip.hardEdge,
    child: Image.asset(
      'assets/images/img_not_available.jpeg',
      height: Sizes.dimen_200,
      width: Sizes.dimen_200,
    ),
  );
}

Widget chatImage({required String imageSrc, required Function onTap}) {
  return OutlinedButton(
      onPressed: onTap(),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.dimen_10),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.dimen_12),
        child: Image.network(
          imageSrc,
          width: Sizes.dimen_200,
          height: Sizes.dimen_200,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext ctx, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor2,
                borderRadius: BorderRadius.circular(Sizes.dimen_10),
              ),
              width: Sizes.dimen_200,
              height: Sizes.dimen_200,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.appNav,
                  value: loadingProgress.expectedTotalBytes != null &&
                          loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, object, stackTrace) => errorContainer(),
        ),
      ));
}

Widget messageBubble(
    {required String chatContent,
    required bool isMe,
    required EdgeInsetsGeometry? margin,
    Color? color,
    Color? textColor}) {
  return Container(
    padding: const EdgeInsets.all(Sizes.dimen_10),
    margin: margin,
    width: Sizes.dimen_200,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(Sizes.dimen_10),
          bottomRight: const Radius.circular(Sizes.dimen_10),
          topLeft: isMe ? const Radius.circular(Sizes.dimen_10) : Radius.zero,
          topRight: isMe ? Radius.zero : const Radius.circular(Sizes.dimen_10)),
    ),
    child: Text(
      chatContent,
      style: TextStyle(fontSize: Sizes.dimen_16, color: textColor),
    ),
  );
}
