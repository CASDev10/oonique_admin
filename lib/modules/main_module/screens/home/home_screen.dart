import 'package:flutter/material.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../constants.dart';
import 'components/header.dart';
import 'components/my_fields.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      color: context.colorScheme.onPrimary,
      title: 'Oonique | Admin',
      child: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            primary: false,
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Header(title: 'Dashboard'),
                SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(children: [DashBoardCategories()]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
