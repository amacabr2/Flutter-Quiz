import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageUtils {
  String file;

  StorageUtils(this.file);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$file');
  }

  Future<List<String>> read() async {
    try {
      final file = await _localFile;
      List<String> contents = await file.readAsLines();
      return contents;
    } catch (e) {
      return [];
    }
  }

  Future<File> write(String text) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$text');
  }
}