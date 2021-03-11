import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:email_validator/email_validator.dart';

import '../widgets/widgets.dart';
import '../services/services.dart';
import './screens.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var message;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Hello Please Login'),
              Container(
                width: screenSize.width * .85,
                child: Column(
                  children: [
                    InputForm(emailController, "Email", Icons.email),
                    SizedBox(height: screenSize.height * .04),
                    InputForm(passwordController, "Password", Icons.lock),
                    ElevatedButton(
                      onPressed: () async {
                        message = await context.read<Authentication>().signIn(
                            email: emailController.text,
                            password: passwordController.text);

                        if (message is bool && message) {
                          print('THE MESSAGE IS TRUWE');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabScreen()),
                          );
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text("Need to sign up?"),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                          ),
                        )
                      ],
                    ),
                    ShowMessage(message)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
