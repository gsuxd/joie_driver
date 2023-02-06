import 'package:archive/archive.dart';

String generateCode(String email) {
  Iterable<String> binarys =
      email.codeUnits.map((int strInt) => strInt.toRadixString(2));
  Crc32 hash = Crc32();
  for (var i in binarys) {
    hash.add([int.parse(i)]);
  }
  return hash.hash.toString();
}
