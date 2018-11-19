
import 'package:hidden_drawer_menu/connection/Api.dart';
import 'package:hidden_drawer_menu/model/Notice.dart';

class NewsRepository{

  Api _api;

  NewsRepository(){
    _api = Api("http://104.131.18.84/notice/news/");
  }

  Future<List<Notice>> getNewsTechbology(int page) async{

    final Map response = await _api.get("technology/$page");

    return response["news"].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();

  }

  Future<List<Notice>> getNews() async{

    final Map response = await _api.get("recent");

    return response["data"].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();

  }

}