class DaysToWord {

  DaysToWord({
    required this.days
  });

  int days;

  String text() {
    if (days == 0) return 'сегодня';
    if (days == 1) return 'завтра';
    if (days == 2) return 'послезавтра';
    if (days < 0) return '- просрочено';
    if (days > 4 && days < 20) return 'через $days дней';
    if (days % 10 == 1) return 'через $days день';
    if (days % 10 < 5 && days % 10 > 1) return 'через $days дня';
    return 'через $days дней';
  }
}