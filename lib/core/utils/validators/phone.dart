import 'package:formz/formz.dart';

enum PhoneValidationError {
  invalid,
  empty;

  @override
  String toString() {
    switch (this) {
      case PhoneValidationError.invalid:
        return 'Phone number invalid';
      case PhoneValidationError.empty:
        return 'Phone number required';
      default:
        return 'Phone number invalid';
    }
  }
}

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([String phone = '']) : super.dirty(phone);

  static final _phoneRegExp =
      RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)');
  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneValidationError.empty;
    }
    return _phoneRegExp.hasMatch(value) ? null : PhoneValidationError.invalid;
  }
}

extension Explanaition on PhoneValidationError {
  String get name {
    switch (this) {
      case PhoneValidationError.invalid:
        return 'Phone number invalid';
      case PhoneValidationError.empty:
        return 'Phone number required';
      default:
        return 'Phone number invalid';
    }
  }
}
