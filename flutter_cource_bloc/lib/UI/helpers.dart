class Helpers {
  static double _height, _width;

  static setSize(double height, double width) {
    _height = height;
    _width = width;
  }

  /// Функции для адаптивных размеров экранов
  static double adaptiveHeight(double size) {
    return _height * (size / 683);
  }

  static double adaptiveWidth(double size) {
    return _width * (size / 411);
  }
}
