import 'package:flutter/material.dart';

import 'email_validator.dart';

abstract class Validators {
  Validators._();

  static FormFieldValidator<String>? getValidator(TextInputType? keyboardType) {
    return switch (keyboardType) {
      TextInputType.emailAddress => Validators.email,
      TextInputType.number => Validators.number,
      _ => null,
    };
  }

  static String? required(String? input, String message) {
    if (input?.trim().isEmpty ?? true) {
      return message;
    }

    return null;
  }

  static String? validatePhoneNumber(
    String? value,
    String requiredMessage,
    String invalidMessage,
  ) {
    // Regular expression to validate phone number
    final RegExp regex = RegExp(r'^\d{10}$');

    if (value == null || value.isEmpty) {
      return requiredMessage;
    }
    //else if (!regex.hasMatch(value ?? '')) {
    //   return invalidMessage;
    // }
    return null;
  }

  static String? requiredTyped<T>(T? input) {
    if (input == null) {
      return 'Required';
    }

    return null;
  }

  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return "Email Required";
    }

    if (!EmailValidator.validate(email)) {
      return "Invalid Email";
    }

    return null;
  }

  static String? password(String? password, String message) {
    if (password == null || password.isEmpty) {
      return message;
    }

    // if (password.length < 6) {
    //   return 'Password must be at least 6 characters long';
    // }

    // if (!password.contains(RegExp('[A-Z]'))) {
    //   return 'Password must contain at least one capital letter';
    // }

    return null;
  }

  static String? number(String? input) {
    if (input == null || input.isEmpty) {
      return 'Required';
    }

    final number = num.tryParse(input);
    if (number == null) {
      return 'Enter a valid number';
    }

    return null;
  }

  static String? positiveInteger(String? input) {
    if (input == null) {
      return 'Required';
    }

    final integer = int.tryParse(input);
    if (integer == null || integer <= 0) {
      return 'Enter positive integer';
    }

    return null;
  }
}
