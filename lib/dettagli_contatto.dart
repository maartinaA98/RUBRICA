import 'package:app_rubrica/models/db_menager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:app_rubrica/screen/modifica_contatto.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'models/contatto.dart';
import 'package:url_launcher/url_launcher.dart';

class DettagliContatto extends StatefulWidget {
  DettagliContatto({super.key, required this.contatto});
  late Contatto contatto;
  @override
  State<DettagliContatto> createState() => _DettagliContatto();
}

class _DettagliContatto extends State<DettagliContatto> {
//  bool preferito = false;

  @override
  void initState() {
    super.initState();
    // controllaPreferito();
  }

  /*void controllaPreferito() async {
    List<Contatto> contattiPreferiti =
        await DataBaseManager.instance.getContattiPreferiti();
    setState(() {
      preferito = contattiPreferiti.contains(widget.contatto);
    });
  }*/

  /*void togglePreferito() async {
    List<Contatto> contattiPreferiti =
        await DataBaseManager.instance.getContattiPreferiti();

    if (widget.contatto.preferito) {
      // Rimuovi dai preferiti
      contattiPreferiti.remove(widget.contatto);
      await DataBaseManager.instance.salvaContattoPreferito();
      setState(() {
        preferito = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contatto rimosso dai preferiti')),
      );
    } else {
      // Aggiungi ai preferiti
      contattiPreferiti.add(widget.contatto);
      await DataBaseManager.instance.salvaContattoPreferito();
      setState(() {
        preferito = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Hai aggiunto ${widget.contatto.nome} ai preferiti')),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //final schermo = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('info'), actions: [
        //testo preferiti
        // IconButton(
        //  icon: Icon(preferito ? Icons.star : Icons.star_border),
        //  onPressed: togglePreferito,
        //  ),
        //tasto modifica
        IconButton(
          icon: const Icon(Icons.create_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Modifica_contatto(contatto: widget.contatto)),
            ).then((contatto) {
              setState(() {});
            });
          },
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Modifica_contatto(contatto: widget.contatto)),
                    ).then((contatto) => setState(() {}));
                  },
                  child: Card(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 200,
                      width: 280,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              child: Text(widget.contatto.iniziale),
                              backgroundColor:
                                  Color.fromARGB(246, 215, 218, 228),
                            ),
                            Text(widget.contatto.nome +
                                " " +
                                widget.contatto.cognome),
                          ]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ElevatedButton.icon(
                        onPressed: widget.contatto.numero.isNotEmpty
                            ? () async {
                                final url =
                                    Uri.parse('tel:' + widget.contatto.numero);
                                if (await canLaunchUrl(url)) {
                                  launchUrl(url);
                                }
                              }
                            : null,
                        icon: Icon(
                          Icons.phone,
                          color: Color.fromRGBO(0, 0, 0, 0.525),
                        ),
                        label: Text('Chiama'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ElevatedButton.icon(
                          onPressed: widget.contatto.numero.isNotEmpty
                              ? () async {
                                  final url = Uri.parse(
                                      'SMS:' + widget.contatto.numero);
                                  if (await canLaunchUrl(url)) {
                                    launchUrl(url);
                                  }
                                }
                              : null,
                          icon: Icon(
                            Icons.message_rounded,
                            color: Color.fromRGBO(0, 0, 0, 0.525),
                          ),
                          label: Text('SMS')),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ElevatedButton.icon(
                        onPressed: widget.contatto.email.isNotEmpty
                            ? () async {
                                final url = Uri(
                                  scheme: 'mailto',
                                  path: widget.contatto.email,
                                  query:
                                      'subject=Ciao&body=Ti scrivo per dirti che..',
                                );
                                if (await canLaunchUrl(url)) {
                                  launchUrl(url);
                                } else {
                                  // ignore: avoid_print
                                  print("Can't launch $url");
                                }
                              }
                            : null,
                        icon: Icon(
                          Icons.email,
                          color: Color.fromRGBO(7, 7, 7, 0.525),
                        ),
                        label: Text('Email'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Modifica_contatto(contatto: widget.contatto)),
                      ).then((contatto) => setState(() {}));
                    },
                    child: Card(
                        elevation: 4,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        child: Center(
                          child: Container(
                            height: 100,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          Icons.phone,
                                          color:
                                              Color.fromRGBO(19, 18, 18, 0.525),
                                        ),
                                      ),
                                      Text(widget.contatto.numero),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          Icons.email_sharp,
                                          color:
                                              Color.fromRGBO(10, 10, 10, 0.525),
                                        ),
                                      ),
                                      Text(widget.contatto.email),
                                    ],
                                  ),
                                ]),
                          ),
                        )),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String email = widget.contatto.email != null &&
                            widget.contatto.email.isNotEmpty
                        ? ',\n Indirizzo Email: ${widget.contatto.email}'
                        : '';
                    String numero = widget.contatto.numero != null &&
                            widget.contatto.numero.isNotEmpty
                        ? ', \n Numero: +39  ${widget.contatto.numero}'
                        : '';
                    String cognome = widget.contatto.cognome != null &&
                            widget.contatto.cognome.isNotEmpty
                        ? ',\n Cognome: ${widget.contatto.cognome}'
                        : '';
                    final email_url =
                        'mailto:?subjectCondivisione contatto: ${widget.contatto.nome}=&body=Nome: ${widget.contatto.nome} $cognome $numero $email';
                    if (await canLaunchUrlString(email_url)) {
                      launchUrlString(email_url);
                    } else {
                      throw 'Impossibile aprire l\'app di posta elettronica.';
                      //print("Can't launch $url");
                    }
                  },
                  child: Text('Condividi tramite email'),
                ),
              ),
            ]),
      ),
    );
  }
}
