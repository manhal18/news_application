import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticlesHomeCubit extends Cubit<ArticlesLoadingStates> {

  ArticlesHomeCubit() : super(InitialState());

  static ArticlesHomeCubit get(context) => BlocProvider.of(context);

  String token;
  List news = [];
  List categories = [];
  int currentPage = 1;
  String nextPageUrl;

  void getCategories(){
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categories = value.data;
    }).catchError((error) => print(error));
  }

  void getArticles() {
    emit(LoadingState());
    DioHelper.getData(
        url: 'articles',
        query: { 'page': currentPage.toString() }
    ).then((value) {
      nextPageUrl = value.data['next_page_url'];
      news.addAll(value.data['data']);
      currentPage++;
      emit(LoadingSuccessState());
    }).catchError((error) => emit(LoadingErrorState(error)));
  }

  Future refresh () async{
    print('bus');
  }

  void checkAndInsertNotificationToken() async{
    await FirebaseMessaging().getToken().then((value) {
      token = value;
    }).then((_) async{
      DioHelper.getData(
          url: 'tokens/checkToken/$token',
      ).then((value) {
        if(value.data == 0){
            insertNotificationToken();
          }
      });
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // if(prefs.containsKey('api_token') == false){
      //   insertNotificationToken();
      // }
    });
  }

  insertNotificationToken() async{
    var response = await DioHelper.insertData(url: 'tokens', token: token);
    if(response.statusCode == 200){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('api_token', response.data['token']);
    }
  }
}