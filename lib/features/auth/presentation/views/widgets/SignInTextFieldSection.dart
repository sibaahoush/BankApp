import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../core/functions/custom_validator.dart';
import 'CustomPasswordTextField.dart';

class SignInTextFieldSection extends StatelessWidget {
  const SignInTextFieldSection({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderTextField(
            name: "email",
            keyboardType: TextInputType.emailAddress,
            validator: CustomValidator.emailValidator,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            decoration: const InputDecoration(labelText: 'email'),
          ),
          SizedBox(height: 16),

          CustomPasswordTextField(
            name: 'password',
            label: ' password',
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.newPassword],
          ),
        ],
      ),
    );
  }
}
