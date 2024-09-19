import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Login.dart';
import 'package:myapp/MeusAnuncios.dart';

class Anuncios extends StatefulWidget {
  const Anuncios({super.key});

  @override
  State<Anuncios> createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? usuarioLogado = await auth.currentUser;

    if (usuarioLogado == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Meus anúncios", "Deslogar"];
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    // Navigator.push(context,MaterialPageRoute(builder:(context)=>Login()));
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MeusAnuncios()));
        break;
      case "Entrar / Cadastrar":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Anúncios Online"),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            PopupMenuButton(
                onSelected: _escolhaMenuItem,
                itemBuilder: (context) {
                  return itensMenu.map((String item) {
                    return PopupMenuItem(value: item, child: Text(item));
                  }).toList();
                }),
          ]),
    );
  }
}
