import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_api/UI/bottom_sheet.dart';
import 'package:flutter_weather_api/UI/helpers.dart';
import 'package:flutter_weather_api/UI/web_socket.dart';

import 'currency.dart';

class BroadCastPage extends StatefulWidget {
  final WebSocket ws;
  BroadCastPage(this.ws);

  @override
  _BroadCastPageState createState() => _BroadCastPageState(ws);
}

class _BroadCastPageState extends State<BroadCastPage> {
  WebSocket ws;
  _BroadCastPageState(this.ws);

  double prevPrice = 0.0;

  @override
  void dispose() {
    ws.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var helpers = Helpers(height, width);

    TextStyle textStyle = Theme.of(context).textTheme.headline1;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: StreamBuilder(
            stream: ws.getStream(),
            builder: (context, snapShot) {
              print(snapShot);
              Currency currency =
                  (snapShot.data as Currency) ?? Currency.empty();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: helpers.adaptiveHeight(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: helpers.adaptiveWidth(100),
                          height: helpers.adaptiveHeight(50),
                          child: Center(
                              child: Text(
                            currency.from,
                            style: textStyle,
                          )),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: textStyle.color,
                          size: textStyle.fontSize,
                        ),
                        Container(
                          width: helpers.adaptiveWidth(100),
                          height: helpers.adaptiveHeight(50),
                          child: Center(
                              child: Text(currency.to, style: textStyle)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: helpers.adaptiveWidth(350),
                    height: helpers.adaptiveHeight(170),
                    decoration: BoxDecoration(
                      color: currency.rised ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(helpers.adaptiveHeight(10)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        currency.price.toStringAsFixed(2) + "\$",
                        style: TextStyle(
                          fontSize: helpers.adaptiveHeight(50),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: helpers.adaptiveHeight(50),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var currencyType = await Modal.mainBottomSheet(context);
                      ws.reSub(currencyType);
                    },
                    child: Container(
                      width: helpers.adaptiveWidth(200),
                      height: helpers.adaptiveHeight(70),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(helpers.adaptiveHeight(10)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Изменить подписку",
                          style: TextStyle(
                            fontSize: helpers.adaptiveHeight(15),
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
