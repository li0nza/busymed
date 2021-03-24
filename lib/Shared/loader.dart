import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Theme.of(context).primaryColor,
    ));
  }
}
