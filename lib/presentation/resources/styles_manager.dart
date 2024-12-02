import 'package:flutter/material.dart';
import 'package:sccult_media/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(String fontFamily, double fontSize, FontWeight fontWeight, Color color){
  return TextStyle(fontFamily: fontFamily, fontSize: fontSize,fontWeight: fontWeight, color: color);
}

TextStyle getLightStyle({double fontSize = FontSize.s14_8, required Color color}){
  return _getTextStyle(FontFamily.light, fontSize, FontWeightManager.light, color);
}
TextStyle getRegularStyle({double fontSize = FontSize.s14_8, required Color color}){
  return _getTextStyle(FontFamily.regular, fontSize, FontWeightManager.regular, color);
}
TextStyle getMediumStyle({double fontSize = FontSize.s14_8, required Color color}){
  return _getTextStyle(FontFamily.medium, fontSize, FontWeightManager.medium, color);
}
TextStyle getSemiBoldStyle({double fontSize = FontSize.s14_8, required Color color}){
  return _getTextStyle(FontFamily.semiBold, fontSize, FontWeightManager.semiBold, color);
}
TextStyle getUnderlinedStyle({double fontSize = FontSize.s14_8, fontFamily = FontFamily.semiBold, required Color color}){
  return TextStyle(fontFamily: fontFamily, fontSize: fontSize, letterSpacing: 1.2,
      decoration: TextDecoration.underline, color: color);
}
TextStyle getBoldStyle({double fontSize = FontSize.s14_8, required Color color}){
  return _getTextStyle(FontFamily.bold, fontSize, FontWeightManager.bold, color);
}