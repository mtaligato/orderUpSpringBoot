import 'package:flutter/material.dart';
import 'package:food_ordering/extension/widget_extension.dart';
import 'package:food_ordering/provider/firebase_auth_provider.dart';
import 'package:food_ordering/ui/menu_edit_page.dart';
import 'package:food_ordering/ui/sign_up_page.dart';

class SignInOwnerPage extends StatefulWidget {
  @override
  _SignInOwnerPageState createState() => _SignInOwnerPageState();
}

class _SignInOwnerPageState extends State<SignInOwnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Username'),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  AuthProvider.signInOwner(email: 'georgefung78@live.com', password: 'fjq110388').then((value) {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MenuEditPage()));
                  });
                },
                child: Container(
                  height: 36,
                  child: Center(
                    child: Text('Sign In'),
                  ),
                ),
              ).padding(horizontal: 24),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage())),
                child: Container(
                  height: 36,
                  child: Center(
                    child: Text('Sign Up'),
                  ),
                ),
              ).padding(horizontal: 24),
            ],
          ),
        ));
  }
}
