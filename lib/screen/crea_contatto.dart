import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/contatto.dart';

class Crea_contatto extends StatefulWidget {
  final String nome;
  final String cognome;
  final String numero;
  final String email;
  Crea_contatto(
      {super.key,
      required this.cognome,
      required this.nome,
      required this.numero,
      required this.email});

  @override
  _creaContatto createState() => _creaContatto();
}

class _creaContatto extends State<Crea_contatto> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cognomeController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  late bool _validetorEmail = false;
  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.nome;
    _cognomeController.text = widget.cognome;
    _numeroController.text = widget.numero;
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crea contatto'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_box_outlined),
                      labelText: 'Nome',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                  controller: _nomeController,
                  maxLength: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_box_outlined),
                      labelText: 'Cognome',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                  controller: _cognomeController,
                  maxLength: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextField(
                    maxLines: null,
                    controller: _numeroController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      labelText: 'Numero telefonico',
                      prefixIcon: Icon(Icons.phone_enabled_outlined),
                      prefixText: '+39-',
                    ),
                  ),
                ),
                TextField(
                  maxLines: null,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  onChanged: (text) {
                    setState(() {
                      _validetorEmail = EmailValidator.validate(text);
                    });
                  },
                ),
//tasto per salvare
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final nome = _nomeController.text.toUpperCase();
                      final cognome = _cognomeController.text.toUpperCase();
                      final numero = _numeroController.text;
                      final email = _emailController.text;
                      Contatto? nuovoContatto;

                      if (nome != '' && numero != '' ||
                          nome != '' && _validetorEmail) {
                        nuovoContatto = Contatto(
                          nome: nome,
                          cognome: cognome,
                          numero: numero,
                          email: email,
                          // preferiti: true,
                        );
                        Navigator.pop(context, nuovoContatto);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('ERRORE'),
                            content: const Text(
                                'I compi non sono stati compilati correttamente'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'SALVA',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
