class Currency {
  double price = 0.0;
  String from = "";
  String to = "";
  bool rised = false;
  static Currency _currency;

  factory Currency.empty() {
    _currency = Currency._();
    return _currency;
  }

  factory Currency.fromData(Map<String, dynamic> data) {
    if (_currency == null) {
      _currency = Currency._();
    }
    double newPrice = data["PRICE"].toDouble();
    _currency.rised = newPrice > _currency.price;
    _currency.price = newPrice;
    _currency.from = data['FROMSYMBOL'] ?? _currency.from;
    _currency.to = data["TOSYMBOL"] ?? _currency.to;
    return _currency;
  }

  Currency._();

  @override
  String toString() {
    return "$from -> $to\nPrice = $price";
  }
}
/*
{"TYPE":"5","MARKET":"CCCAGG","FROMSYMBOL":"BTC",
"TOSYMBOL":"USD","FLAGS":2,"PRICE":10948.7,
"LASTUPDATE":1600440262,"LASTVOLUME":0.0267,
"LASTVOLUMETO":292.301187,"LASTTRADEID":
"2280148","VOLUMEDAY":12466.794629350014,
"VOLUMEDAYTO":136555634.82818523,
"VOLUME24HOUR":22470.523340807005,
"VOLUME24HOURTO":245527738.84857687,
"LASTMARKET":"OKCoin","VOLUMEHOUR":1292.1329573579876,
"VOLUMEHOURTO":14136185.365701666,"TOPTIERVOLUME24HOUR":21456.928911290008,
"TOPTIERVOLUME24HOURTO":234433124.73116633}.*/
