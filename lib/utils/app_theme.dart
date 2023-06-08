import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../configs/front_end_configs.dart';

class AppTheme {
  static lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: FrontEndConfigs.kPrimaryColor,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        context.textTheme.apply().copyWith(),
      ),
    );
  }

  static darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: FrontEndConfigs.kPrimaryColor,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme.apply().copyWith(
              titleLarge:
                  context.textTheme.titleLarge!.copyWith(color: Colors.white),
              titleMedium:
                  context.textTheme.titleMedium!.copyWith(color: Colors.white),
              titleSmall:
                  context.textTheme.titleSmall!.copyWith(color: Colors.white),
              headlineLarge: context.textTheme.headlineLarge!
                  .copyWith(color: Colors.white),
              headlineMedium: context.textTheme.headlineMedium!
                  .copyWith(color: Colors.white),
              headlineSmall: context.textTheme.headlineSmall!
                  .copyWith(color: Colors.white),
              bodyLarge:
                  context.textTheme.bodyLarge!.copyWith(color: Colors.white),
              bodyMedium:
                  context.textTheme.bodyMedium!.copyWith(color: Colors.white),
              bodySmall:
                  context.textTheme.bodySmall!.copyWith(color: Colors.white),
              labelLarge:
                  context.textTheme.labelLarge!.copyWith(color: Colors.white),
              labelMedium:
                  context.textTheme.labelMedium!.copyWith(color: Colors.white),
              labelSmall:
                  context.textTheme.labelSmall!.copyWith(color: Colors.white),
            ),
      ),
    );
  }
}
