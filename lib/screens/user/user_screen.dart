import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:music_app/screens/user/user_controller.dart';
import 'package:music_app/services/firebase_auth.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 0, 150, 158).withOpacity(.8),
              const Color.fromARGB(255, 0, 242, 255).withOpacity(.8),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: AuthService.authStateChanges,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const NotSignedUserWidget();
            }

            return const SignedUserWidget();
          },
        ),
      ),
    );
  }
}

class NotSignedUserWidget extends StatelessWidget {
  const NotSignedUserWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .15,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _showSignInDialog(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                'Sign in',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: const Color.fromARGB(255, 0, 150, 158),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSignInDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return const SignInDialog();
        },
      );
}

class SignedUserWidget extends StatelessWidget {
  const SignedUserWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser!;

    return Center(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          children: [
            Text(user.uid),
            const SizedBox(height: 10),
            Text(user.displayName ?? ''),
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () => _showSignOutDialog(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                'Log out',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: const Color.fromARGB(255, 0, 150, 158),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return const SignOutDialog();
        },
      );
}

class SignInDialog extends StatelessWidget {
  const SignInDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Navigator.pop(context);
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'username',
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Password',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'password',
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () => AuthService.signInWithEmailAndPassword(
                        email: 'abcd@gmail.com',
                        password: '123456',
                      ),
                      child: const Text(
                        'log in',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('google'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('facebook'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Do you want to sign out?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            AuthService.signOut();
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        shape: const StadiumBorder(),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.white),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}
