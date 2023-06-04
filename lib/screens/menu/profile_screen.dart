import 'dart:io';
import 'package:chat/widgets/bottom_navigation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../constants/index.dart';
import '../../models/chat_user.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/avatar_image.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_form_field.dart';
import '../../widgets/select_country_code.dart';
import '../auth/login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String currentUserId;
  late ProfileProvider profileProvider;
  final FocusNode focusNodeNickname = FocusNode();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String dialCodeDigits = '+00';
  String id = '';
  String displayName = '';
  String photoUrl = '';
  String phoneNumber = '';
  String aboutMe = '';

  bool isLoading = false;
  File? avatarImageFile;

  @override
  void initState() {
    super.initState();
    profileProvider = context.read<ProfileProvider>();
    readLocal();
  }

  @override
  void dispose() {
    displayNameController.dispose();
    aboutMeController.dispose();
    phoneController.dispose();
    focusNodeNickname.dispose();
    super.dispose();
  }

  void readLocal() {
    id = profileProvider.getPrefs(FirestoreConstants.id) ?? '';
    displayName =
        profileProvider.getPrefs(FirestoreConstants.displayName) ?? '';
    photoUrl = profileProvider.getPrefs(FirestoreConstants.photoUrl) ?? '';
    phoneNumber =
        profileProvider.getPrefs(FirestoreConstants.phoneNumber) ?? '';
    aboutMe = profileProvider.getPrefs(FirestoreConstants.aboutMe) ?? '';

    displayNameController.text = displayName;
    aboutMeController.text = aboutMe;

    setState(() {});
  }

  Future<void> getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;

    try {
      pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
      uploadFile();
    }
  }

  Future<void> uploadFile() async {
    String fileName = id;
    UploadTask uploadTask =
        profileProvider.uploadImageFile(avatarImageFile!, fileName);

    try {
      TaskSnapshot snapshot = await uploadTask;
      photoUrl = await snapshot.ref.getDownloadURL();
      ChatUser updateInfo = ChatUser(
        id: id,
        photoUrl: photoUrl,
        displayName: displayName,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe,
      );

      await profileProvider.updateFirestoreData(
          FirestoreConstants.pathUserCollection, id, updateInfo.toJson());
      await profileProvider.setPrefs(FirestoreConstants.photoUrl, photoUrl);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void updateFirestoreData() async {
    focusNodeNickname.unfocus();
    setState(() {
      isLoading = true;
      if (dialCodeDigits != '+00' && phoneController.text.isNotEmpty) {
        phoneNumber = dialCodeDigits + phoneController.text;
      }
    });

    ChatUser updateInfo = ChatUser(
      id: id,
      photoUrl: photoUrl,
      displayName: displayName,
      phoneNumber: phoneNumber,
      aboutMe: aboutMe,
    );

    try {
      await profileProvider.updateFirestoreData(
          FirestoreConstants.pathUserCollection, id, updateInfo.toJson());
      await profileProvider.setPrefs(
          FirestoreConstants.displayName, displayName);
      await profileProvider.setPrefs(
          FirestoreConstants.phoneNumber, phoneNumber);
      await profileProvider.setPrefs(FirestoreConstants.photoUrl, photoUrl);
      await profileProvider.setPrefs(FirestoreConstants.aboutMe, aboutMe);

      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: 'Update Success');
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  late AuthProvider authProvider;

  Future<void> googleSignOut() async {
    authProvider = context.read<AuthProvider>();
    authProvider.googleSignOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigationBarWidget()),
              (route) => false),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: TextButton(
                  onPressed: googleSignOut,
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ))
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AvatarImage(
                  getImage: getImage,
                  avatarImageFile: avatarImageFile,
                  photoUrl: photoUrl,
                ),
                Center(
                  child: Text(
                    displayName,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(height: 20),
                ProfileFormField(
                  label: 'Name',
                  hintText: 'Write your Name',
                  controller: displayNameController,
                  onChanged: (value) {
                    displayName = value;
                  },
                  focusNode: focusNodeNickname,
                ),
                vertical10,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SelectCountryCode(
                        onChanged: (country) {
                          setState(() {
                            dialCodeDigits = country.dialCode!;
                          });
                        },
                      ),
                    ),
                    horizontal10,
                    Expanded(
                      flex: 2,
                      child: ProfileFormField(
                        label: 'Phone Number',
                        hintText: 'Phone Number',
                        prefix: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            dialCodeDigits,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                      ),
                    ),
                  ],
                ),
                vertical10,
                ProfileFormField(
                  label: 'About Me...',
                  hintText: 'Write about yourself...',
                  controller: aboutMeController,
                  onChanged: (value) {
                    aboutMe = value;
                  },
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          if (isLoading)
            const Positioned.fill(
              child: LoadingView(),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: updateFirestoreData,
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Update Info',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
