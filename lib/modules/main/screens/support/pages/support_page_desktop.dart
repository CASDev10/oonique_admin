import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/main/screens/support/pages/support_page_mobile.dart';
import 'package:oonique/modules/main/screens/support/repository/support_repository.dart';
import 'package:oonique/ui/widgets/loading_indicator.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../core/di/service_locator.dart';
import '../cubits/support_cubits.dart';

class SupportPageDesktop extends StatelessWidget {
  const SupportPageDesktop({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SupportsTicketCubit(supportRepository: sl<SupportRepository>())
                ..getAllTickets(),
      child: SupportPageDesktopView(size: size),
    );
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
      child: BlocBuilder<SupportsTicketCubit, SupportsTicketState>(
        builder: (context, state) {
          if (state.bannersState == SupportsTicketStatus.loading) {
            return Center(child: LoadingIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tickets Management",
                style: context.textTheme.headlineLarge,
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: PaginatedTicketsTable(
                  tickets: state.tickets,
                  size: widget.size,
                  totalItems: 10,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
