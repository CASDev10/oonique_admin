import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oonique/modules/dashboard/view/support/cubits/support_cubits.dart';
import 'package:oonique/modules/dashboard/view/support/widget/ticket_table.dart';
import 'package:oonique/ui/input/custom_input_field.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/heights_and_widths.dart';
import 'package:oonique/utils/utils.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../ui/widgets/loading_indicator.dart';
import '../repository/support_repository.dart';

class SupportScreen extends StatelessWidget {
   SupportScreen({super.key, });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SupportsTicketCubit(supportRepository: sl<SupportRepository>())
                ..getAllTickets(),
        ),
      ],
      child: SupportScreenView(),
    );
  }
}

class SupportScreenView extends StatefulWidget {
  final Size? size;

  const SupportScreenView({super.key, this.size});

  @override
  State<SupportScreenView> createState() => _SupportScreenViewState();
}

class _SupportScreenViewState extends State<SupportScreenView> {
  String selectedOption = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportsTicketCubit, SupportsTicketState>(
      builder: (context, state) {
        if (state.bannersState == SupportsTicketStatus.loading) {
          return Center(child: LoadingIndicator());
        }
        return Container(
            padding: const EdgeInsets.all(14),
            height: MediaQuery.of(context).size.height * 0.90,
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tickets Management",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        h0P5,
                        Text(
                          'Manage Tickets',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titlaTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                h2,
                Expanded(
                  child: PaginatedTicketsTable(
                    tickets: state.tickets,
                    totalItems: state.totalItems,
                  ),
                ),
              ],
            ));
      },
    );
  }
}
