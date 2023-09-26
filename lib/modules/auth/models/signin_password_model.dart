class SigninPasswordModel {
  final String password;
  final bool? isValidError;
  final bool? isValidSuccess;

  SigninPasswordModel({
    required this.password,
    this.isValidError = false,
    this.isValidSuccess = false
  });

  SigninPasswordModel copyWith({
    String? password,
    bool? isValidError,
    bool? isValidSuccess
  }) {
    return SigninPasswordModel(
        password: password ?? this.password,
        isValidError: isValidError ?? this.isValidError,
        isValidSuccess: isValidSuccess ?? this.isValidSuccess
    );
  }
}