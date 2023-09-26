class SignupNameModel {
  final String name;
  final bool? isValidError;
  final bool? isValidSuccess;

  SignupNameModel({
    required this.name,
    this.isValidError = false,
    this.isValidSuccess = false
  });

  SignupNameModel copyWith({String? name, bool? isValidError, bool? isValidSuccess}) {
    return SignupNameModel(
        name: name ?? this.name,
        isValidError: isValidError ?? this.isValidError,
        isValidSuccess: isValidSuccess ?? this.isValidSuccess
    );
  }
}