import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/main/screens/support/models/all_support_response.dart';
import 'package:oonique/utils/extensions/extended_context.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../ui/widgets/custom_dropdown.dart';
import '../../../../../ui/widgets/helper_function.dart';
import '../../../../../ui/widgets/loading_indicator.dart';
import '../cubits/support_cubits.dart';
import '../repository/support_repository.dart';

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
                  totalItems: 1000,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PaginatedTicketsTable extends StatefulWidget {
  const PaginatedTicketsTable({
    super.key,
    required this.tickets,
    required this.size,
    this.onNext,
    this.onPrevious,
    required this.totalItems,
    this.onDelete,
  });
  final Size size;
  final int totalItems;
  final List<SupportResponseModel> tickets;
  final Function(int)? onNext;
  final Function(int)? onPrevious;
  final Function(int bannerId)? onDelete;
  @override
  State<PaginatedTicketsTable> createState() => _PaginatedTicketsTableState();
}

class _PaginatedTicketsTableState extends State<PaginatedTicketsTable> {
  late final List<PlutoColumn> columns;
  List<PlutoRow> allRows = [];
  PlutoGridStateManager? stateManager;

  int _page = 1;
  int _pageSize = 20;

  @override
  void initState() {
    super.initState();

    columns = [
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableSorting: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        enableColumnDrag: false,
        width: getIdCellSpacingSupport(context, widget.size),
        title: 'ID',

        field: 'id',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'User Id',
        width: getIdCellSpacingSupport(context, widget.size),
        field: 'userId',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'First Name',
        field: 'firstName',
        width: getCellSpacingSupport(context, widget.size),
        minWidth: widget.size.width * 0.07,

        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        width: getCellSpacingSupport(context, widget.size),
        minWidth: widget.size.width * 0.07,
        enableContextMenu: false,
        title: 'Last Name',
        field: 'lastName',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableSorting: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        enableColumnDrag: false,
        title: 'Email',
        field: 'email',
        width: getCellSpacingSupport(context, widget.size),
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: getCellSpacingSupport(context, widget.size),
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Subject',
        field: 'subject',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: getCellSpacingSupport(context, widget.size),
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Message',
        field: 'message',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: getCellSpacingSupport(context, widget.size),
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: getCellSpacingSupport(context, widget.size),
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Attachments',
        field: 'attachments',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        width: 150.0,

        type: PlutoColumnType.text(),
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableContextMenu: false,
        renderer: (rendererContext) {
          return CustomDropDown(
            hint: "Select Status",
            items: ["Pending", "In Progress", "Resolved"],
            onSelect: (v) {
              String status = returnStatus(v);
              print(status);
            },
          );
        },
      ),
      // PlutoColumn(
      //   title: 'View',
      //   field: 'view',
      //   width: getCellSpacingSupport(context, widget.size),
      //
      //   type: PlutoColumnType.text(),
      //   enableColumnDrag: false,
      //   enableDropToResize: false,
      //   enableEditingMode: false,
      //   enableContextMenu: false,
      //   renderer: (rendererContext) {
      //     SupportResponseModel model = rendererContext.cell.value;
      //     return InkWell(
      //       onTap: () {
      //         print(model.toJson());
      //       },
      //       child: Icon(Icons.remove_red_eye),
      //     );
      //   },
      // ),
    ];

    allRows =
        widget.tickets.map((ticket) {
          return PlutoRow(
            cells: {
              'id': PlutoCell(value: ticket.id),
              "userId": PlutoCell(value: ticket.id),
              "message": PlutoCell(value: ticket.message),
              "firstName": PlutoCell(value: ticket.firstName),
              "lastName": PlutoCell(value: ticket.lastName),
              "email": PlutoCell(value: ticket.email),
              "subject": PlutoCell(value: ticket.subject),
              "status": PlutoCell(value: ticket.status),
              "attachments": PlutoCell(value: ticket.images.length.toString()),
              'actions': PlutoCell(value: ticket),
            },
          );
        }).toList();
  }

  void _updateGridRows() {
    if (stateManager == null) return;

    final start = (_page - 1) * _pageSize;
    final end = (_page * _pageSize).clamp(0, allRows.length);
    final currentRows = allRows.sublist(start, end);

    stateManager!
      ..removeAllRows()
      ..appendRows(currentRows);
  }

  @override
  Widget build(BuildContext context) {
    allRows =
        widget.tickets.map((ticket) {
          return PlutoRow(
            cells: {
              "message": PlutoCell(value: ticket.message),
              'id': PlutoCell(value: ticket.id),
              "userId": PlutoCell(value: ticket.id),
              "firstName": PlutoCell(value: ticket.firstName),
              "lastName": PlutoCell(value: ticket.lastName),
              "email": PlutoCell(value: ticket.email),
              "subject": PlutoCell(value: ticket.subject),
              "status": PlutoCell(value: ticket.status),
              "attachments": PlutoCell(value: ticket.images.length.toString()),
              'actions': PlutoCell(value: ticket),
            },
          );
        }).toList();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: PlutoGrid(
              columns: columns,
              rows: [], // initially empty
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
                _updateGridRows(); // load initial page
              },
              configuration: PlutoGridConfiguration(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_page > 1) {
                      final newPage = _page - 1;
                      await widget.onPrevious?.call(
                        newPage,
                      ); // Wait for Bloc state to update
                      setState(() {
                        _page = newPage;
                      });
                    }
                  },
                  child: Text(
                    'Previous',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 16),
                Text('Page $_page'),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_page * _pageSize < widget.totalItems) {
                      final newPage = _page + 1;
                      await widget.onNext?.call(
                        newPage,
                      ); // Wait for Bloc state to update
                      setState(() {
                        _page = newPage;
                      });
                    }
                  },
                  child: Text(
                    'Next',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
