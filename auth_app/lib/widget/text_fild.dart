import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/colors.dart';
import '../core/text_style.dart';

typedef OnChangedCallback = Function(String);

Widget textField({
  required TextEditingController controller,
  String Function(String?)? validator,
  OnChangedCallback? onChanged,
  required String hintTxt,
  String? image,
  bool isObs = false,
  TextInputType? keyboardType,
  Widget? prefixIcon,
}) {
  return Container(
    height: 70.0,
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    margin: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 10.0,
    ),
    decoration: BoxDecoration(
      color: blackTextFild,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: (data) {
              if (data !.isEmpty){
                return 'value is wrong';
              }
            },
            textAlignVertical: TextAlignVertical.center,
            obscureText: isObs,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTxt,
              hintStyle: hintStyle,
            ),
            style: headline2,
          ),
        ),

        if (prefixIcon != null) prefixIcon,
        if (image != null)
          SvgPicture.asset(
            'assets/icon/$image',
            height: 24,
            color: grayText,
          ),
      ],
    ),
  );
}