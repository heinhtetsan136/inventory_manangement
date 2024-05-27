class Field<F> {
  final bool isRequired;
  F? data;
  final String? Function(F)? isValid;
  final Function(F)? dispose;
  Field({
    this.data,
    this.isRequired = true,
    this.isValid,
    this.dispose,
  }) : assert(!isRequired && isValid == null || isRequired && isValid != null);
}

String? isValid(List<Field> form) {
  for (dynamic field in form) {
    if (field.isRequired) {
      final value = field.isValid!(field.data);
      if (value != null) {
        return value;
      }
    }
  }
  return null;
}
