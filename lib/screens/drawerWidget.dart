import 'package:flutter/material.dart';

import '../constants.dart';
import '../dio_helper.dart';

class DrawerWidget extends StatefulWidget with PreferredSizeWidget {
  @override
  _DrawerWidget createState() => _DrawerWidget();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _DrawerWidget extends State<DrawerWidget> {
  List categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      setState(() {
        categories = value.data;
      });
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) =>
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/articles/byCategory',
                        arguments: categories[index]['id']);
                  },
                  child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0, color: Constants.primaryColor),
                        ),
                      ),
                      child: Text(
                        categories[index]['name'],
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      )
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
