import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Anuncios.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

// amarela 0xFFfad107
// rosa 0xFFe52755

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _cadastrar = false;
  String _tituloAcao = "Logar";

  _cadastrarUsuario() {
    FirebaseAuth auth = FirebaseAuth.instance;

    String email = _emailController.text;
    String senha = _senhaController.text;

    auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((firebaseUser) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Anuncios()));
    }).catchError((error) {
      _erro(error.toString());
    });
  }

  _logarUsuario() {
    FirebaseAuth auth = FirebaseAuth.instance;

    String email = _emailController.text;
    String senha = _senhaController.text;

    auth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((firebaseUser) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Anuncios()));
    }).catchError((error) {
      _erro(error.toString());
    });
  }

  _erro(String msg) {
    final snack = SnackBar(
      backgroundColor: Colors.black,
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  _validaCampos() {
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.length >= 6) {
        if (_cadastrar) {
          _cadastrarUsuario();
        } else {
          _logarUsuario();
        }
      } else {
        setState(() {
          _erro("Senha inválida");
        });
      }
    } else {
      setState(() {
        _erro("Email inválido");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Color(0xFFe52755),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("lib/images/logo.png"),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    labelText: "E-mail",
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
                controller: _emailController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      labelText: "Senha",
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                  controller: _senhaController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Logar"),
                  Switch(
                      value: _cadastrar,
                      onChanged: (bool value) {
                        setState(() {
                          _cadastrar = value;
                          if (value) {
                            _tituloAcao = "Cadastrar";
                          } else {
                            _tituloAcao = "Logar";
                          }
                        });
                      }),
                  Text("Cadastrar"),
                ],
              ),
              ElevatedButton(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(_tituloAcao,
                        style: TextStyle(color: Colors.white, fontSize: 20))),
                style: TextButton.styleFrom(backgroundColor: Color(0xFFe52755)),
                onPressed: () {
                  _validaCampos();
                },
              )
            ])),
          ),
        ));
  }
}
