import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();
  int width;
  int height;
  bool allowFontScaling;
  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;
  static double _viewInsetsBottom;

  ScreenUtil({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  });

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
    _viewInsetsBottom = mediaQuery.viewInsets.bottom;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  static double get textScaleFactory => _textScaleFactor;

  static double get pixelRatio => _pixelRatio;

  static double get screenWidthDp => _screenWidth;

  static double get screenHeightDp => _screenHeight;

  static double get screenWidth => _screenWidth * _pixelRatio;

  static double get screenHeight => _screenHeight * _pixelRatio;

  static double get statusBarHeight => _statusBarHeight * _pixelRatio;

  static double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  static double get viewInsetsBottom => _viewInsetsBottom;

  static double screenWidthPerc(double percent) =>
      _mediaQueryData.orientation == Orientation.portrait
          ? _screenWidth * (percent / 100)
          : (_screenWidth * (percent / 100)) * 2;

  static double screenHeightPerc(double percent) =>
      mediaQueryData.orientation == Orientation.portrait
          ? _screenHeight * (percent / 100)
          : (_screenHeight * (percent / 100)) * 2;

  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;

  setWidth(int width) => width * scaleWidth;

  setHeight(int height) => height * scaleHeight;

  setSp(int fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}
