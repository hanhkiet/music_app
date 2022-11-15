import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/sign/sign_controller.dart';
import 'package:music_app/screens/sign/sign_up/sign_up_controller.dart';

class SignUpSection extends GetView<SignUpController> {
  const SignUpSection({
    Key? key,
    required this.updateScreen,
  }) : super(key: key);

  final Function updateScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Sign up',
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            TextButton(
              onPressed: () => updateScreen(Screen.signin),
              child: const Text(
                'Sign in',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 70,
                      child: buildEmailField(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 70,
                      child: buildPasswordField(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Re-enter password',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 70,
                      child: buildReenterPasswordField(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Center(
                    child: controller.hasError.value
                        ? Text(controller.message.value)
                        : Container(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: buildSignUpButton(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signUp(
        controller.emailText,
        controller.passwordText,
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.black45,
      ),
      child: Text(
        'Sign up',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  _signUp(String email, String password) {}

  Widget buildEmailField() {
    return TextFormField(
      controller: controller.emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email!';
        } else if (!value.isEmail) {
          return 'Incorrect email!';
        }

        return null;
      },
      style: const TextStyle(fontSize: 20),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: controller.passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password!';
        }

        if (value.length < 6) {
          return 'Password length is at least 6 characters';
        }

        return null;
      },
      style: const TextStyle(fontSize: 20),
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      obscureText: true,
      decoration: const InputDecoration(
        suffixIcon: Icon(
          Icons.visibility,
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildReenterPasswordField() {
    return TextFormField(
      controller: controller.passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password!';
        }

        if (value.length < 6) {
          return 'Password length is at least 6 characters';
        }

        return null;
      },
      style: const TextStyle(fontSize: 20),
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      obscureText: true,
      decoration: const InputDecoration(
        suffixIcon: Icon(
          Icons.visibility,
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
