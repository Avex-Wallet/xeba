enum ChartDay { D, W, M, Y }

extension ChartDayExtension on ChartDay {
  int get days {
    return switch (this) {
      ChartDay.D => 1,
      ChartDay.W => 7,
      ChartDay.M => 30,
      ChartDay.Y => 365,
    };
  }

  String get label {
    return switch (this) {
      ChartDay.D => '1D',
      ChartDay.W => '1W',
      ChartDay.M => '1M',
      ChartDay.Y => '1Y',
    };
  }
}
