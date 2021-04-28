import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/extension/widget_extension.dart';
import 'package:food_ordering/provider/firebase_auth_provider.dart';

import 'menu_edit_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool signingUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: signingUp
            ? StreamBuilder(
                stream: AuthProvider.instance.authStateChanges(),
                builder: (_, AsyncSnapshot<User> snapshot) {
                  print(snapshot);
                  if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(fontSize: 64),
                        ).padding(vertical: 36),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MenuEditPage()));
                          },
                          child: Container(
                            height: 36,
                            child: Center(
                              child: Text('Create Menu'),
                            ),
                          ),
                        ).padding(horizontal: 24).constrained(maxWidth: 480),
                      ],
                    );
                  }
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                  ).padding(horizontal: 24).constrained(maxWidth: 480),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Username'),
                  ).padding(horizontal: 24).constrained(maxWidth: 480),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Entity Name'),
                  ).padding(horizontal: 24).constrained(maxWidth: 480),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Entity Address'),
                  ).padding(horizontal: 24).constrained(maxWidth: 480),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ).padding(horizontal: 24).constrained(maxWidth: 480),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ).padding(horizontal: 24).constrained(maxWidth: 480),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        signingUp = true;
                      });

                      AuthProvider.signInOwner(email: 'georgefung78@live.com', password: 'fjq110388');
                    },
                    child: Container(
                      height: 36,
                      child: Center(
                        child: Text('Sign Up'),
                      ),
                    ),
                  ).padding(horizontal: 24).constrained(maxWidth: 480),
                ],
              ),
      ),
    );
  }
}
