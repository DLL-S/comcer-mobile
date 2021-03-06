import 'dart:convert';

import 'package:comcer_app/controller/user_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_imagens.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/api_response.dart';
import 'package:comcer_app/dominio/models/user.dart';
import 'package:comcer_app/dominio/enum/environment.dart';
import 'package:comcer_app/environment_config.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:comcer_app/util/validator.dart';
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
  bool loading = false;

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
              Icons.error_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              message,
              maxLines: 2,
              style: AppStyles.size12WhiteBold,
            )
          ],
        ),
      ),
    );
  }

  bool _showPassword = true;

  void isLoading() {
    setState(() {
      loading = !loading;
    });
  }

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
                            enabled: !loading,
                            decoration: InputDecoration(
                                labelText: Constant.email,
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.red)),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constant.FONT_LABEL_TEXT_SIZE,
                                    color: Theme.of(context).primaryColor)),
                            style: const TextStyle(fontSize: 20),
                            validator: (email) {
                              if (email!.isEmpty) {
                                return Constant.emailVazio;
                              } else if (EnvironmentConfig.environmentBuild ==
                                      Environments.PRODUCAO &&
                                  !isEmailValid(email)) {
                                return Constant.emailInvalido;
                              } else {
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
                            enabled: !loading,
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.red)),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constant.FONT_LABEL_TEXT_SIZE,
                                    color: Theme.of(context).primaryColor)),
                            style: const TextStyle(fontSize: 20),
                            validator: (senha) {
                              if (senha!.isEmpty) {
                                return Constant.senhaVazia;
                              } else if (senha.length < 8) {
                                return Constant.senhaInvalida;
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
                            decoration: const BoxDecoration(
                                color: AppColors.green,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    Constant.ROUNDING_EDGE_CONTAINER_VALUE))),
                            child: SizedBox.expand(
                              child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.green),
                                    overlayColor: MaterialStateProperty.all(
                                        AppColors.darkGreen),
                                    foregroundColor: MaterialStateProperty.all(
                                        AppColors.green.withAlpha(100))),
                                onPressed: loading
                                    ? null
                                    : () async {
                                        if (formKey.currentState!.validate()) {
                                          isLoading();
                                          user.usuario = emailController.text;
                                          user.senha = sha256
                                              .convert(utf8.encode(
                                                  passwordController.text))
                                              .toString();
                                          apiResponse = await userController
                                              .autenticar(user);
                                          if (!apiResponse.error!) {
                                            user.token =
                                                apiResponse.data!.token;
                                            user.role = apiResponse.data!.role;
                                            Util.saveToken(user.token);
                                            prefsService.saveLogIn(user);
                                            isLoading();
                                            Navigator.pushReplacementNamed(
                                                context, '/base');
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(showSnackBar(
                                                    apiResponse.errorMessage!));
                                            isLoading();
                                          }
                                        }
                                      },
                                child: loading
                                    ? const CircularProgressIndicator(
                                        color: AppColors.white,
                                      )
                                    : const Text(
                                        Constant.entrar,
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
