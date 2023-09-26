class SigninEmailModel {
  final String email;
  final bool? isValidError;
  final bool? isValidSuccess;

  SigninEmailModel({
    required this.email,
    this.isValidError = false,
    this.isValidSuccess = false
  });

  SigninEmailModel copyWith({String? email, bool? isValidError, bool? isValidSuccess}) {
    return SigninEmailModel(
        email: email ?? this.email,
        isValidError: isValidError ?? this.isValidError,
        isValidSuccess: isValidSuccess ?? this.isValidSuccess
    );
  }
}