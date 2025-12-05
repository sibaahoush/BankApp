import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:se3/features/auth/presentation/views/widgets/CustomPasswordTextField.dart';

import '../../../../../core/functions/custom_validator.dart';

class SignUpTextFieldSection extends StatelessWidget {
  const SignUpTextFieldSection({
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
            name: "name",
            decoration: const InputDecoration(label: Text('name')),
            validator: CustomValidator.nameValidator,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
          ),

          const SizedBox(height: 16),
         
          FormBuilderTextField(
            name: " Phone number",
            decoration: const InputDecoration(label: Text('Phone number')),
            keyboardType: TextInputType.phone,
            validator: CustomValidator.phoneValidator,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.telephoneNumber],
          ),

          const SizedBox(height: 16),
        
          FormBuilderTextField(
            name: "email",
            decoration: const InputDecoration(label: Text('email')),
            keyboardType: TextInputType.emailAddress,
            validator: CustomValidator.emailValidator,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
          ),

          const SizedBox(height: 16),
      

          CustomPasswordTextField(
            name: 'password',
            label: ' password',
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.newPassword],
          ),

          const SizedBox(height: 16),
        
          CustomPasswordTextField(
            name: 'password_confirmation',
            label: 'password_confirmation',
            isPasswordConfirm: true,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FormBuilderCheckbox(
              name: 'accept_terms',
              title: const Text('agree to the terms and conditions'),
              initialValue: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
              ),
              validator: FormBuilderValidators.equal(
                true,
                errorText:" Terms and conditions must be agreed upon to continue",
              ),
              // يلتزم بثيم الـ Checkbox من الـ MaterialApp تلقائيًا
            ),
          ),
        ],
      ),
    );
  }
}
