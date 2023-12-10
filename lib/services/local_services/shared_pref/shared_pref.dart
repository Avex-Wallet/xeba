import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefConstant {
  static const numberOfAccount = 'NumberOfAccount';
  static const currentAccountCount = 'CurrentAccountCount';
}

abstract class IPref {
  Future<void> init({SharedPreferences? pref});
  int get numberOfAccount;
  Future<bool> setNumberOfAccount(int value);

  int get currentAccountCount;
  Future<bool> setCurrentAccountCount(int value);

  Future<bool> wipeData();
}

class Pref extends IPref {
  late SharedPreferences _pref;

  Pref() {
    init();
  }

  @override
  Future<void> init({SharedPreferences? pref}) async {
    _pref = pref ?? await SharedPreferences.getInstance();
  }

  @override
  int get numberOfAccount => _pref.getInt(PrefConstant.numberOfAccount) ?? 1;
  @override
  Future<bool> setNumberOfAccount(int value) async {
    return await _pref.setInt(PrefConstant.numberOfAccount, value);
  }

  @override
  int get currentAccountCount =>
      _pref.getInt(PrefConstant.currentAccountCount) ?? 0;
  @override
  Future<bool> setCurrentAccountCount(int value) async {
    return await _pref.setInt(PrefConstant.currentAccountCount, value);
  }

  @override
  Future<bool> wipeData() async {
    return await _pref.clear();
  }
}

final sharedPref = Provider<IPref>((ref) => Pref());
