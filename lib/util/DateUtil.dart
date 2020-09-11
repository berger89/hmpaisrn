import 'package:intl/intl.dart';

class DateUtil {
  DateFormat dateFormatUtc = DateFormat("MMMM dd, yyyy hh:mm:ss UTC");

  //yyyy
  DateFormat dateFormatLocal = new DateFormat.yMd().add_Hm();

  DateTime parseUTCtoLocalTimeZone(String startDate) {
    // parse UTC to local time zone
    var parsedDate = dateFormatUtc.parse(startDate, true).toLocal();
    return parsedDate;
  }

  String formatUTCtoLocalTimeZone(DateTime date) {
    // format UTC to local time zone
    var formattedDateyMdHm = dateFormatLocal.format(date);
    return formattedDateyMdHm;
  }

  Duration getRemainingTimeToUTCDate(String dateUtc) {
    // parse UTC to local time zone
    var parsedDate = parseUTCtoLocalTimeZone(dateUtc);
    int endDateMilli = parsedDate.millisecondsSinceEpoch; // set needed date
    int now = DateTime.now().millisecondsSinceEpoch;
    Duration remaining = Duration(milliseconds: endDateMilli - now);
    return remaining;
  }
}
