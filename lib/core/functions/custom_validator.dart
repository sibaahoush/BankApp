import 'package:form_builder_validators/form_builder_validators.dart';

class CustomValidator {
  static String? emailValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.email(),
    ])(value);
  }

  static String? passwordValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.minLength(8),
    ])(value);
  }

  static String? confirmPasswordValidator(
    String? password,
    String? confirmPassword,
  ) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.match(
        RegExp('^${RegExp.escape(password ?? '')}\$'),
        errorText: 'كلمتا المرور غير متطابقتين',
      ),
    ])(confirmPassword);
  }

  static String? nameValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.minLength(3),
    ])(value);
  }

  static String? addressValidator(String? value) {
    return FormBuilderValidators.required()(value);
  }

  static String? phoneValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(),
      FormBuilderValidators.minLength(9),
    ])(value);
  }
}
