// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'account_collection.g.dart';

@collection
class Account {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  String? name;
  late String ethAddress;
  late String solanaAddress;
  String? bitcoinAddress;
  bool ishide = false;
  List<int>? image;

  @override
  String toString() {
    return 'Account(id: $id, name: $name, ethAddress: $ethAddress, solanaAddress: $solanaAddress, bitcoinAddress: $bitcoinAddress, ishide: $ishide, image: $image)';
  }
}
