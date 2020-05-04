import 'package:flutter/material.dart';
import '../data/getFeedData.dart';

class ArticlesPage extends StatefulWidget {
  final String feed;

  ArticlesPage({Key key, this.feed}) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState(this.feed);
}

class _ArticlesPageState extends State<ArticlesPage> {
  final String feed;
  Future<List> articles;

  _ArticlesPageState(this.feed);

  @override
  Widget build(BuildContext context) {
    GetFeedData rss = new GetFeedData();
    articles = rss.read(url: this.feed);

    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Artigos'),
        ),
        body: FutureBuilder(
          future: articles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return messageTemplate(
                    title: 'Carregando ...', icon: Icons.refresh);
              default:
                if (snapshot.hasError) {
                  messageTemplate(
                      title: 'Não foi possível carregar ...',
                      icon: Icons.error);
                }
                return messageTemplate(title: 'Carregado', icon: Icons.done);
            }
          },
        ));
  }

  //Método
  messageTemplate({String title, IconData icon}) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(icon, size: 50),
          Text(title),
        ]));
  }
}
