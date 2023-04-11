import 'package:formz/formz.dart';

class PasswordVariant extends FormzInput<String, String> {
  const PasswordVariant.pure() : super.pure('');
  const PasswordVariant.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp = RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$');

  @override
  String? validator(String? value) {
    String? errorMessage;

    if (value!.isEmpty) {
      errorMessage = null;
    } else if (!_passwordRegExp.hasMatch(value)) {
      errorMessage = 'Password not valid';
    }
    return errorMessage;
  }
}
