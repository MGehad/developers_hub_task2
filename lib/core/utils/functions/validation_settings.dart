class ValidationSettings {
  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your FullName";
    } else if (value.trim().length < 3) {
      return "Name must be at least 3 characters";
    } else if (!RegExp(
      r"^[a-zA-Z\u0600-\u06FF\s'-]+$",
    ).hasMatch(value.trim())) {
      return "Name can only contain letters spaces";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your Email";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Please enter a valid Email";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a Password";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your Phone Number";
    } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value.trim())) {
      return "Please enter a valid Phone Number";
    }
    return null;
  }

  static String? confirmPasswordValidator({
    String? value,
    required String password,
  }) {
    if (value == null || value.isEmpty) {
      return "Please confirm your Password";
    } else if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }
}
