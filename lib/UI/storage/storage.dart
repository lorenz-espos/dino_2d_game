import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CounterStorage {
  int score = 0;
  int selector = 0;
  CounterStorage(int selector) {
    this.selector = selector;
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    if (selector == 1) {
      //storage of last score
      return File('$path/storage.txt');
    }
    if (selector == 2) {
      //storage of last distance
      return File('$path/storage1.txt');
    }
    if (selector == 3) {
      //storage of coins
      return File('$path/storage2.txt');
    }
    return File('');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> pushCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}
