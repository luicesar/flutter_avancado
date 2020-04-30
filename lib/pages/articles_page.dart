import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Artigos'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Avançar'),
          onPressed: () {
            Navigator.pushNamed(context, '/page3');
          },
        ),
      ),
    );
  }
}
