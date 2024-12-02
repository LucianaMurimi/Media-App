import 'package:flutter/material.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';


// Authentication CustomInputDecoration
class CustomInputDecoration{
  static InputDecoration textFormFieldStyle({Color fillColor = const Color(0xFFf2f2f2), var prefixIcon="", String labelText="", String hintText=""}) {
    return InputDecoration(
        fillColor: fillColor,
        filled: true,
        prefixIcon: prefixIcon,
        // labelText: labelText,
        labelStyle: const TextStyle(fontSize: 15, color: Color(0xFF323232)),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12.8),
        errorStyle: const TextStyle(fontSize: 12.8, color: Color(0xFF810203)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF6750A4), width: 2)),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFf2f2f2))),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF810203), width: 1.6)),
        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF810203), width: 1.6))
    );
  }
}

// Authentication Button Decoration
class CustomButtonDecoration{
  static BoxDecoration buttonDecorationStyle(bool isPrimary){
    return BoxDecoration(
      border: Border.all(width: 2, color: isPrimary ? ColorManager.white : const Color(0xFF6750A4)),
      borderRadius: BorderRadius.circular(32.0),

      color: isPrimary ? const Color(0xFF6750A4) : ColorManager.white,
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF020202).withOpacity(0.35),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 4), // changes position of shadow
        ),
      ],
    );}
}

//Custom Application Button
class CustomAppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final bool isPrimary;
  final bool showArrow;
  final bool showBorder;

  const CustomAppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.width,
    required this.isPrimary,
    this.showArrow = true,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: width,
      color: isPrimary ? ColorManager.primary : ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        side: showBorder ? BorderSide(color: isPrimary? ColorManager.white : ColorManager.primary, width: 2.0,) :
        BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: isPrimary ? ColorManager.white : ColorManager.primary),),
            showArrow ? const SizedBox(width: 16,) : const SizedBox(),
            showArrow ?
            Icon(Icons.arrow_circle_right_rounded,
                color: isPrimary ? ColorManager.white : ColorManager.primary,
                size: 24) :
            const SizedBox()
          ],
        ),
      ),
    );
  }
}

// CustomInputDecoration
class CustomizedInputDecoration{
  static InputDecoration textFormFieldStyle({prefixIcon, Color fillColor = const Color(0x80f2f2f2), String labelText="",
    String hintText="", suffixIcon, enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80c0c0c0)))}) {
    return InputDecoration(
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: true,
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 15, color: Color(0xFF323232)),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12.8),
        errorStyle: const TextStyle(fontSize: 12.8, color: Color(0xFF810203)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.primary, width: 2)),
        enabledBorder: enabledBorder,
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF810203), width: 1.6)),
        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF810203), width: 1.6))
    );
  }
}