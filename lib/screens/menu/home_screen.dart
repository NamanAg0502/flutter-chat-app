import 'dart:async';
import 'dart:io';
import 'package:chat/widgets/home/chat_user_item.dart';
import 'package:chat/widgets/home/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../constants/index.dart';
import '../../providers/auth_provider.dart';
import '../../providers/home_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/debouncer.dart';
import '../../widgets/loading_widget.dart';
import '../auth/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController scrollController = ScrollController();
  String photoUrl = '';
  String displayName = '';

  int _limit = 20;
  final int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;
  late ProfileProvider profileProvider;

  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> buttonClearController = StreamController<bool>();
  TextEditingController searchTextEditingController = TextEditingController();

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  void readLocal() {
    photoUrl = profileProvider.getPrefs(FirestoreConstants.photoUrl) ?? '';
    displayName =
        profileProvider.getPrefs(FirestoreConstants.displayName) ?? '';

    setState(() {});
  }

  Future<void> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            backgroundColor: AppColors.appBg2,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exit Application',
                  style: TextStyle(color: AppColors.white),
                ),
                Icon(
                  Icons.exit_to_app,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.dimen_10),
            ),
            children: [
              vertical10,
              const Text(
                'Are you sure?',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: AppColors.white, fontSize: Sizes.dimen_16),
              ),
              vertical15,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 0);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(Sizes.dimen_8),
                      ),
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: AppColors.spaceCadet),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
    }
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    buttonClearController.close();
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();
    profileProvider = context.read<ProfileProvider>();

    if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
      currentUserId = authProvider.getFirebaseUserId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }

    scrollController.addListener(scrollListener);
    readLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: Sizes.dimen_10),
              child: const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.appText,
              ),
            )
          ],
          toolbarHeight: 60,
          title: SizedBox(
              child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(photoUrl), fit: BoxFit.cover),
                ),
              ),
              horizontal10,
              Text(
                displayName,
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: Sizes.dimen_20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
        ),
        // bottomNavigationBar: const BottomNavigationBarWidget(),
        body: WillPopScope(
          onWillPop: onBackPress,
          child: Stack(
            children: [
              Column(
                children: [
                  CustomSearchBar(
                    searchTextEditingController: searchTextEditingController,
                    buttonClearStream: buttonClearController.stream,
                    onTextChanged: (value) {
                      if (value.isNotEmpty) {
                        buttonClearController.add(true);
                        setState(() {
                          _textSearch = value;
                        });
                      } else {
                        buttonClearController.add(false);
                        setState(() {
                          _textSearch = "";
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: homeProvider.getFirestoreData(
                          FirestoreConstants.pathUserCollection,
                          _limit,
                          _textSearch),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if ((snapshot.data?.docs.length ?? 0) > 0) {
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => ChatItemWidget(
                                  currentUserId: currentUserId,
                                  documentSnapshot: snapshot.data?.docs[index]),
                              controller: scrollController,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                height: 1,
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text('No user found...'),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                child:
                    isLoading ? const LoadingView() : const SizedBox.shrink(),
              ),
            ],
          ),
        ));
  }
}
