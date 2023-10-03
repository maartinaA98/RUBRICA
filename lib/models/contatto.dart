class Contatto {
  int? id;
  String nome;
  String cognome;
  String numero;
  String email;
  late String iniziale;

  //late bool preferiti;

  // Costruttore
  Contatto({
    this.id,
    required this.nome,
    required this.cognome,
    required this.numero,
    required this.email,
  }) {
    iniziale = nome.isNotEmpty ? nome[0].toUpperCase() : '';
  }

  //costruttore factory che ritorna la map
  factory Contatto.fromMap(Map<String, dynamic> map) {
    return Contatto(
      id: map['id'],
      nome: map['nome'],
      cognome: map['cognome'],
      numero: map['numero'],
      email: map['email'],
    );
  }
  //metodo che ritorna le informazii dell'oggetto
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cognome': cognome,
      'numero': numero,
      'email': email,
    };
  }
}
