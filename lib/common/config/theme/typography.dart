import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;

TextStyle headerTitle = GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: appColor.textPrimary
  )
);

TextStyle headerTitleBigger = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: appColor.textPrimary
    )
);

TextStyle bodyTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: appColor.textPrimary
    )
);

TextStyle bodySubtitle = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: appColor.textPrimary
    )
);

TextStyle body = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: appColor.textPrimary
    )
);

TextStyle bodySmall = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: appColor.textPrimary
    )
);

TextStyle bodyGray = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: appColor.textDarkGray
    )
);

TextStyle bodyRed = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: appColor.textButtonRed
    )
);

TextStyle bodyWhite = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: appColor.primaryWhite
    )
);

TextStyle buttonPrimary = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: appColor.primaryWhite
    )
);

TextStyle buttonSecondary = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: appColor.primaryRed
    )
);

TextStyle buttonDisabled = GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: appColor.textLightGray
    )
);