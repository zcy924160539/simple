enum CountChangeType {
  increment('+', 1),
  decrement('-', 2);

  final int value;
  final String name;

  const CountChangeType(this.name, this.value);

  factory CountChangeType.format(String typeName) {
    return CountChangeType.values.firstWhere((element) => element.name == typeName);
  }
}
