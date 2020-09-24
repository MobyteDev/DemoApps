import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'currency.dart';
import 'requests.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum CurrencyType { BTC, ETH, LTC, BCH, XMR, DASH }

class WebSocket {
  WebSocketChannel _channel;
  StreamController<Currency> currencyStreamController =
      StreamController<Currency>();

  static Map<CurrencyType, String> currencyName = {
    CurrencyType.BTC: "BTC",
    CurrencyType.ETH: "ETH",
    CurrencyType.BCH: "BCH",
    CurrencyType.XMR: "XMR",
    CurrencyType.DASH: "DASH",
    CurrencyType.LTC: "LTC",
  };

  CurrencyType _base;

  WebSocket() {
    _setChannel();
    setSubscription(
      CurrencyType.BTC,
    );
  }

  void setSubscription(CurrencyType base) {
    _base = base;
    _sendMessage({
      "action": "SubAdd",
      "subs": ["5~CCCAGG~${currencyName[base]}~USD"]
    });
  }

  void _addDataToCurrencyStream(dynamic data) {
    if (data != null) {
      Map<String, dynamic> currencyValue = jsonDecode(data);
      if (currencyValue["TYPE"] == '5' && currencyValue.containsKey("PRICE")) {
        currencyStreamController.sink.add(Currency.fromData(currencyValue));
      }
    }
  }

  void reSub(CurrencyType base) {
    if (base != null) {
      removeSubscription();
      setSubscription(base);
    }
  }

  void close() {
    currencyStreamController.close();
    _channel.sink.close();
  }

  void removeSubscription() {
    _sendMessage({
      "action": "SubRemove",
      "subs": ["5~CCCAGG~${currencyName[_base]}~USD"]
    });
  }

  void _sendMessage(Map<String, dynamic> message) {
    _channel.sink.add(jsonEncode(message));
  }

  void _setChannel() {
    _channel = IOWebSocketChannel.connect(
        Requests.WSURL + Requests.KEYHELPER + Requests.API_KEY);
    _channel.stream.listen(_addDataToCurrencyStream);
  }

  Stream<Currency> getStream() {
    currencyStreamController.sink.add(Currency.empty());
    return currencyStreamController.stream.asBroadcastStream();
  }
}
