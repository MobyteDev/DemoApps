import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helpers.dart';
import 'package:audioplayers/audio_cache.dart';

class InfoPage extends StatefulWidget {
  final String name;
  InfoPage({this.name});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController email = TextEditingController();
  TextEditingController caption = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool emailError = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/xyl');
              },
              child: Icon(
                Icons.music_note,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Helpers.adaptiveHeight(50),
              ),
              Container(
                width: Helpers.adaptiveWidth(250),
                height: Helpers.adaptiveHeight(50),
                child: Text(
                  "Привет " + widget.name + ", расскажи о себе",
                  style: TextStyle(fontSize: Helpers.adaptiveHeight(25)),
                ),
              ),
              TextForm(
                controller: email,
                function: (String value) {
                  if (!value.contains("@")) return 'Неправильный формат ввода';
                  return null;
                },
                hint: "email",
                textInputType: TextInputType.emailAddress,
              ),
              TextForm(
                controller: caption,
                function: (String value) {
                  if (value.isEmpty) return 'Неправильный формат ввода';
                  return null;
                },
                hint: "Описание",
                textInputType: TextInputType.text,
              ),
              TextForm(
                controller: birthDate,
                function: (String value) {
                  if (value.isEmpty) return 'Неправильный формат ввода';
                  return null;
                },
                hint: "Дата рождения",
                textInputType: TextInputType.datetime,
              ),
              TextForm(
                controller: phoneNumber,
                function: (String value) {
                  if (value.isEmpty) return 'Неправильный формат ввода';
                  return null;
                },
                hint: "Номер телефона",
                textInputType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final TextEditingController controller;
  final Function function;
  final String hint;
  final TextInputType textInputType;
  final _formKey = GlobalKey<FormState>();

  TextForm({this.controller, this.function, this.hint, this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
            left: Helpers.adaptiveHeight(50),
            top: Helpers.adaptiveHeight(25),
            right: Helpers.adaptiveHeight(50)),
        child: Container(
          width: Helpers.adaptiveWidth(300),
          height: Helpers.adaptiveHeight(75),
          decoration: BoxDecoration(
            color: Color(0xAA98D2F5),
            borderRadius: BorderRadius.all(
              Radius.circular(Helpers.adaptiveHeight(10)),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: Helpers.adaptiveWidth(15),
              ),
              Container(
                width: Helpers.adaptiveWidth(250),
                child: TextFormField(
                  keyboardType: textInputType,
                  controller: controller,
                  validator: function,
                  onFieldSubmitted: (String) {
                    if (_formKey.currentState.validate()) {}
                  },
                  decoration: InputDecoration(
                    hintText: hint,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
