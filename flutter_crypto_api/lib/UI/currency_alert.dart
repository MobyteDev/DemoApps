import 'package:flutter/material.dart';
import 'package:flutter_weather_api/UI/web_socket.dart';

Future<CurrencyType> showCurrencyDialog(BuildContext context) {
  CurrencyType currencyType = CurrencyType.BTC;
  final double height = MediaQuery.of(context).size.height * 0.5;
  final double width = MediaQuery.of(context).size.width * 0.5;
  CurrencyType mapToType(int index) {
    print(WebSocket.currencyName[CurrencyType.values[index]]);
    currencyType = CurrencyType.values[index];
  }

  return showDialog<CurrencyType>(
      context: context,
      barrierColor: Colors.white,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(

          backgroundColor: Color(0xEE121212),
          title: Text('Выберите валюту', style: TextStyle(color: Colors.white)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height,
                width: 300,
                child: ListWheelScrollView.useDelegate(
                    itemExtent: 40,
                    useMagnifier: true,
                    magnification: 1.5,
                    onSelectedItemChanged: mapToType,
                    childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Container(
                            width: 100,
                            height: 40,
                            child: Text(
                                WebSocket
                                    .currencyName[CurrencyType.values[index]],
                                style: Theme.of(context).textTheme.headline1),
                          );
                        },
                        childCount: CurrencyType.values.length),),
              ),
            ],
          ),
          actions: [
            GestureDetector(
                  onTap: () {
                    Navigator.pop(context, currencyType);
                  },
                    child: Text("Сменить подписку"),
                ),

          ],
        );
      },
  );
}
