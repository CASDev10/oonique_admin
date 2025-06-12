import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/config/config.dart';
import 'package:oonique/modules/dashboard/view/support/cubits/update_ticket/update_ticket_cubit.dart';
import 'package:oonique/ui/widgets/on_click.dart';
// import 'package:oonique/modules/main/screens/support/models/all_support_response.dart';
import 'package:oonique/utils/display/display_utils.dart';
import 'package:oonique/utils/extensions/extended_context.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../ui/widgets/helper_function.dart';
import '../../../../../ui/widgets/loading_indicator.dart';
import '../cubits/support_cubits.dart';
import '../models/all_support_response.dart';
import '../repository/support_repository.dart';
import '../widget/add_response_dialogue.dart';
import '../widget/ticket_table.dart';

class SupportPageMobile extends StatelessWidget {
  const SupportPageMobile({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SupportsTicketCubit(supportRepository: sl<SupportRepository>())
                ..getAllTickets(),
      child: SupportPageMobileView(size: size),
    );
  }
}

class SupportPageMobileView extends StatefulWidget {
  const SupportPageMobileView({super.key, required this.size});
  final Size size;
  @override
  State<SupportPageMobileView> createState() => _SupportPageMobileViewState();
}

class _SupportPageMobileViewState extends State<SupportPageMobileView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: BlocConsumer<UpdateTicketCubit, UpdateTicketState>(
        builder: (context, state) {
          return BlocBuilder<SupportsTicketCubit, SupportsTicketState>(
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
                    
                      totalItems: state.totalItems,
                    ),
                  ),
                ],
              );
            },
          );
        },
        listener: (BuildContext context, UpdateTicketState state) {
          if (state.bannersState == UpdateTicketStatus.loading) {
            DisplayUtils.showLoader();
          } else if (state.bannersState == UpdateTicketStatus.success) {
            DisplayUtils.removeLoader();
          } else if (state.bannersState == UpdateTicketStatus.error) {
            DisplayUtils.removeLoader();
          } else {
            DisplayUtils.removeLoader();
          }
        },
      ),
    );
  }
}


returnStatus(String status) {
  if (status == "Pending") {
    return "pending";
  } else if (status == "In Progress") {
    return "in_progress";
  } else if (status == "Resolved") {
    return "resolved";
  } else {
    return "";
  }
}
