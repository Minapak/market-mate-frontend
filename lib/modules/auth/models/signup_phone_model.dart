class SignupPhoneModel {
  final String phone;
  final bool? isValidError;
  final bool? isValidSuccess;

  SignupPhoneModel({
    required this.phone,
    this.isValidError = false,
    this.isValidSuccess = false
  });

  SignupPhoneModel copyWith({String? phone, bool? isValidError, bool? isValidSuccess}) {
    return SignupPhoneModel(
        phone: phone ?? this.phone,
        isValidError: isValidError ?? this.isValidError,
        isValidSuccess: isValidSuccess ?? this.isValidSuccess
    );
  }
}