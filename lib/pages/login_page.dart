import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatelessWidget {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          EasyLoading.show(status: 'Loading..');
        } else if (state is LoginSuccess) {
          EasyLoading.dismiss();
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.popAndPushNamed(
            context,
            'ChatPage',
            arguments: email,
          );

          ShowSnackbar(context, 'Logged in successfully');
        } else if (state is LoginFailure) {
          EasyLoading.dismiss();
          ShowSnackbar(context, state.exeptionMessage!);
        }
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image.asset('assets/images/scholar.png',
                    height: MediaQuery.of(context).size.height * 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Scholar Chat',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'Pacifico')),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Text('Sign In',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hitText: 'Email',
                  onChanged: ((data) {
                    email = data;
                  }),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hitText: 'Password',
                  onChanged: ((data) {
                    password = data;
                  }),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onTap: (() async {
                    if (formKey.currentState!.validate()) {
                      await BlocProvider.of<LoginCubit>(context)
                          .LoginUser(email: email, password: password);
                    }
                  }),
                  title: 'Sign In',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      child: Text(
                        '  Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Navigator.pushReplacementNamed(context, LoginPage.id);
                        Navigator.pushNamed(context, 'RegistrtPage');
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ShowSnackbar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
