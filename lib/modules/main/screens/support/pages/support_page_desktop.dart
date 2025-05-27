import 'package:flutter/material.dart';
import 'package:oonique/modules/main/screens/support/pages/support_page_mobile.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

class SupportPageDesktop extends StatelessWidget {
  const SupportPageDesktop({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SupportPageDesktopView(size: size);
  }
}

class SupportPageDesktopView extends StatefulWidget {
  const SupportPageDesktopView({super.key, required this.size});
  final Size size;
  @override
  State<SupportPageDesktopView> createState() => _SupportPageDesktopViewState();
}

class _SupportPageDesktopViewState extends State<SupportPageDesktopView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tickets Management", style: context.textTheme.headlineLarge),
          SizedBox(height: 16.0),
          Expanded(
            child: PaginatedTicketsTable(
              tickets: [],
              size: widget.size,
              totalItems: 10,
            ),
          ),
        ],
      ),
    );
  }
}
