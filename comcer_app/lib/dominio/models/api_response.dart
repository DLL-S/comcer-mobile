// ignore_for_file: file_names

class APIResponse<T> {
  T? data;
  bool? error;
  String? errorMessage;

  APIResponse({this.data, this.errorMessage, this.error = false});
}
