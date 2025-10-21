import 'package:flutter/material.dart';

class FieldValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password needs to be at least 6 characters long';
    }
    if (value.length > 100) {
      return 'Password needs to be less than 100 characters';
    }
    return null;
  }

  static String? confirmPasswordValidator(
    String? value,
    TextEditingController passwordController,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value != passwordController.text) {
      return 'Your passwords do not match';
    }

    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      return 'Name cannot contain special characters or numbers';
    }
    if (value.length < 2) {
      return 'Name needs to be at least 2 characters long';
    }
    if (value.length > 50) {
      return 'Name needs to be less than 50 characters';
    }
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    if (value.length > 30) {
      return 'Username must be 30 characters or fewer';
    }

    if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, periods, and underscores';
    }

    if (value.startsWith('.') || value.endsWith('.')) {
      return 'Username cannot start or end with a period';
    }

    if (value.contains('..')) {
      return 'Username cannot have consecutive periods';
    }

    return null;
  }

  static String? timeValidator(String? value, DateTime? date) {
    if (value == null || value.isEmpty) {
      return 'Please enter a time';
    }

    final timeParts = value.split(':');
    if (timeParts.length != 2) {
      return 'Please enter a valid time in format';
    }

    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return 'Please enter a valid time';
    }

    if (date != null) {
      final enteredDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        hour,
        minute,
      );
      final now = DateTime.now();
      if (enteredDateTime.isBefore(now)) {
        return 'Time must be greater than or equal to now';
      }
    }

    return null;
  }

  static String? locationValidator(String? value) {
    final v = value?.trim() ?? '';

    if (v.isEmpty) return 'Please enter a location';

    const pattern = r"^[\p{L}\d\s,'.\-/#&()]+$";

    final reg = RegExp(pattern, unicode: true);

    if (!reg.hasMatch(v)) {
      return 'Only letters, numbers and , . - / # & ( ) are allowed';
    }

    if (v.length < 2) return 'Location must be at least 2 characters long';
    if (v.length > 60) return 'Location must be 60 characters or fewer';

    return null;
  }

  static String? descriptionValidator(String? value) {
    if ((value?.length ?? 0) > 300) {
      return 'Name needs to be smaller than 300 characters';
    }
    return null;
  }

  static String? notNull(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }

    if (value.length > 100) {
      return 'Text needs to be less than 100 characters';
    }
    return null;
  }

  static String? apartmentValidation(String? value) {
    if ((value?.length ?? 0) > 100) {
      return 'Text needs to be less than 100 characters';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    final trimmed = value?.trim() ?? '';

    if (trimmed.isEmpty) {
      return 'Please enter your phone number';
    }

    const pattern =
        r'^(?:\+?\d{1,3})?[ -]?\(?\d{1,4}\)?[ -]?\d{3,4}[ -]?\d{3,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(trimmed)) {
      return 'Please enter a valid phone number';
    }

    if (trimmed.length < 7 || trimmed.length > 15) {
      return 'Phone number must be between 7 and 15 digits';
    }

    return null;
  }

  static String? zipCodeValidator(String? value) {
    final trimmed = value?.trim() ?? '';

    if (trimmed.isEmpty) return 'Please enter a zip code';

    const pattern = r'^[A-Za-z0-9\- ]{3,10}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(trimmed)) {
      return 'Invalid zip code format';
    }

    return null;
  }
}
