class TopUpOption {
  TopUpOption._();

  /// The explicitly allowed top-up amounts (in AED).
  static const List<double> validOptions = [
    5.0,
    10.0,
    20.0,
    30.0,
    50.0,
    75.0,
    100.0,
  ];

  /// The mandatory fee applied to every top-up transaction.
  static const double transactionFee = 3.0;
}
