class SignupPasswordModel {
  final String password;
  final bool? isValidError;
  final bool? isValidSuccess;

  SignupPasswordModel({
    required this.password,
    this.isValidError = false,
    this.isValidSuccess = false
  });

  SignupPasswordModel copyWith({
    String? password,
    bool? isValidError,
    bool? isValidSuccess
  }) {
    return SignupPasswordModel(
        password: password ?? this.password,
        isValidError: isValidError ?? this.isValidError,
        isValidSuccess: isValidSuccess ?? this.isValidSuccess
    );
  }
}

class SignupPasswordVerifyModel {
  final String passwordVerify;
  final bool? isValidError;
  final bool? isValidSuccess;

  SignupPasswordVerifyModel({
    required this.passwordVerify,
    this.isValidError = false,
    this.isValidSuccess = false
  });

  SignupPasswordVerifyModel copyWith({
    String? passwordVerify,
    bool? isValidError,
    bool? isValidSuccess
  }) {
    return SignupPasswordVerifyModel(
        passwordVerify: passwordVerify ?? this.passwordVerify,
        isValidError: isValidError ?? this.isValidError,
        isValidSuccess: isValidSuccess ?? this.isValidSuccess
    );
  }
}


