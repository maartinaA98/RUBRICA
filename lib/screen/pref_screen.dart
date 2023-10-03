/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dettagli_contatto.dart';
import '../models/contatto.dart';
import '../models/db_menager.dart';

class ContattiPreferiti extends StatefulWidget {
  @override
  _ContattiPreferitiState createState() => _ContattiPreferitiState();
}

class _ContattiPreferitiState extends State<ContattiPreferiti> {
  late List<Contatto> contattiPreferiti = [];

  @override
  void initState() {
    super.initState();
    loadContattiPreferiti();
  }

  void loadContattiPreferiti() async {
    contattiPreferiti = await DataBaseManager.instance.getContattiPreferiti();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contattiPreferiti.isEmpty
          ? Center(child: Text('Nessun contatto preferito'))
          : ListView.builder(
              itemCount: contattiPreferiti.length,
              itemBuilder: (context, index) {
                Contatto contatto = contattiPreferiti[index];
                return Column(
                  children: [
                    ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DettagliContatto(
                                contatto: contatto,
                              ),
                            ),
                          ).then((contatto_modificato) {
                            setState(() {});
                          });
                        },
                        leading: CircleAvatar(
                          child: Text(contatto.iniziale),
                          backgroundColor: Color.fromARGB(246, 215, 218, 228),
                        ),
                        // Mostra i dettagli del contatto preferito
                        title: Text(contatto.nome + contatto.cognome),
                        trailing: Container(
                            //  decoration: BoxDecoration(
                            //    shape: BoxShape.circle,
                            //     border: Border.all(
                            //          color: const Color.fromARGB(255, 15, 10, 10)),
                            //    ),
                            child: IconButton(
                          onPressed: () async {
                            final url = Uri.parse('tel:' + contatto.numero);
                            if (await canLaunchUrl(url)) {
                              launchUrl(url);
                            }
                          },
                          icon: Icon(
                            Icons.phone,
                            color: Color.fromARGB(255, 18, 136, 3),
                          ),
                        ))),
                    Divider(
                      color: Color.fromARGB(146, 0, 0, 0),
                      //height: 20,
                      // indent: 20,
                    )
                  ],
                );
              },
            ),
    );
  }
}*/
