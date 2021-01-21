import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../services/services.dart';
import './screens.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final shoeSizeController;

  var message;

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hello Please Register '),
            Container(
              width: screenSize.width * .85,
              child: Column(
                children: [
                  InputForm(firstNameController, "First Name", Icons.email),
                  SizedBox(height: statusBarHeight),
                  InputForm(lastNameController, "Last Name", Icons.lock),
                  SizedBox(height: statusBarHeight),
                  InputForm(emailController, "Email", Icons.email),
                  SizedBox(height: statusBarHeight),
                  InputForm(passwordController, "Password", Icons.lock),
                  // SizedBox(height: statusBarHeight),
                  // InputForm(passwordController, "Password", Icons.lock),
                  RaisedButton(
                    onPressed: () async {
                      message = await context.read<Authentication>().signUp(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          password: passwordController.text);

                      if (message is bool && message) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => TabScreen()),
                        );
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  Row(
                    children: <Widget>[
                      Text("Already Registered? Please"),
                      FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text('Login'))
                    ],
                  ),
                  ShowMessage(message)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
