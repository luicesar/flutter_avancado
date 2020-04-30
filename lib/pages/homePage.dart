import 'package:flutter/material.dart';
import './articles_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: "Link do rss",
                  ),
                ),
                RaisedButton(
                  child: Text('Cadastrar'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    print('adicionar');
                  },
                )
              ],
            ),
          ),
        ));
  }
}
