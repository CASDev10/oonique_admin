import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/config/config.dart';
import 'package:oonique/modules/main/screens/support/cubits/update_ticket/update_ticket_cubit.dart';
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
                      size: widget.size,
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
        type: PlutoColumnType.text(),
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
        width: getIdCellSpacingSupport(context, widget.size),
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
          SupportResponseModel model = rendererContext.cell.value;
          return PopupMenuButton<String>(
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'view',
                    child: Text('View'),
                    onTap: () {
                      if (model.images.isNotEmpty) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder:
                              (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),

                                child: Container(
                                  padding: EdgeInsets.all(14.0),
                                  width:
                                      MediaQuery.of(context).size.width >= 1100
                                          ? MediaQuery.of(context).size.width *
                                              0.4
                                          : MediaQuery.of(context).size.width >=
                                              850
                                          ? MediaQuery.of(context).size.width *
                                              0.5
                                          : MediaQuery.of(context).size.width >=
                                              650
                                          ? MediaQuery.of(context).size.width *
                                              0.6
                                          : MediaQuery.of(context).size.width,

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Attachment Pictures",
                                            style: context
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          OnClick(
                                            onTap: () {
                                              NavRouter.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      100.0,
                                                    ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      SingleChildScrollView(
                                        child: Column(
                                          children:
                                              model.images.map((image) {
                                                return _imageSection(
                                                  "http://202.166.170.246:4300/${image.image}",
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        );
                      } else {
                        DisplayUtils.showSnackBar(
                          context,
                          "No Image Attachments",
                        );
                      }
                    },
                  ),
                  PopupMenuItem(
                    value: 'response',
                    child: Text('Add Response'),
                    onTap: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AddResponseDialogue(model: model),
                      ).then((v) async {
                        await context
                            .read<SupportsTicketCubit>()
                            .getAllTickets();
                      });
                    },
                  ),
                ],
            icon: const Icon(Icons.more_vert),
          );
        },
      ),
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
              // 'view': PlutoCell(value: ticket),
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
              // 'view': PlutoCell(value: ticket),
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

  Widget _imageSection(String imagePath) {
    return Container(
      height: 250,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border:
            imagePath.isNotEmpty && imagePath.startsWith('http')
                ? null
                : Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child:
          imagePath.isNotEmpty && imagePath.startsWith('http')
              ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imagePlaceholder(),
              )
              : imagePath.isNotEmpty
              ? Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imagePlaceholder(),
              )
              : _imagePlaceholder(),
    );
  }

  Widget _imagePlaceholder() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
          SizedBox(height: 8),
          Text('No Image Available', style: TextStyle(color: Colors.grey)),
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
