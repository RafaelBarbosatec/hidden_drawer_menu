import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/Screens/Tecnologia/TecnologiaBloc.dart';
import 'package:hidden_drawer_menu/model/Notice.dart';
import 'package:hidden_drawer_menu/supporte/BlocProvider.dart';

class TecnologiaScreen extends StatelessWidget {

  TecnologiaBloc bloc;

  static Widget create(){

    return BlocProvider<TecnologiaBloc>(
      bloc: TecnologiaBloc(),
      child: TecnologiaScreen(),
    );

  }

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of<TecnologiaBloc>(context);

    bloc.loadNewsTecnology();

    return Stack(
      children: <Widget>[
        Container(
          child: _buildList(bloc),
        ),
        _buildProgress(bloc)
      ],

    );

  }

  Widget _buildProgress(TecnologiaBloc bloc){

    return StreamBuilder(
      stream: bloc.progressController.stream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return snapshot.data ? new Container(
            child: Center(child: new CircularProgressIndicator())
        ) : new Container();
      },
    );

  }

  _buildList(TecnologiaBloc bloc) {

    return StreamBuilder(
      stream: bloc.listController.stream,
      initialData: List(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index){

            Notice n = snapshot.data[index];
            return n.getViewNormal();

          },
        );
      },
    );
  }

}
