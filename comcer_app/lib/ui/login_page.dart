import 'package:comcer_app/core/app_cores.dart';
import 'package:comcer_app/core/app_imagens.dart';
import 'package:comcer_app/ui/base_page.dart';
import 'package:comcer_app/util/Constantes.dart';
import 'package:comcer_app/util/Validador.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();



  bool _verSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppCores.lightRed,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 448,
                  height: 275,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImagens.logoVermelhoEscuro)
                      )
                  ),
                ),
                Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: Constantes.email,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppCores.red)),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constantes.TAMANHO_FONTE_LABEL_TEXT,
                                color: Theme.of(context).primaryColor
                            )
                        ),
                        style: const TextStyle(fontSize: 20),
                        validator: (email){
                          if(email!.isEmpty){
                            return "O E-mail deve ser informado";
                          }
                          if(!emailValido(email)){
                            return"Email inválido";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: senhaController,
                        obscureText: _verSenha,
                        decoration: InputDecoration(
                            labelText: Constantes.senha,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _verSenha ? Icons.visibility : Icons.visibility_off,
                                color: Theme.of(context).primaryColor,
                              ), onPressed: () {
                              setState(() {
                                _verSenha = !_verSenha;
                              });
                            },
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppCores.red)),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constantes.TAMANHO_FONTE_LABEL_TEXT,
                                color: Theme.of(context).primaryColor
                            )
                        ),
                        style: const TextStyle(fontSize: 20),
                        validator: (senha) {
                          if(senha!.isEmpty) {
                            return "A senha deve ser informada";
                          } else if (senha.length < 8 ) {
                            return "A senha deve possuir no mínimo 8 caracteres.";
                           } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 72,
                      ),
                      Container(
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppCores.green,
                            borderRadius: BorderRadius.all(Radius.circular(Constantes.VALOR_ARREDONDAMENTO_CONTAINER))
                        ),
                        child: SizedBox.expand(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppCores.green),
                              overlayColor: MaterialStateProperty.all(AppCores.darkGreen),
                            ),
                            onPressed: (){
                              if(!formKey.currentState!.validate()) {

                              } else {
                                Navigator.pushNamed(
                                    context, '/base');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Entrar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
