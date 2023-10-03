import 'package:app_rubrica/screen/impostazioni_contatto.dart';
import 'package:app_rubrica/screen/pref_screen.dart';
import 'package:app_rubrica/screen_contatti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.384),
            title: Text(
              'Rubrica',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Impostazioni()),
                  ).then(
                    (value) {
                      setState(() {});
                    },
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
            /*bottom: TabBar(
            tabs: [
              Tab(text: 'Contatti'),
              Tab(text: 'Preferiti'),
            ],
          ),
        ),*/
          ),
          body:
              Contatti_list() /*TabBarView(
          children: [
            Center(child: ),
            Center(
                //   child: ContattiPreferiti(),
                ),
          ],
        ),*/
          ),
    );
  }
}
