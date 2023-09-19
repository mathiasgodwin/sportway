import 'package:formz/formz.dart';

class Password extends FormzInput<String, String> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp = RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$');

  @override
  String? validator(String? value) {
    String? errorMessage;

    if (value!.isEmpty) {
      errorMessage = 'This field is required';
    } else if (!_passwordRegExp.hasMatch(value)) {
      errorMessage = 'Password not valid';
    }
    return errorMessage;
  }
}
