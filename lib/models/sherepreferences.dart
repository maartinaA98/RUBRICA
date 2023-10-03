import 'package:shared_preferences/shared_preferences.dart';

import 'contatto.dart';

class SharedPrefManager {
  SharedPrefManager._();

  static final instance = SharedPrefManager._();

  Future<bool> get_soloEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('vedi_soloEmail') ?? false;
  }

  Future<void> set_soloEmail(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('vedi_soloEmail', value);
  }
}










/*import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  SharedPrefManager._();
  static final instance = SharedPrefManager._();
  static const String _switchState = "switchState";

  void saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_switchState, value);
  }

  Future<bool> loadSwitchState() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(_switchState) ?? false;
  }
  //  void loadPreferences() async {
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool vedi_soloEmail = prefs.getBool('vedi_soloEmail') ?? false;
}
//}
*/