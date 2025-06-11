import 'dart:convert';

FiltersResponse filtersResponseFromJson(dynamic json) =>
    FiltersResponse.fromJson(json);

String filtersResponseToJson(FiltersResponse data) =>
    json.encode(data.toJson());

class FiltersResponse {
  String result;
  FilterData data;

  FiltersResponse({required this.result, required this.data});

  FiltersResponse copyWith({String? result, FilterData? data}) =>
      FiltersResponse(result: result ?? this.result, data: data ?? this.data);

  factory FiltersResponse.fromJson(Map<String, dynamic> json) =>
      FiltersResponse(
        result: json["result"],
        data: FilterData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"result": result, "data": data.toJson()};
}

class FilterData {
  List<Filter> filters;

  FilterData({required this.filters});

  FilterData copyWith({List<Filter>? filters}) =>
      FilterData(filters: filters ?? this.filters);

  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
    filters: List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
  };
}

class Filter {
  String key;
  List<String> uniqueValues;

  Filter({required this.key, required this.uniqueValues});

  Filter copyWith({String? key, List<String>? uniqueValues}) => Filter(
    key: key ?? this.key,
    uniqueValues: uniqueValues ?? this.uniqueValues,
  );

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    key: json["key"],
    uniqueValues: List<String>.from(json["unique_values"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "unique_values": List<dynamic>.from(uniqueValues.map((x) => x)),
  };
}
