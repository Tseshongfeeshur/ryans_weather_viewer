// 根据剩余天数计算目标日期
({String weekday, String date}) getDateFromPeriod(int daysFromNow) {
  DateTime now = DateTime.now();

  DateTime targetDate = now.add(Duration(days: daysFromNow));

  const weekdayMap = {
    1: '周一',
    2: '周二',
    3: '周三',
    4: '周四',
    5: '周五',
    6: '周六',
    7: '周日',
  };

  String weekday = daysFromNow == 0 ? '今天' : weekdayMap[targetDate.weekday]!;

  String month = targetDate.month.toString();
  String day = targetDate.day.toString();

  return (weekday: weekday, date: '$month/$day');
}
