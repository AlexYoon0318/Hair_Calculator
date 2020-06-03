import 'package:dyeingcalculator/color_table.dart';
import 'package:dyeingcalculator/sample_page_22.dart';
import 'package:dyeingcalculator/sample_page.dart';
import 'package:dyeingcalculator/sample_page_23.dart';
import 'package:dyeingcalculator/testing_page.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return SelectingColorPage();
    return ThemeConsumer(child: SamplePage());
  }
}
