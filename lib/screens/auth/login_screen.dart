import 'package:chat/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../constants/index.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in cancelled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in successful');
        break;
      default:
        break;
    }

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.px,
            ),
            children: [
              Center(
                child: Image.asset('assets/images/auth.png'),
              ),
              vertical50,
              Text(
                'Blackout',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              vertical10,
              Text(
                'Sign in to continue',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              vertical50,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MaterialButton(
                  height: 50.0,
                  minWidth: double.infinity,
                  color: AppColors.appBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: 30.0,
                      ),
                      horizontal10,
                      Text(
                        'Sign in with Google',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    bool isSuccess = await authProvider.handleGoogleSignIn();
                    if (isSuccess) {
                      _navigateToHome();
                    }
                  },
                ),
              ),
            ],
          ),
          Center(
            child: authProvider.status == Status.authenticating
                ? const CircularProgressIndicator(
                    color: AppColors.lightGrey,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    ));
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigationBarWidget()));
  }
}
