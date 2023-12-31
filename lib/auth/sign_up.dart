import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_in.dart';
import 'package:food_app/constants/constants.dart';
import 'package:food_app/firebase/firebase_auth_helper.dart';
import 'package:food_app/screen/bottom_bar.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:food_app/widgets/top_titles.dart';

import '../constants/routes.dart';
import '../widgets/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  bool isShowPassword = true;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  title: 'Create account', subtitle: 'Welcome to iCart'),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.password_sharp),
                    suffixIcon: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        padding: EdgeInsets.zero,
                        child: Icon(
                          isShowPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ))),
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                title: 'Sign Up',
                onPressed: () async {
                  bool isValidated = signUpValidation(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      _phoneController.text);
                  if (isValidated) {
                    bool isLogined = await AuthenticationProvider()
                        .signUpWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text,
                            _phoneController.text,
                            context);
                    if (isLogined) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: const BottomBar(), context: context);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Center(child: SmallText(text: "Already a member of iCart?")),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Routes.instance
                      .push(widget: const SignInPage(), context: context);
                },
                child: Center(
                    child: SmallText(
                  text: 'Login',
                  size: 17,
                  color: Colors.blue,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
