import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_app/const.dart';

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
  double shoeSize;

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
                  SizedBox(height: statusBarHeight),
                  Container(
                    width: screenSize.width * .9,
                    height: screenSize.height * .075,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              style: BorderStyle.solid, color: Colors.grey),
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownButton(
                          underline: Container(),
                          isExpanded: true,
                          hint: Text('Select Your Shoe Size'),
                          value: shoeSize,
                          focusColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            setState(() => shoeSize = value);
                          },
                          items: menSizes.map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text('$size'),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      message = await context.read<Authentication>().signUp(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          size: shoeSize);

                      if (message is bool && message) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => TabScreen()),
                        );
                      }
                      // if (message is String) {
                      // print('should show snackbar');
                      // final snackBar = SnackBar(content: Text('message'));
                      // Scaffold.of(context).showSnackBar(snackBar);
                      // }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text("Already Registered? Please"),
                      TextButton(
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
