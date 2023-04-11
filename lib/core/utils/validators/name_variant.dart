import 'package:formz/formz.dart';

class NameVariant extends FormzInput<String, String> {
  const NameVariant.pure([String value = '']) : super.pure(value);
  const NameVariant.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'^(?=.*[a-z])[A-Za-z ]{2,}$',
  );

  @override
  String? validator(String? value) {
    String? errorMessage;

    if (value!.isEmpty) {
      errorMessage = null;
    } else if (!_nameRegExp.hasMatch(value)) {
      errorMessage = 'Name not valid';
    }
    return errorMessage;
  }
}
