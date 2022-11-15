import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/user/user_controller.dart';
import 'package:music_app/services/firebase_auth.dart';
import 'package:music_app/widgets/background.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: StreamBuilder(
            stream: AuthService.authStateChanges,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return OutlinedButton(
                  onPressed: () async {
                    await Get.toNamed('sign');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Sign in',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                );
              }

              return OutlinedButton(
                onPressed: () => AuthService.signOut(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.white,
                  ),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'Sign out',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: 18,
                      ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
