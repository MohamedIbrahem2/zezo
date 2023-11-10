import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
const kPrimaryColor = Color(0xff4E82A4);

const kTextFieldHeight = 50;
const kHead1Style = TextStyle(
  fontSize: 20,
  color: ColorName.primaryColor,
  fontWeight: FontWeight.bold,
);
const kSemiBoldStyle = TextStyle(
  fontSize: 20,
  color: ColorName.primaryColor,
  fontWeight: FontWeight.w600,
);
const kBody1Style = TextStyle(
  fontSize: 14,
  color: ColorName.textColor2,
);
// add Theme configraiton
final kOutlinePrimaryColor = OutlineInputBorder(
  borderSide: const BorderSide(
    color: ColorName.primaryColor,
  ),
  borderRadius: BorderRadius.circular(4),
);
final theme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(12.5),
    suffixIconColor: ColorName.primaryColor,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: kHead1Style.copyWith(fontSize: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff3636364d), width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff3636364d), width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff3636364d), width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff3636364d), width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  primaryColor: kPrimaryColor,
  fontFamily: 'Cairo',
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
  buttonTheme: const ButtonThemeData(
      // buttonColor: Colors.white,
      // textTheme: ButtonTextTheme.primary,
      // shape: CircleBorder(),
      //  RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(4),
      // ),
      ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xff000000)),
    color: Colors.white,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Cairo',
      color: ColorName.textColor3,
      fontWeight: FontWeight.w700,
      fontSize: 22,
    ),
    elevation: 0,
  ),
  colorScheme: const ColorScheme.light(
    primary: ColorName.primaryColor,

    // onPrimary: kPrimaryLightColor,
    // secondary: kSecondaryColor,
    // onSecondary: kSecondaryLightColor,
    // surface: kSurfaceColor,
    // onSurface: kSurfaceLightColor,
    // background: kBackgroundColor,
    // onBackground: kBackgroundLightColor,
    // error: kErrorColor,
    // onError: kErrorLightColor,
    // brightness: Brightness.light,
  ),
);
const kPadding = EdgeInsets.only(left: 36, right: 36, top: 36);

const primaryColor = Color(0xff0A84E1);
const seocondColor = Color(0xff1AA9A0);
const textStyleWithPrimaryBold = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);
const textStyleWithPrimarySemiBold = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  color: primaryColor,
);

TextStyle textStyleWithSecondBold({double? s}) => TextStyle(
      fontSize: s ?? 20,
      fontWeight: FontWeight.bold,
      color: seocondColor,
    );
const textStyleWithSecondSemiBold = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  color: seocondColor,
);

Widget autoSizeText({
  required String text,
  int maxLines = 1,
  FontWeight fontWeight = FontWeight.w500,
  Color color = Colors.black,
  TextDecoration decoration = TextDecoration.none,
  double size = 20,
  TextAlign align = TextAlign.start,
}) {
  return AutoSizeText(
    text,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Cairo',
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
      height: 1.3,
    ),
    textAlign: align,
    minFontSize: size,
    maxFontSize: size,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
  );
}

class ColorName {
  ColorName._();

  /// Color: #000000
  static const Color black = Color(0xFF000000);

  /// Color: #3468B0
  static const Color primaryColor = Color(0xFF3468B0);
  static const Color secondaryColor = Color.fromARGB(255, 121, 187, 249);

  /// Color: #8F8F8F
  static const Color textColor1 = Color(0xFF8F8F8F);

  /// Color: #414246
  static const Color textColor2 = Color(0xFF414246);

  /// Color: #434343
  static const Color textColor3 = Color(0xFF434343);
}
