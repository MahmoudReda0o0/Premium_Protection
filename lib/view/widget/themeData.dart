import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class ThemeDataCustom {
  static build() {
    return ThemeData(
      useMaterial3: true,
      checkboxTheme: CheckboxThemeData(
        checkColor:
            WidgetStateProperty.all(Colors.white), // Color of the checkmark
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColor.buttonColor;
            }
            return AppColor.white;
          },
        ),
        side: WidgetStateBorderSide.resolveWith(
          (states) {
            return const BorderSide(
                color: AppColor.buttonColor, width: 2); // Default border
          },
        ),
        shape: RoundedRectangleBorder(
          // Change shape
          borderRadius: BorderRadius.circular(3), // Rounded corners
        ),
      ),
    );
  }
}
