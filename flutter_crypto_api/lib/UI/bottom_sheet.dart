import 'package:flutter/material.dart';
import 'package:flutter_weather_api/UI/helpers.dart';
import 'package:flutter_weather_api/UI/web_socket.dart';

class Modal {
  static CurrencyType _currencyType = CurrencyType.BTC;

  static mainBottomSheet(BuildContext context) {
    void mapToType(int index) {
      print(WebSocket.currencyName[CurrencyType.values[index]]);
      _currencyType = CurrencyType.values[index];
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var helpers = Helpers(height, width);

    return showModalBottomSheet(
        enableDrag: true,
        backgroundColor: Theme.of(context).backgroundColor,
        context: context, //
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: helpers.adaptiveHeight(200),
                child: ListWheelScrollView.useDelegate(
                  physics: BouncingScrollPhysics(),
                  diameterRatio: 1.5,
                  itemExtent: helpers.adaptiveHeight(40),
                  useMagnifier: true,
                  magnification: 1.5,
                  onSelectedItemChanged: mapToType,
                  childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Container(
                          width: helpers.adaptiveWidth(100),
                          height: helpers.adaptiveHeight(40),
                          child: Center(
                            child: Text(
                                WebSocket
                                    .currencyName[CurrencyType.values[index]],
                                style: Theme.of(context).textTheme.headline1),
                          ),
                        );
                      },
                      childCount: CurrencyType.values.length),
                ),
              ),
              GestureDetector(
                onTap: () {
                  var tempCur = _currencyType;
                  _currencyType = CurrencyType.BTC;
                  Navigator.pop(context, tempCur);
                },
                child: Container(
                  width: helpers.adaptiveWidth(200),
                  height: helpers.adaptiveHeight(50),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(helpers.adaptiveHeight(10)),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    "Изменить",
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  )),
                ),
              ),
            ],
          );
        });
  }
}
