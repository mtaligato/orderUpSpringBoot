import 'package:flutter/material.dart';
import 'package:food_ordering/ui/menu_page.dart';
import 'package:food_ordering/ui/sign_in_owner_page.dart';

///This is the page where user choose whether to proceed as a customer or an restaurant owner.
class SignInSelectionPage extends StatefulWidget {
  @override
  _SignInSelectionPageState createState() => _SignInSelectionPageState();
}

class _SignInSelectionPageState extends State<SignInSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MenuPage()));
              },
              child: Container(
                width: 128,
                height: 48,
                child: Center(
                  child: Text(
                    'Customer',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignInOwnerPage())),
              child: Container(
                width: 128,
                child: Center(
                  child: Text('Restaurant Owner'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
