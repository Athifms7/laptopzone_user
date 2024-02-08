import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/services/firebase/firebase_authentication.dart';
import 'package:laptopzone_user/view/auth_screen/create_account.dart';
import 'package:laptopzone_user/view/auth_screen/widgets/loginbuttonwidget.dart';
import 'package:laptopzone_user/view/auth_screen/widgets/loginfields.dart';
import 'package:laptopzone_user/view/navigation/navigation_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        toolbarHeight: height * 0.10,
        title: Center(
          child: Image.asset(
            'assets/images/laptopzone-high-resolution-logo-transparent.png',
            width: width * 0.500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: height * 0.04, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: width * 0.59,
            height: height * 0.3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login.jpg'))),
          ),
          Form(
            key: formkey,
            child: Column(
              children: [
                LoginFields(
                  controller: mailController,
                  title: 'E-mail',
                  hint: 'Enter your Email',
                ),
                LoginFields(
                    controller: passwordController,
                    title: 'Password',
                    hint: 'Enter your Password',
                    isSuffix: true),
              ],
            ),
          ),
         const SizedBox(
            height: 15,
          ),
          LoginBottonWidget(
            title: 'Sign In',
            onPressed: () {
              if (formkey.currentState!.validate()) {
                if (mailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  Get.dialog(Center(
                    child: LoadingAnimationWidget.waveDots(
                        color: Colors.white, size: 50),
                  ));
                  FirebaseAuthentication()
                      .signInWithEmailAndPassword(
                          mailController.text, passwordController.text)
                      .then((success) {
                    if (success) {
                      Get.offAll(const NavBar());
                    } else {
                      Get.snackbar('Error', 'Invalid email or password');
                    }
                  });
                }
              }
            },
          ),
          const Text(
            'or',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          LoginBottonWidget(
            title: 'Continue with Google',
            onPressed: () async {
              UserCredential cred =
                  await FirebaseAuthentication().signInWithGoogle();

              if (cred != null) {
                Get.to(const NavBar());
              } else {
                Get.snackbar('error', 'User null');
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  'Don\'t have account?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>const CreateAccountScreen(),
                          ),
                          (route) => false);
                    },
                    child: const Text(
                      'Create account',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }

  SizedBox loginButton(double width, String name, Widget className) {
    return SizedBox(
        width: width * 0.5,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => className,
                ));
          },
          child: Text(
            name,
            style:
             const   TextStyle(color: Colors.white), // Set the text color to white
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.black), // Set the background color to black
          ),
        ));
  }
}
