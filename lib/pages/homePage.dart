import 'package:flutter/material.dart';
import './articles_page.dart';
import '../data/saveLocal.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final feedController = TextEditingController();
  List feeds = [];

  @override
  Widget build(BuildContext context) {
    SaveLocal persistence = new SaveLocal(feedList: feeds);

    persistence.read().then((data) {
      setState(() {
        feeds = data;
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Meus feeds'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: this._formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: feedController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: "Link do rss",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo é Obrigatório';
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Cadastrar'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    if (this._formKey.currentState.validate()) {
                      setState(() {
                        feeds.add(feedController.text);
                        persistence.save(feeds);
                        feedController.text = '';
                      });
                    }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: feeds.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(feeds[index]),
                        leading: index % 2 == 0
                            ? Icon(Icons.rss_feed)
                            : Icon(Icons.school),
                        onTap: () {
                          print(index.toString());
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
