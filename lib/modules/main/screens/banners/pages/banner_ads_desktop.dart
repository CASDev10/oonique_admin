import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/main/screens/banners/cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import 'package:oonique/modules/main/screens/banners/cubit/banner_ads_cubit.dart';
import 'package:oonique/modules/main/screens/banners/models/get_banners_response.dart';
import 'package:oonique/modules/main/screens/banners/repositories/repo.dart';
import 'package:oonique/modules/main/screens/banners/widgets/update_banner_dialogue.dart';
import 'package:oonique/ui/widgets/helper_function.dart';
import 'package:oonique/ui/widgets/loading_indicator.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/extensions/extended_context.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../../config/routes/nav_router.dart';
import '../../../../../constants/api_endpoints.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../utils/display/display_utils.dart';

class BannerAdsDesktop extends StatelessWidget {
  const BannerAdsDesktop({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  BannerAdsCubit(bannersRepository: sl<BannersRepository>()),
        ),
        BlocProvider(
          create:
              (context) => AddUpdateBannerCubit(
                bannersRepository: sl<BannersRepository>(),
              ),
        ),
      ],
      child: BannerAdsDesktopView(size: size),
    );
  }
}

class BannerAdsDesktopView extends StatefulWidget {
  const BannerAdsDesktopView({super.key, required this.size});

  final Size size;
  @override
  State<BannerAdsDesktopView> createState() => _BannerAdsDesktopViewState();
}

class _BannerAdsDesktopViewState extends State<BannerAdsDesktopView> {
  @override
  void initState() {
    setState(() {
      context.read<BannerAdsCubit>().getAllBanners();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<BannerAdsCubit, BannerAdsState>(
        builder: (context, state) {
          if (state.bannersState == BannerAdsStatus.loading) {
            return LoadingIndicator();
          }
          return BlocConsumer<AddUpdateBannerCubit, AddUpdateBannerState>(
            builder: (context, addBannerState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Banners Ads Management",
                        style: context.textTheme.headlineLarge,
                      ),
                      SizedBox(
                        width: 120.0,
                        child: PrimaryButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder:
                                  (context) => UpdateBannerDialogue(
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
                          hMargin: 0,
                          height: 45.0,
                          title: "Add Banner",
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: PaginatedBannersTable(
                      onDelete: (v) async {
                        await context
                            .read<BannerAdsCubit>()
                            .deleteBanner(v)
                            .then((v) async {
                              await context
                                  .read<BannerAdsCubit>()
                                  .getAllBanners();
                            });
                      },
                      totalItems: state.totalItems,
                      onNext: (v) async {
                        await context.read<BannerAdsCubit>().getAllBanners(
                          page: v,
                        );
                      },
                      onPrevious: (v) async {
                        await context.read<BannerAdsCubit>().getAllBanners(
                          page: v,
                        );
                      },
                      key: ValueKey(state.allBanners.length),
                      banners: state.allBanners,
                      size: widget.size,
                    ),
                  ),
                ],
              );
            },
            listener: (BuildContext context, AddUpdateBannerState state) {
              if (state.bannersState == AddUpdateBannerStatus.loading) {
                DisplayUtils.showLoader();
              } else if (state.bannersState == AddUpdateBannerStatus.success) {
                DisplayUtils.removeLoader();
              } else if (state.bannersState == AddUpdateBannerStatus.error) {
                DisplayUtils.removeLoader();
              } else {
                DisplayUtils.removeLoader();
              }
            },
          );
        },
      ),
    );
  }
}

class PaginatedBannersTable extends StatefulWidget {
  const PaginatedBannersTable({
    super.key,
    required this.banners,
    required this.size,
    this.onNext,
    this.onPrevious,
    required this.totalItems,
    this.onDelete,
  });
  final Size size;
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
        width: getIdCellSpacing(context, widget.size),
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
            placeholder:
                (context, url) => const SizedBox(
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
        width: getCellSpacing(context, widget.size),
        minWidth: widget.size.width * 0.07,

        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        suppressedAutoSize: true,
        enableEditingMode: false,
        width: getCellSpacing(context, widget.size),
        minWidth: widget.size.width * 0.07,
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
        width: getIdCellSpacing(context, widget.size),
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: getCellSpacing(context, widget.size),

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
        width: getCellSpacing(context, widget.size),
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
        width: getCellSpacing(context, widget.size),
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
        width: getCellSpacing(context, widget.size),
        enableEditingMode: false,
        enableContextMenu: false,
        title: 'Banner Link',
        field: 'bannerLink',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableDropToResize: false,
        width: getCellSpacing(context, widget.size),
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
      //   width: getCellSpacing(context, widget.size),
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
        width: getIdCellSpacing(context, widget.size),

        type: PlutoColumnType.text(),
        enableColumnDrag: false,
        enableDropToResize: false,
        enableEditingMode: false,
        enableContextMenu: false,
        renderer: (rendererContext) {
          BannersModel model = rendererContext.cell.value;
          return PopupMenuButton<String>(
            onSelected: (value) {
              final row = rendererContext.row;

              if (value == 'edit') {
                final rowId = row.cells['id']?.value;
                debugPrint('Edit pressed for ID: $rowId');
              } else if (value == 'delete') {
                // 🗑️ Handle delete logic
                final rowId = row.cells['id']?.value;
                debugPrint('Delete pressed for ID: $rowId');
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('✒️ Edit'),
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder:
                            (context) => UpdateBannerDialogue(
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
                      );
                    },
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('🗑️ Delete'),
                    onTap: () async {
                      await widget.onDelete!(model.id);
                    },
                  ),
                ],
            icon: const Icon(Icons.more_vert),
          );
        },
      ),
    ];

    allRows =
        widget.banners.map((banner) {
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
    allRows =
        widget.banners.map((banner) {
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
              configuration: PlutoGridConfiguration(
                style: PlutoGridStyleConfig(
                  rowHeight: 100, // Set to desired height
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
