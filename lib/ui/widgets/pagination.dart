import 'package:flutter/material.dart';
import 'custom_pagination.dart';

class Pagination extends StatelessWidget {
  final bool isMobile;
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final Function(int) onPageChanged;
  const Pagination(
      {super.key,
      required this.totalDocs,
      required this.limit,
      required this.totalPages,
      required this.page,
      required this.pagingCounter,
      required this.hasPrevPage,
      required this.hasNextPage,
       this.isMobile = false,
      required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return WebPagination(
      currentPage: page,
      totalPage: totalPages,
      displayItemCount: 4,
      isMobile: isMobile,
      onPageChanged: onPageChanged,
    );
  }
}

List<int> getIndexes(int totalPages) {
  List<int> indexes = [];
  for (int i = 0; i == totalPages; i++) {
    indexes.add(i);
  }

  return indexes;
}
