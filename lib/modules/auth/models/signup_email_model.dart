class SignupEmailModel {
  final String email;
  final bool? isValidError;
  final bool? isValidSuccess;
  final bool? isLoading;
  final bool? isError;
  final bool? isSuccess;

  SignupEmailModel({
    required this.email,
    this.isValidError = false,
    this.isValidSuccess = false,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
  });

  SignupEmailModel copyWith({
    String? email,
    bool? isValidError,
    bool? isValidSuccess,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
  }) {
    return SignupEmailModel(
        email: email ?? this.email,
        isValidError: isValidError ?? this.isValidError,
        isValidSuccess: isValidSuccess ?? this.isValidSuccess,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}