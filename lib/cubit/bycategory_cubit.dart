import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/dio_helper.dart';

class ArticlesByCategoryCubit extends Cubit<ArticlesLoadingStates> {

  ArticlesByCategoryCubit() : super(InitialState());

  static ArticlesByCategoryCubit get(context) => BlocProvider.of(context);

  List news = [];
  int currentPage = 1;
  String nextPageUrl;
  List categories = [];

  void getCategories(){
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categories = value.data;
    }).catchError((error) => print(error));
  }

  void getArticles(int category) {
    emit(LoadingState());
    DioHelper.getData(
        url: 'articles/byCategory/$category',
        query: { 'page': currentPage.toString() }
    ).then((value) {
      nextPageUrl = value.data['next_page_url'];
      news.addAll(value.data['data']);
      currentPage++;
      emit(LoadingSuccessState());
    }).catchError((error) => emit(LoadingErrorState(error)));
  }
}