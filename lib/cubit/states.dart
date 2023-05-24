abstract class ArticlesLoadingStates {}

class InitialState extends ArticlesLoadingStates {}

class LoadingState extends ArticlesLoadingStates {}

class LoadingSuccessState extends ArticlesLoadingStates {}

class LoadingErrorState extends ArticlesLoadingStates {

  final String error;

  LoadingErrorState(this.error);
}