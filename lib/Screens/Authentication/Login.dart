import 'package:flutter/material.dart';
import 'package:news_app/Screens/Authentication/SignUp.dart';
import 'package:news_app/util/Utilities.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.appBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            Container(
              margin: const EdgeInsets.only(left: 12),
              child: Text("LoginPage", style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColorsLight.textColor
              ),),),
            SizedBox(
              height: MediaQuery.of(context).size.height *0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                cursorColor: AppColorsLight.textColor,
                cursorHeight: 18,
                controller: _emailController,
                decoration:  InputDecoration(labelText: 'Email', iconColor: AppColorsLight.textColor, 
                labelStyle: TextStyle(color: AppColorsLight.textColor),
                focusColor: AppColorsLight.categoryCards, // Define the color of the pointer when focused
                hoverColor: AppColorsLight.categoryCards,
                contentPadding: const EdgeInsets.only(bottom: 1.0),
                border:  UnderlineInputBorder( // Define the border for the default state
                  borderSide: BorderSide(color: AppColorsLight.textColor), // Define the color and width of the border
                ),
                focusedBorder:  UnderlineInputBorder( // Define the border for the focused state
                  borderSide: BorderSide(color: AppColorsLight.textColor), // Change the color of the bottom border when focused
                ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                cursorColor: AppColorsLight.textColor,
                cursorHeight: 18,
                obscureText: true,
                controller: _emailController,
                decoration:  InputDecoration(labelText: 'Password', iconColor: AppColorsLight.textColor, 
                labelStyle: TextStyle(color: AppColorsLight.textColor),
                focusColor: AppColorsLight.categoryCards, // Define the color of the pointer when focused
                hoverColor: AppColorsLight.categoryCards,
                contentPadding: const EdgeInsets.only(bottom: 1.0),
                border:  UnderlineInputBorder( // Define the border for the default state
                  borderSide: BorderSide(color: AppColorsLight.textColor), // Define the color and width of the border
                ),
                focusedBorder:  UnderlineInputBorder( // Define the border for the focused state
                  borderSide: BorderSide(color: AppColorsLight.textColor), // Change the color of the bottom border when focused
                ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.1,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Implement your signup logic here
                  // For example, you can validate the inputs and send them to your backend server
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  // Validate the input fields
                  if (email.isEmpty || password.isEmpty) {
                    // Show an error message if any field is empty
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill all fields'),
                    ));
                    return;
                  }
                  // If all validations pass, you can proceed with signup
                  // Here you can call your signup API or perform any other action
                  // For simplicity, let's just print the email and password
                  print('Email: $email, Password: $password');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColorsLight.appBackground, // Background color
                  backgroundColor: AppColorsLight.categoryCards, // Text color
                  padding: const EdgeInsets.symmetric(vertical: 26.0), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0), // Button border radius
                  ),
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500), // Button text style
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height *0.15,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupPage()));
                },
                child: RichText(
                  text: TextSpan(
                    text: "Dont have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      // color: AppColorsLight.textColor, // Color for the non-clickable text
                      fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColorsLight.categoryCards, // Color for the clickable text
                          fontWeight: FontWeight.bold,
                          fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}
