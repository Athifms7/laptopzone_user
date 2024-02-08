// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/services/firebase/firebase_authentication.dart';
import 'package:laptopzone_user/view/auth_screen/login.dart';
import 'package:laptopzone_user/view/auth_screen/widgets/signupfields.dart';
import 'package:laptopzone_user/view/cart_screen/checkout_screen.dart';
import 'package:laptopzone_user/view/navigation/navigation_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // final FirebaseAuthentication _auth = FirebaseAuthentication();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'Create a new account',
                style: TextStyle(
                    fontSize: height * 0.04, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: width * 0.59,
              height: height * 0.27,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/create_account.jpg'))),
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  SignupFields(
                    controller: _usernameController,
                    title: 'Name',
                    hint: 'Enter your Name',
                  ),
                  SignupFields(
                      controller: _emailController,
                      title: 'E-mail',
                      hint: 'Enter Your Email'),
                  // SignupFields(
                  //     controller: phoneController,
                  //     title: 'Phone Number',
                  //     hint: 'Enter Your Number'),
                  SignupFields(
                      controller: _passwordController,
                      title: 'Password',
                      hint: 'Enter your Password',
                      isSuffix: true),
                  SignupFields(
                    controller: _confirmPasswordController,
                    title: 'Confirm Password',
                    hint: 'Re-Enter Password',
                    isSuffix: true,
                  ),
                ],
              ),
            ),
            SizedBox(
                width: width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    // _signUp();
                    if (_passwordController.text ==
                        _confirmPasswordController.text) {
                      if (formkey.currentState!.validate()) {
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          Get.dialog(Center(
                            child: LoadingAnimationWidget.waveDots(
                                color: Colors.white, size: 50),
                          ));
                          FirebaseAuthentication()
                              .signUpWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                            _usernameController.text,
                            // phoneController.text
                          )
                              .then((success) {
                            if (success) {
                              Get.offAll(const NavBar());
                            } else {
                              Get.snackbar(
                                  'Error', 'Invalid email or password');
                            }
                          });
                        }
                      }
                    } else {
                      // snack(context,
                      //     message: "Enter same password", color: Colors.red);
                    }
                  },
                 
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Set the background color to black
                  ),
                   child:const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white), // Set the text color to white
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>const LoginScreen(),
                            ),
                            (route) => false);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

// Padding textformfield(String name, TextEditingController controller) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//           labelStyle: TextStyle(color: Colors.black),
//           labelText: name,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
//     ),
//   );
// }
