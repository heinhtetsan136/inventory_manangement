class Field<F> {
  bool isRequired;
  F? input;
  String? Function(F?)? isValid;
  final Function(F?)? dispose;
  Field({
    this.input,
    this.isRequired = true,
    this.isValid,
    this.dispose,
  }) : assert(!isRequired && isValid == null || isRequired && isValid != null) {
    print("${input.toString()} $isRequired ${isValid.toString()}");
  }
}

String? formisValid(List<Field> form) {
  for (dynamic field in form) {
    if (field.isRequired) {
      final value = field.isValid!(field.input);
      print("value is $value");
      if (value != null) {
        return value;
      }
    }
  }
  return null;
}

void formDispose(List<Field> form) {
  print("dispose field");
  for (dynamic field in form) {
    field.dispose?.call(field.input);
  }
}
