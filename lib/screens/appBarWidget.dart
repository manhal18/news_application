import 'package:flutter/material.dart';
import '../constants.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'News App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Constants.titleFontSize,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
