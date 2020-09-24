import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'helpers.dart';
import '../bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  TextEditingController login = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool passwordVisible = false;
  BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(
      Helpers.adaptiveHeight(10),
    ),
  );

  //TODO: Адаптивность
  @override
  Widget build(BuildContext context) {
    Helpers.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.height);
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthInitial) {
              bool loginCorrect = !state.loginFailed;
              bool passwordCorrect = !state.passFailed;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Helpers.adaptiveHeight(50)),
                      child: Container(
                        width: Helpers.adaptiveWidth(250),
                        height: Helpers.adaptiveHeight(50),
                        child: Center(
                          child: Text(
                            "Авторизация",
                            style:
                                TextStyle(fontSize: Helpers.adaptiveHeight(25)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Helpers.adaptiveHeight(30)),
                      child: Container(
                        key: Key('loginCont'),
                        decoration: BoxDecoration(
                          color: loginCorrect ? Color(0xAA98D2F5) : Colors.red,
                          borderRadius: _borderRadius,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: Helpers.adaptiveWidth(40),
                              height: Helpers.adaptiveHeight(40),
                              child: Icon(Icons.person),
                            ),
                            Container(
                              width: Helpers.adaptiveWidth(260),
                              height: Helpers.adaptiveHeight(50),
                              child: TextFormField(
                                key: Key('login'),
                                controller: login,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Логин",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Helpers.adaptiveHeight(30)),
                      child: Container(
                          decoration: BoxDecoration(
                            color: passwordCorrect
                                ? Color(0xAA98D2F5)
                                : Colors.red,
                            borderRadius: _borderRadius,
                          ),
                          child: PasswordField(pass: pass)),
                    ),
                    SizedBox(
                      height: Helpers.adaptiveHeight(100),
                    ),
                    GestureDetector(
                      key: Key('enter'),
                      onTap: () {
                        if (loginCorrect && passwordCorrect)
                          Navigator.pushReplacementNamed(context, '/info',
                              arguments: {"login": login.value.text});
                      },
                      child: Container(
                        width: Helpers.adaptiveWidth(200),
                        height: Helpers.adaptiveHeight(50),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: _borderRadius,
                        ),
                        child: Center(
                          child: Text(
                            "Войти",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController pass;

  const PasswordField({Key key, this.pass}) : super(key: key);
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: Helpers.adaptiveWidth(40),
            height: Helpers.adaptiveHeight(40),
            child: Icon(Icons.vpn_key)),
        Container(
          width: Helpers.adaptiveWidth(260),
          height: Helpers.adaptiveHeight(50),
          child: TextFormField(
            key: Key('password'),
            controller: widget.pass,
            obscureText: !passwordVisible,
            decoration: InputDecoration(
              hintText: "Пароль",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
          child: Container(
              width: Helpers.adaptiveWidth(40),
              height: Helpers.adaptiveHeight(40),
              child: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off)),
        ),
      ],
    );
  }
}
