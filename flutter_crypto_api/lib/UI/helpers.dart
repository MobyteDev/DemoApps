class Helpers {
  double height, width;
  Helpers(this.height, this.width);

  /// Функции для адаптивных размеров экранов
  double adaptiveHeight(double size) {
    return height * (size / 683);
  }

  double adaptiveWidth(double size) {
    return width * (size / 411);
  }
}
