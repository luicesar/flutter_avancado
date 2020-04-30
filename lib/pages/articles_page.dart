import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  final String feed;

  ArticlesPage({Key key, this.feed}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState(this.feed);
}

class _ArticlesPageState extends State<ArticlesPage> {
  final String feed;
  _ArticlesPageState(this.feed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Artigos'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text(this.feed),
          onPressed: () {
            //Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
