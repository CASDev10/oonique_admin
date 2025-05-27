import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:Column(
        children: [
          Text('404'),
          Text('Page not found')
        ],
      ),
    );
  }
}
