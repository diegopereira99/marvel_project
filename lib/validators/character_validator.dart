class CharacterValidator {
  static String? Function(String?)? validateName() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }

      return null;
    };
  }

  static String? Function(String?)? validateDescription() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }

      return null;
    };
  }
}
