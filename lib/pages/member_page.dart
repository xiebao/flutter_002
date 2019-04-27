import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Provide<Counter>(
                builder: (context, child, counter) {
                  return Text(
                    '${counter.value}',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              ),
              RaisedButton(
                onPressed: () {
                  Provide.value<Counter>(context).increment();
                },
                child: Text("添加"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
