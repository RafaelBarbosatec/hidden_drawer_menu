
import 'dart:async';

import 'package:hidden_drawer_menu/connection/Api.dart';
import 'package:hidden_drawer_menu/repository/NewsRepository.dart';
import 'package:hidden_drawer_menu/supporte/BlocProvider.dart';

class TecnologiaBloc implements BlocBase{

  NewsRepository _repository = new NewsRepository();

  StreamController<List> listController;
  StreamController<bool> progressController;
  int _page = 0;

  bool _carregando = false;

  void loadNewsTecnology() async{

    changeProgress(true);

    _repository.getNewsTechbology(_page)
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