import 'package:app_rubrica/models/db_menager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/contatto.dart';

class Modifica_contatto extends StatefulWidget {
  final Contatto contatto;
  Modifica_contatto({super.key, required this.contatto});

  @override
  _Modifica_contatto createState() => _Modifica_contatto();
}

class _Modifica_contatto extends State<Modifica_contatto> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cognomeController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  late bool _validetorEmail = false;
  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.contatto.nome;
    _cognomeController.text = widget.contatto.cognome;
    _numeroController.text = widget.contatto.numero;
    _emailController.text = widget.contatto.email;
  }

  late Contatto contatto;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifica contatto'),
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
                      prefixIcon: Icon(Icons.people_outline),
                      labelText: 'Nome',
                      border: OutlineInputBorder(borderSide: BorderSide())),
                  controller: _nomeController,
                  maxLength: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people_outline),
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
                      final nome = _nomeController.text.toLowerCase();
                      final cognome = _cognomeController.text.toLowerCase();
                      final numero = _numeroController.text;
                      final email = _emailController.text;

                      if (nome.isNotEmpty && numero.isNotEmpty ||
                          nome.isNotEmpty && _validetorEmail) {
                        widget.contatto.nome = nome;
                        widget.contatto.cognome = cognome;
                        widget.contatto.numero = numero;
                        widget.contatto.email = email;

                        DataBaseManager.instance
                            .modificaContatto(widget.contatto);
                        /*    
                        contatto_modificato = Contatto(
                          nome: widget.contatto.nome,
                          cognome: cognome,
                          numero: numero,
                          email: email,
                        );*/

                        Navigator.pop(context);
                      } else if (_validetorEmail == false) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('ERRORE'),
                            content: const Text('Email non valida'),
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
                      } else {
                        if (nome.isEmpty || numero.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('ERRORE'),
                              content: const Text(
                                  'Compila tutti i campi per salvare'),
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
                      }
                    },
                    child: const Text('SALVA'),
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
