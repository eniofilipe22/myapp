import 'package:flutter/material.dart';

class NovoAnuncio extends StatefulWidget {
  const NovoAnuncio({super.key});

  @override
  State<NovoAnuncio> createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  final _formKey = GlobalKey<FormState>();
  List<XFile> _listaImagens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo anúncio"),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormField(
                            initialValue: _listaImagens,
                            validator: (imagens) {
                              if (imagens!.length == 0) {
                                return "Necessário selecionar uma imagem";
                              }
                              return null;
                            },
                            builder: (state) => {
                              return Column(children: [
                                Container(

                                  height: 100,

                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _listaImagens.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == _listaImagens.length) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey[400],
                                              radius:50,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add_a_photo, size: 40, color: Colors.grey[100]),
                                                  Text("Adicionar", style: TextStyle(color: Colors.grey[100]))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                      // if(){

                                      // }
                                      return Container();
                                    })
                                )
                              ],)
                            },
                            ),
                      ],
                    )))));
  }
}
