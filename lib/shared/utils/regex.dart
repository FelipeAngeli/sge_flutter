class RegexPatterns {
  static final email = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final telefone = RegExp(r"^\d{10,11}$");
  static final cpfCnpj = RegExp(r"^\d{11}$|^\d{14}$");
}
