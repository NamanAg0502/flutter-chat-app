import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/index.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    Key? key,
    required this.getImage,
    required this.avatarImageFile,
    required this.photoUrl,
  }) : super(key: key);

  final Function getImage;
  final File? avatarImageFile;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    // Widget code goes here
    return GestureDetector(
      onTap: () => getImage(),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: avatarImageFile == null
            ? photoUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      photoUrl,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                      errorBuilder: (context, object, stackTrace) {
                        return const Icon(
                          Icons.account_circle,
                          size: 90,
                          color: AppColors.greyColor,
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                          width: 90,
                          height: 90,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Icon(
                    Icons.account_circle,
                    size: 90,
                    color: AppColors.greyColor,
                  )
            : ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.file(
                  avatarImageFile!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
