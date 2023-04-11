import 'package:formz/formz.dart';

class EmailVariant extends FormzInput<String, String> {
  const EmailVariant.pure() : super.pure('');
  const EmailVariant.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  String? validator(String? value) {
    String? errorMessage;

    if (value!.isEmpty) {
      errorMessage = null;
    } else if (!_emailRegExp.hasMatch(value)) {
      errorMessage = 'Email address not valid';
    }
    return errorMessage;
  }
}
