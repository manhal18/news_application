import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/bycategory_cubit.dart';
import 'package:news_application/cubit/states.dart';
import '../constants.dart';
import 'appBarWidget.dart';
import 'drawerWidget.dart';

class ArticlesByCategory extends StatelessWidget {
  final int id;

  ArticlesByCategory({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ArticlesByCategoryCubit()
          ..getArticles(id)
          ..getCategories(),
        child: BlocConsumer<ArticlesByCategoryCubit, ArticlesLoadingStates>(
            listener: (context, state) {
          var cubit = ArticlesByCategoryCubit.get(context);
          if (state is LoadingSuccessState && cubit.nextPageUrl != null) {
            cubit.getArticles(id);
          }
        }, builder: (context, state) {
          var cubit = ArticlesByCategoryCubit.get(context);
          return Scaffold(
            appBar: AppBarWidget(),
            drawer: DrawerWidget(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: (cubit.news.length == 0)
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: cubit.news.length,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/article',
                                    arguments:
                                        cubit.news[index]['id'].toString());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: Image.network(
                                        Constants.api_url+'images/'+cubit.news[index]['image_url']),
                                  ),
                                  Text(
                                    cubit.news[index]['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constants.titleFontSize,
                                    ),
                                  ),
                                  Text(
                                    cubit.news[index]['description'],
                                    style: TextStyle(
                                        color: Colors.blueGrey[800],
                                        fontSize: Constants.subTitleFontSize),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
            ),
          );
        }
      )
    );
  }
}
