import 'package:flutter/material.dart';
import '../data/getFeedData.dart';
import 'package:url_launcher/url_launcher.dart';

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
        leading: Icon(Icons.rss_feed),
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
                    title: 'Não foi possível carregar ...', icon: Icons.error);
              }
              return listArticles(snapshot.data);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  //Métodos:
  messageTemplate({String title, IconData icon}) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(icon, size: 50),
          Text(title),
        ]));
  }

  listArticles(List articles) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(articles[index]['title']),
                    subtitle: Text(articles[index]['link']),
                    leading: Icon(Icons.open_in_browser),
                    onTap: () async {
                      //openURL(articles[index]['link']);
                      String url = articles[index]['link'];
                      canLaunch(url).then((isConfirmed) {
                        if (isConfirmed) {
                          launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      });
                    },
                  );
                }))
      ],
    );
  }

  openURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
