import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/constants.dart';
import 'package:news_application/cubit/home_cubit.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/screens/appBarWidget.dart';
import 'package:news_application/screens/drawerWidget.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) =>
        ArticlesHomeCubit()..checkAndInsertNotificationToken()..getArticles()..getCategories(),
        child: BlocConsumer<ArticlesHomeCubit, ArticlesLoadingStates>(
        listener: (context, state) {
          var cubit = ArticlesHomeCubit.get(context);
          if(state is LoadingSuccessState && cubit.nextPageUrl != null)
          {
            cubit.getArticles();
          }
        },
        builder: (context, state) {
          var cubit = ArticlesHomeCubit.get(context);
          return Scaffold(
            appBar: AppBarWidget(),
            drawer: DrawerWidget(),
            body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (cubit.news.length == 0) ? Center(
                    child: CircularProgressIndicator()) :
                   ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: cubit.news.length,
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: (){
                              Navigator.of(context).pushNamed('/article',
                                  arguments: cubit.news[index]['id'].toString()
                              );
                          },
                          child: Column(
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
                                  itemCount: cubit.news[index]['categories'].length,
                                  itemBuilder: (BuildContext context, index2) =>
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          cubit.news[index]['categories'][index2]['name'],
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
                                child: Image.network(Constants.api_url+'images/'+cubit.news[index]['image_url']),
                              ),
                              Text(cubit.news[index]['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.titleFontSize,
                                ),
                              ),
                              Text(cubit.news[index]['description'],
                                style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontSize: Constants.subTitleFontSize
                                ),
                              ),
                              SizedBox(height: 25.0,)
                            ],
                          ),
                        );
                      }
                  ),
                )
          );
        }
      )
    );
  }
}

