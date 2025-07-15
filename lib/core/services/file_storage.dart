import "dart:io";

import "package:path_provider/path_provider.dart";

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localHistoryFile async {
    final path = await _localPath;
    return File("$path/history.txt");
  }

  Future<File> get _localHourlyRateFile async {
    final path = await _localPath;
    return File("$path/rate.txt");
  }

  Future<File> writeHistory(String text) async {
    final file = await _localHistoryFile;
    return file.writeAsString("$text\n", mode: FileMode.write, flush: true);
  }

  Future<File> appendHistory(String text) async {
    final file = await _localHistoryFile;
    return file.writeAsString("$text\n", mode: FileMode.append, flush: true);
  }

  Future<String> readHistory() async {
    try {
      final file = await _localHistoryFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  Future<File> writeHourlyRate(double value) async {
    final file = await _localHourlyRateFile;
    return file.writeAsString("$value\n");
  }

  Future<double> readHourlyRate() async {
    try {
      final file = await _localHourlyRateFile;
      final contents = await file.readAsString();
      return double.parse(contents);
    } catch (e) {
      return 0;
    }
  }
}
