import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const titleColor = Color(0xFF010F07);
const primaryColor = Color(0xFFFFB700);
const accentColor = Color(0xB8D008);
const bodyTextColor = Color(0xFF868686);
const inputColor = Color(0xFFFBFBFB);

const double defaultPadding = 16;
const Duration kDefaultDuration = Duration(milliseconds: 250);

const TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

const EdgeInsets kTextFieldPadding = EdgeInsets.symmetric(
  horizontal: defaultPadding,
  vertical: defaultPadding,
);

// Text Field Decoration
const OutlineInputBorder kDefaultOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(6)),
  borderSide: BorderSide(
    color: Color(0xFFF3F2F2),
  ),
);

const InputDecoration otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.zero,
  counterText: "",
  errorStyle: TextStyle(height: 0),
);

const kErrorBorderSide = BorderSide(color: Colors.red, width: 1);

// Validator
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-/])',
  //     errorText: 'Passwords must have at least one special character')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: 'Enter a valid email address')
]);

final phoneValidator = MultiValidator([
  RequiredValidator(errorText: 'Phone number is required'),
  PatternValidator(r'^(?:[+0]9)?[0-9]{10}$',
      errorText: 'Enter a valid phone number')
]);

final requiredValidator =
    RequiredValidator(errorText: 'This field is required');
final matchValidator = MatchValidator(errorText: 'passwords do not match');

// Common Text
final Center kOrText = Center(
    child: Text("Or", style: TextStyle(color: titleColor.withOpacity(0.7))));
