
import 'dart:async';
import 'package:hidden_drawer_menu/connection/Api.dart';
import 'package:hidden_drawer_menu/repository/NewsRepository.dart';
import 'package:hidden_drawer_menu/supporte/BlocProvider.dart';

class DestaquesBloc implements BlocBase{

  NewsRepository _repository = new NewsRepository();

  StreamController<List> listController;
  StreamController<bool> progressController;

  bool _carregando = false;

  void loadNews() async{

    changeProgress(true);

    _repository.getNews()
        .then((list) {

          listController.sink.add(list);
          changeProgress(false);

        })
        .catchError((onError) {

          print(onError);

          if(onError is FetchDataException){
            print("codigo: ${onError.code()}");
          }

          changeProgress(false);

        });

  }

  void changeProgress(bool show){
    _carregando = show;
    progressController.sink.add(_carregando);
  }

  @override
  void didChangeDependencies() {
  }

  @override
  void dispose() {
    progressController.close();
    listController.close();
  }

  @override
  void initState() {
    listController = StreamController<List>();
    progressController = StreamController<bool>();
  }

}