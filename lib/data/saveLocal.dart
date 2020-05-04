import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SaveLocal {
  final List feedList;

  SaveLocal({this.feedList});

  Future<File> get fileFeed async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File("${directory.path}/feeds.json");
    if (file.existsSync()) {
      save(feedList);
    }

    return file;
  }

  read() async {
    final File file = await fileFeed;
    String data = file.readAsStringSync();

    return json.decode(data);
  }

  save(data) async {
    final File file = await fileFeed;

    file.writeAsString(json.encode(data));
  }
}