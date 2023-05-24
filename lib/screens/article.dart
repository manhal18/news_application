import 'package:flutter/material.dart';

import '../constants.dart';
import '../dio_helper.dart';
import 'appBarWidget.dart';
import 'drawerWidget.dart';

class ArticleScreen extends StatefulWidget {

  final id;
  //ArticleScreen(this.id);
  ArticleScreen({
    Key key,
    @required this.id,
  }):super(key:key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String id;
  Map<String, dynamic> articleData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    id = widget.id;

    DioHelper.getData(
      url: 'articles/$id',
    ).then((value) {
      setState(() {
        articleData = value.data;
      });
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: (articleData == null)
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Container(
                            height: 30,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    width: 5.0, color: Constants.primaryColor),
                              ),
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: articleData['categories'].length,
                              itemBuilder: (BuildContext context, index) =>
                                  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  articleData['categories'][index],
                                  style: TextStyle(
                                    fontSize: Constants.fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Image.network(Constants.api_url+"images/"+articleData['article']['image_url']),
                          ),
                          Text(
                            articleData['article']['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Constants.titleFontSize,
                            ),
                          ),
                          Text(
                            articleData['article']['description'],
                            style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: Constants.subTitleFontSize),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            articleData['article']['body'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Constants.fontSize),
                          ),
                        ])),
        ));
  }
}
