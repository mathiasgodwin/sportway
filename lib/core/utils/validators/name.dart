import 'package:formz/formz.dart';


class Name extends FormzInput<String, String> {
  const Name.pure([String value = '']) : super.pure(value);
  const Name.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'^(?=.*[a-z])[A-Za-z ]{2,}$',
  );

  @override
  String? validator(String? value) {
   String? errorMessage;

    if (value!.isEmpty) {
      errorMessage = 'This field is required';
    } else if (!_nameRegExp.hasMatch(value)) {
      errorMessage = 'Name not valid';
    }
    return errorMessage;
  }
}
