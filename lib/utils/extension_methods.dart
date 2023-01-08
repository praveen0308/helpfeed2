import 'dart:io';
import 'dart:math';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
extension FileMethodsExtension on File{
  String getFileSize() {

    int bytes = lengthSync();
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(0)) + suffixes[i];
  }
}
