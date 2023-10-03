import 'package:app_rubrica/models/sherepreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Impostazioni extends StatefulWidget {
  const Impostazioni({Key? key}) : super(key: key);

  @override
  State<Impostazioni> createState() => _ImpostazioniState();
}

class _ImpostazioniState extends State<Impostazioni> {
  bool _switchState = false;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    bool showOnlyWithEmail = await SharedPrefManager.instance.get_soloEmail();
    setState(() {
      _switchState = showOnlyWithEmail;
    });
  }

  Future<void> saveSwitchState(bool value) async {
    await SharedPrefManager.instance.set_soloEmail(value);
    setState(() {
      _switchState = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni'),
      ),
      body: Column(
        children: [
          Card(
            color: Color.fromRGBO(241, 235, 235, 0.452),
            child: ListTile(
              title: const Text('Visualizza solo i contatti con email'),
              trailing: Switch(
                value: _switchState,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: (value) async {
                  await saveSwitchState(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
