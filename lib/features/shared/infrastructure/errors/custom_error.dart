class CustomError implements Exception {
  final int? code;
  final String message;
  final bool notFoundToken;

  CustomError({
    this.code,
    required this.message,
    this.notFoundToken = false,
  });

  CustomError copyWith({
    int? code,
    String? message,
    bool? notFoundToken,
  }) =>
      CustomError(
        code: code ?? this.code,
        message: message ?? this.message,
        notFoundToken: notFoundToken ?? this.notFoundToken,
      );
}
