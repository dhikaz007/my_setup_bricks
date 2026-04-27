// part 'response_api_model.freezed.dart';
// part 'response_api_model.g.dart';

// @Freezed(genericArgumentFactories: true)
// sealed class ResponseAPI<T> with _$ResponseAPI<T> {
//   const factory ResponseAPI({
//     String? message,
//     int? statusCode,
//     T? data,
//   }) = _ResponseAPI<T>;

//   factory ResponseAPI.fromJson(
//     Map<String, dynamic> json,
//     T Function(Object? json) fromJsonT,
//   ) =>
//       _$ResponseAPIFromJson(json, fromJsonT);
// }

// @Freezed(genericArgumentFactories: true)
// sealed class PaginationResponseAPI<T> with _$PaginationResponseAPI<T> {
//   const factory PaginationResponseAPI({
//     String? message,
//     int? statusCode,
//     @Default('0') String page,
//     @Default(1) @JsonKey(name: 'page_count') int pageCount,
//     @JsonKey(name: 'page_size') String? pageSize,
//     int? total,
//     @Default([]) List<T> data,
//     @JsonKey(name: 'max_page_size') int? maxPageSize,
//   }) = _PaginationResponseAPI<T>;


//   factory PaginationResponseAPI.fromDynamicJson(
//     Map<String, dynamic> json,
//     T Function(Object? json) fromJsonT,
//     String dataKey, // Contoh: 'memo.list' atau 'data'
//   ) {
//     final adjustedJson = Map<String, dynamic>.from(json);

//     // Logic untuk menangani dot notation (misal: 'memo.list')
//     dynamic rawData;
//     if (dataKey.contains('.')) {
//       List<String> keys = dataKey.split('.');
//       dynamic current = json;
//       for (var key in keys) {
//         if (current is Map && current.containsKey(key)) {
//           current = current[key];
//         } else {
//           current = [];
//           break;
//         }
//       }
//       rawData = current;
//     } else {
//       rawData = json[dataKey] ?? [];
//     }

//     adjustedJson['data'] = rawData;

//     return PaginationResponseAPI.fromJson(adjustedJson, fromJsonT);
//   }

//   factory PaginationResponseAPI.fromJson(
//     Map<String, dynamic> json,
//     T Function(Object? json) fromJsonT,
//   ) =>
//       _$PaginationResponseAPIFromJson(json, fromJsonT);
// }
