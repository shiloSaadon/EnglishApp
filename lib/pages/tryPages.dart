import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino back gesture'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Push other page'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return OtherPage();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other page'),
      ),
      body: Center(
        child: Text('Try to swipe back'),
      ),
    );
  }
}
