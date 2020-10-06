bool isNumber(String value) {
  if (value.isEmpty) return false;

  final n = num.tryParse(value);

  return (n == null) ? false : true;
}
