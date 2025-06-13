import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/dashboard/view/banner/widgets/update_banner_dialogue.dart';
import 'package:oonique/utils/utils.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../../config/routes/nav_router.dart';
import '../../../../../constants/api_endpoints.dart';
import '../../../../../constants/app_colors.dart';
import '../cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import '../cubit/banner_ads_cubit.dart';
import '../models/get_banners_response.dart';

class PaginatedBannersTable extends StatefulWidget {
  PaginatedBannersTable({
    super.key,
    required this.banners,
    this.width,
    this.onNext,
    this.onPrevious,
    required this.totalItems,
    this.onDelete,
  });
  final double? width;
  final int totalItems;
  final List<BannersModel> banners;
  final Function(int)? onNext;
  final Function(int)? onPrevious;
  final Function(int bannerId)? onDelete;
  @override
  State<PaginatedBannersTable> createState() => _PaginatedBannersTableState();
}

class _PaginatedBannersTableState extends State<PaginatedBannersTable> {
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
        width: widget.width ?? 150,
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
        title: 'Image',
        field: 'image',
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          final imageUrl = rendererContext.cell.value ?? '';
          return CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          );
        },
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Title',
        field: 'title',
        width: widget.width ?? 150,
        minWidth: 120,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        width: widget.width ?? 150,
        minWidth: 120,
        enableContextMenu: false,
        title: 'Sub Title',
        field: 'subTitle',
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
        title: 'Order',
        field: 'order',
        width: widget.width ?? 150,
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: widget.width ?? 150,
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
        width: widget.width ?? 150,
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Description',
        field: 'description',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: widget.width ?? 150,
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Category',
        field: 'category',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        width: widget.width ?? 150,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Banner Link',
        field: 'bannerLink',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: widget.width ?? 150,
        suppressedAutoSize: true,
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Created At',
        field: 'createdAt',
        type: PlutoColumnType.text(),
      ),
      // PlutoColumn(
      //   enableColumnDrag: false,
      //   enableDropToResize: false,
      //   width: widget.width??150,
      //   suppressedAutoSize: true,
      //   enableEditingMode: false,
      //   enableContextMenu: false,
      //   title: 'Updated At',
      //   field: 'updatedAt',
      //   type: PlutoColumnType.text(),
      // ),
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        width: widget.width ?? 150,
        type: PlutoColumnType.text(),
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableContextMenu: false,
        renderer: (rendererContext) {
          BannersModel model = rendererContext.cell.value;
          return PopupMenuButton<String>(
            color: AppColors.bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(color: AppColors.borderColor, width: 1),
            ),
            onSelected: (value) {
              final row = rendererContext.row;

              if (value == 'edit') {
                final rowId = row.cells['id']?.value;
                debugPrint('Edit pressed for ID: $rowId');
              } else if (value == 'delete') {
                final rowId = row.cells['id']?.value;
                debugPrint('Delete pressed for ID: $rowId');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Text('✒️ Edit',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    )),
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => UpdateBannerDialogue(
                      model: model,
                      onSave: (input) {
                        context
                            .read<AddUpdateBannerCubit>()
                            .addUpdateBanners(input)
                            .then((v) {
                          NavRouter.pop(context);
                        });
                      },
                    ),
                  ).then((v) {
                    context.read<BannerAdsCubit>().getAllBanners();
                  });
                },
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  '🗑️ Delete',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  await widget.onDelete!(model.id);
                },
              ),
            ],
            offset: const Offset(0, 40),
            icon: const Icon(
              Icons.more_horiz,
              color: AppColors.white,
            ),
          );
        },
      ),
    ];

    allRows = widget.banners.map((banner) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: banner.id),
          'image': PlutoCell(
            value: "${Endpoints.imageBaseUrl}${banner.image}",
          ),
          'title': PlutoCell(value: banner.title),
          'subTitle': PlutoCell(value: banner.subTitle),
          'order': PlutoCell(value: banner.displayOrder),
          'status': PlutoCell(value: banner.status),
          'description': PlutoCell(value: banner.description),
          'bannerLink': PlutoCell(value: banner.bannerLink),
          'category': PlutoCell(value: banner.category),
          'createdAt': PlutoCell(value: banner.createdAt),
          // 'updatedAt': PlutoCell(value: banner.updatedAt),
          'actions': PlutoCell(value: banner),
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
    allRows = widget.banners.map((banner) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: banner.id),
          'image': PlutoCell(
            value: "${Endpoints.imageBaseUrl}${banner.image}",
          ),
          'title': PlutoCell(value: banner.title),
          'subTitle': PlutoCell(value: banner.subTitle),
          'order': PlutoCell(value: banner.displayOrder),
          'category': PlutoCell(value: banner.category),
          'status': PlutoCell(value: banner.status),
          'description': PlutoCell(value: banner.description),
          'bannerLink': PlutoCell(value: banner.bannerLink),
          'createdAt': PlutoCell(value: banner.createdAt),
          // 'updatedAt': PlutoCell(value: banner.updatedAt),
          'actions': PlutoCell(value: banner),
        },
      );
    }).toList();
    return Column(
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
                rowHeight: 100, // Set to desired height
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
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
              Text('Page $_page',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  )),
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
    );
  }
}
