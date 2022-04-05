import 'dart:convert';

import 'package:comcer_app/controller/user_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_imagens.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/User.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:comcer_app/util/Validador.dart';
import 'package:comcer_app/util/util.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController userController = UserController();
  APIResponse<User> apiResponse = APIResponse<User>();
  User user = User.empty();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SnackBar showSnackBar(String message) {
    return SnackBar(
      backgroundColor: AppColors.darkRed,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.close,
              color: Colors.white,
              size: 10,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(message,
              maxLines: 2,
              style: AppStyles.size12WhiteBold,
            )
          ],
        ),
      ),
    );
  }

  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.lightRed,
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.lightRed,
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
                          image: AssetImage(AppImages.darkRedLogo))),
                ),
                Form(
                  key: formKey,
                  child: Consumer<PrefsService>(
                    builder: (_, prefsService, __) {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            enabled: !prefsService.loading,
                            decoration: InputDecoration(
                                labelText: Constant.email,
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.red)),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constant.FONT_LABEL_TEXT_SIZE,
                                    color: Theme.of(context).primaryColor)),
                            style: const TextStyle(fontSize: 20),
                            validator: (email) {
                              if (email!.isEmpty) {
                                return "O E-mail deve ser informado";
                              }
                              else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _showPassword,
                            enabled: !prefsService.loading,
                            decoration: InputDecoration(
                                labelText: Constant.senha,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.red)),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constant.FONT_LABEL_TEXT_SIZE,
                                    color: Theme.of(context).primaryColor)),
                            style: const TextStyle(fontSize: 20),
                            validator: (senha) {
                              if (senha!.isEmpty) {
                                return "A senha deve ser informada";
                                 } else if (senha.length < 8) {
                                     return "A senha deve possuir no mínimo 8 caracteres.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 72,
                          ),
                          Container(
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.green,
                                borderRadius: const BorderRadius.all(Radius.circular(
                                    Constant.ROUNDING_EDGE_CONTAINER_VALUE))),
                            child: SizedBox.expand(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.green),
                                  overlayColor: MaterialStateProperty.all(
                                      AppColors.darkGreen),
                                  foregroundColor: MaterialStateProperty.all(AppColors.green.withAlpha(100))
                                ),
                                onPressed: prefsService.loading ? null : () async {
                                  if (formKey.currentState!.validate()) {
                                    user.usuario = emailController.text;
                                    user.senha = sha256.convert(utf8.encode(passwordController.text)).toString();
                                    apiResponse = await userController.autenticar(user);
                                    if(!apiResponse.error!){
                                      user.token = apiResponse.data!.token;
                                      user.role = apiResponse.data!.role;
                                      Util.saveToken(user.token);
                                      prefsService.saveLogIn(user);
                                      Navigator.pushReplacementNamed(context, '/base');
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(showSnackBar(apiResponse.errorMessage!));
                                    }
                                  }
                                },
                                child: prefsService.loading ? CircularProgressIndicator() : const Text(
                                  "Entrar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
