import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformWidget extends StatelessWidget {
  const PlatformWidget({Key key}) : super(key: key);
  Widget buildCupertionWidget(BuildContext context);
  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertionWidget(context);
    }
    return buildMaterialWidget(context);
  }
}
