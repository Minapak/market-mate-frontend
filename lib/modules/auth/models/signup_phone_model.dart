class SignupPhoneModel {
  final String phone;
  final bool? isValidError;
  final bool? isValidSuccess;
  final bool? isLoading;
  final bool? isError;
  final bool? isSuccess;

  SignupPhoneModel({
    required this.phone,
    this.isValidError = false,
    this.isValidSuccess = false,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
  });

  // SignupPhoneModel copyWith({String? phone, bool? isValidError, bool? isValidSuccess}) {
  //   return SignupPhoneModel(
  //       phone: phone ?? this.phone,
  //       isValidError: isValidError ?? this.isValidError,
  //       isValidSuccess: isValidSuccess ?? this.isValidSuccess
  //   );

    SignupPhoneModel copyWith({
      String? phone,
      bool? isValidError,
      bool? isValidSuccess,
      bool? isLoading,
      bool? isError,
      bool? isSuccess,
    }) {
      return SignupPhoneModel(
        phone: phone ?? this.phone,
        isValidError: isValidError ?? this.isValidError,
        isValidSuccess: isValidSuccess ?? this.isValidSuccess,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
      );
    }
}