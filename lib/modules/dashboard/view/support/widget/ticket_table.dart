import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/config/routes/nav_router.dart';
import 'package:oonique/constants/app_colors.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/utils.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../cubits/support_cubits.dart';
import '../models/all_support_response.dart';
import 'add_response_dialogue.dart';

class PaginatedTicketsTable extends StatefulWidget {
  PaginatedTicketsTable({
    super.key,
    required this.tickets,
    this.onNext,
    this.onPrevious,
    this.width,
    required this.totalItems,
    this.onDelete,
  });
  final int totalItems;
  double? width;
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
        width: widget.width ?? 100,
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
        width: widget.width ?? 100,
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
        width: widget.width ?? 100,
        minWidth: 120,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        width: widget.width ?? 100,
        minWidth: 120,
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
        width: widget.width ?? 150,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: widget.width ?? 150,
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
        width: widget.width ?? 160,
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
        width: widget.width ?? 170,
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
        width: widget.width ?? 100,
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
        width: 100.0,
        type: PlutoColumnType.text(),
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableContextMenu: false,
        renderer: (rendererContext) {
          SupportResponseModel model = rendererContext.cell.value;

          // return PopupMenuButton<String>(
          //   color: AppColors.bgColor,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(6),
          //     side: const BorderSide(color: AppColors.borderColor, width: 1),
          //   ),
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       value: 'view',
          //       child: Text(
          //         'View',
          //         style: context.textTheme.titleSmall?.copyWith(
          //           color: Colors.white,
          //         ),
          //       ),
          //       onTap: () {
          //         if (model.images.isNotEmpty) {
          //           showDialog(
          //             barrierDismissible: false,
          //             context: context,
          //             builder: (context) => Dialog(
          //               backgroundColor: AppColors.dialogBgColor,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(8.0)),
          //               child: Container(
          //                 padding: EdgeInsets.all(14.0),
          //                 width: 500,
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           "Attachment Pictures",
          //                           style: context.textTheme.headlineSmall
          //                               ?.copyWith(
          //                             color: AppColors.white,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                         ),
          //                         OnClick(
          //                           onTap: () {
          //                             NavRouter.pop(context);
          //                           },
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(
          //                                 100.0,
          //                               ),
          //                               border: Border.all(
          //                                 color: Colors.white,
          //                               ),
          //                             ),
          //                             child: Icon(
          //                               Icons.close,
          //                               size: 16.0,
          //                               color: AppColors.white,
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(height: 8.0),
          //                     SingleChildScrollView(
          //                       child: Column(
          //                         children: model.images.map((image) {
          //                           return _imageSection(
          //                             "http://202.166.170.246:4300/${image.image}",
          //                           );
          //                         }).toList(),
          //                       ),
          //                     );
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           );
          //         } else {
          //           DisplayUtils.showSnackBar(
          //             context,
          //             "No Image Attachments",
          //           );
          //         }
          //       },
          //     ),
          //     PopupMenuItem(
          //       value: 'response',
          //       child: Text(
          //         'Add Response',
          //         style: context.textTheme.titleSmall?.copyWith(
          //           color: Colors.white,
          //         ),
          //       ),
          //       onTap: () async {
          //         showDialog(
          //           barrierDismissible: false,
          //           context: context,
          //           builder: (context) => AddResponseDialogue(model: model),
          //         ).then((v) async {
          //           await context.read<SupportsTicketCubit>().getAllTickets();
          //         });
          //       },
          //     ),
          //   ],
          //   offset: const Offset(0, 40),
          //   icon: const Icon(
          //     Icons.more_horiz,
          //     color: AppColors.white,
          //   ),
          // );
          return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          width: 515,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey1),
                            color: AppColors.dialogBgColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8.0,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Text(
                                  "Ticket Info",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "First Name",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          model.firstName,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Last Name",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          model.lastName,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          model.email,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User Id",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          model.userId.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Subject",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    model.subject,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Message",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    model.message,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (model.images.isNotEmpty) ...[
                                Center(
                                  child: Text(
                                    "Attachment",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.3,
                                ),
                                SingleChildScrollView(
                                  child: Row(
                                    spacing: 12.0,
                                    children: model.images.map((image) {
                                      return Expanded(
                                        child: _imageSection(
                                          "http://202.166.170.246:4300/${image.image}",
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                              PrimaryButton(
                                onPressed: () async {
                                  NavRouter.pop(context);
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) =>
                                        AddResponseDialogue(model: model),
                                  ).then((v) async {
                                    await context
                                        .read<SupportsTicketCubit>()
                                        .getAllTickets();
                                  });
                                },
                                title: "Add Response",
                                hMargin: 0,
                                height: 45.0,
                                backgroundColor: Color(0xFFff5556),
                                borderRadius: 12.0,
                              )
                            ],
                          ),
                        ),
                      ));
            },
            child: Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white,
            ),
          );
        },
      ),
    ];

    allRows = widget.tickets.map((ticket) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: ticket.id),
          "userId": PlutoCell(value: ticket.userId),
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
    allRows = widget.tickets.map((ticket) {
      return PlutoRow(
        cells: {
          "message": PlutoCell(value: ticket.message),
          'id': PlutoCell(value: ticket.id),
          "userId": PlutoCell(value: ticket.userId),
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

    return Container(
      color: AppColors.bgColor,
      child: Column(
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
              configuration: PlutoGridConfiguration(
                style: PlutoGridStyleConfig(
                  gridBackgroundColor: Color(0xFF1A1C2C),
                  borderColor: Color(0xFF2E2E38),
                  gridBorderColor: Color(0xFF2E2E38),
                  enableColumnBorderVertical: false,
                  enableColumnBorderHorizontal: false,
                  enableCellBorderVertical: false,
                  enableCellBorderHorizontal: true,
                  enableGridBorderShadow: true,
                  columnTextStyle: TextStyle(
                    color: AppColors.titlaTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                  cellTextStyle: TextStyle(
                    color: AppColors.white,
                  ),
                  rowColor: AppColors.bgColor,

                  inactivatedBorderColor: AppColors.red,
                  activatedColor: Color(0xFF2F3340),
                  // activatedBorderColor: Colors.purpleAccent,
                  activatedBorderColor: AppColors.primaryColor,
                  gridBorderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
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
                Text(
                  'Page $_page',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
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
        border: imagePath.isNotEmpty && imagePath.startsWith('http')
            ? null
            : Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: imagePath.isNotEmpty && imagePath.startsWith('http')
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
