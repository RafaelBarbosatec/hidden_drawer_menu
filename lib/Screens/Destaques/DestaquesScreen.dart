import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/Screens/Destaques/DestaquesBloc.dart';
import 'package:hidden_drawer_menu/model/Notice.dart';
import 'package:hidden_drawer_menu/supporte/BlocProvider.dart';

class DestaquesScreen extends StatelessWidget {

  DestaquesBloc bloc;

  static Widget create(){

    return BlocProvider<DestaquesBloc>(
      bloc: DestaquesBloc(),
      child: DestaquesScreen(),
    );

  }

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of<DestaquesBloc>(context);

    bloc.loadNews();

    return Stack(
      children: <Widget>[
        Container(
          child: _buildList(bloc),
        ),
        _buildProgress(bloc)
      ],

    );

  }

  Widget _buildProgress(DestaquesBloc bloc){

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

  _buildList(DestaquesBloc bloc) {

    return StreamBuilder(
      stream: bloc.listController.stream,
      initialData: List(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index){

            Notice n = snapshot.data[index];
            return n.getViewSpotlight();

          },
        );
      },
    );
  }

}

