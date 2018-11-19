import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/model/Book.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> books = new List();

  @override
  void initState() {
    Book b = new Book(
        "Edgar Allan Poe - Col. Medo Clássico",
        "26 de Janeiro de 2017",
        "http://images.livrariasaraiva.com.br/imagemnet/imagem.aspx/?pro_id=9412952&a=-1&qld=90&l=190",
        "Edgar Allan Poe: Medo Clássico” é uma homenagem ao mestre da literatura fantástica em todos os detalhes: da capa dura à tradução primorosa, além das belíssimas xilogravuras do artista gráfico Ramon Rodrigues. Pela primeira vez, os contos de Poe estão divididos por temas que ajudam a visualizar a grandeza de sua obra:"
    );

    books.add(b);
    books.add(b);
    books.add(b);
    books.add(b);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView(
        children: books,
      ),
    );

  }
}
