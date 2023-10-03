import 'package:app_rubrica/models/sherepreferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'screen/crea_contatto.dart';
import 'dettagli_contatto.dart';
import 'models/contatto.dart';
import 'models/db_menager.dart';

class Contatti_list extends StatefulWidget {
  const Contatti_list({Key? key}) : super(key: key);

  @override
  State<Contatti_list> createState() => _Contatti_listState();
}

class _Contatti_listState extends State<Contatti_list> {
  bool _vedo_soloEmail = false;

  List<Contatto> listaContatti = [];

  @override
  void initState() {
    super.initState();
    getContatti();
  }

  @override
  void dispose() {
    listaContatti.clear();
    super.dispose();
  }

  void getContatti() async {
    var aggiornamento = await DataBaseManager.instance.getContatto();
    if (mounted) {
      // Verifica se l'oggetto State è ancora montato nel widget
      setState(() {
        listaContatti = aggiornamento;
        loadPreferences();
      });
    }
  }

  void toggleEmailFilter(bool value) async {
    setState(() {
      _vedo_soloEmail = value;
      SharedPrefManager.instance.set_soloEmail(value);
    });
  }

  void loadPreferences() async {
    getContatti();
    bool vedo_soloEmail = await SharedPrefManager.instance.get_soloEmail();
    setState(() {
      _vedo_soloEmail = vedo_soloEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Contatto> filteredContatti = listaContatti;

    if (_vedo_soloEmail) {
      setState(() {
        filteredContatti = listaContatti
            .where((contatto) => contatto.email.isNotEmpty)
            .toList();
        getContatti();
      });
    }

    return Scaffold(
      body: filteredContatti.isEmpty
          ? Center(child: Text('Nessun contatto '))
          : ListView.builder(
              itemCount: filteredContatti.length,
              itemBuilder: (context, index) {
                var contatto = filteredContatti[index];

                return Column(
                  children: [
                    ListTile(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                title: const Text('Elimina'),
                                content: const Text(
                                    'Sei sicuro di voler eliminare?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        DataBaseManager.instance
                                            .eliminaContatto(contatto.id!);
                                        getContatti();
                                      });
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Hai eliminato   ' +
                                              contatto.nome +
                                              "   " +
                                              contatto.cognome),
                                          action: SnackBarAction(
                                            label: 'ANNULLA',
                                            onPressed: () {
                                              setState(() {
                                                DataBaseManager.instance
                                                    .insertConttato(contatto);
                                                filteredContatti.sort(
                                                  (a, b) => a.nome
                                                      .compareTo(b.cognome),
                                                );
                                                getContatti();
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('Si'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Annulla'),
                                  ),
                                ],
                              )),
                        );
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DettagliContatto(
                              contatto: contatto,
                            ),
                          ),
                        ).then((contatto_modificato) {
                          setState(() {
                            filteredContatti.sort(
                              (a, b) => a.nome.compareTo(b.cognome),
                            );
                            getContatti();
                          });
                        });
                      },
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
                            color: Color.fromARGB(255, 54, 63, 53),
                          ),
                        ),
                      ),
                      leading: CircleAvatar(
                        child: Text(contatto.iniziale,
                            style: TextStyle(color: Colors.black)),
                        backgroundColor: Color.fromARGB(255, 236, 236, 236),
                      ),
                      title: Text(contatto.nome + ' ' + contatto.cognome),
                    ),
                    Divider(
                      color: Color.fromARGB(146, 0, 0, 0),
                      height: 20,
                      indent: 20,
                    )
                  ],
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 20, 25),
        child: FloatingActionButton(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.151),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Crea_contatto(
                  nome: '',
                  cognome: '',
                  numero: '',
                  email: '',
                ),
              ),
            ).then((nuovoContatto) {
              setState(() {
                DataBaseManager.instance.insertConttato(nuovoContatto);
                filteredContatti.sort(
                  (a, b) => a.nome.compareTo(b.cognome),
                );
                getContatti();
              });
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
