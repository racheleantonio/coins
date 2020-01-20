import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:testProject/shared/util.dart';

const double _kDayPickerRowHeight = 42.0;
const int _kMaxDayPickerRowCount = 6; // A 31 day month that starts on Saturday.
// Two extra rows: one for the day-of-week header and one for the month header.
const double _kMaxDayPickerHeight =
    _kDayPickerRowHeight * (_kMaxDayPickerRowCount + 2);


class ButtonActions extends StatelessWidget {
  final String negativeBtn;
  final VoidCallback onNegative;
  final String positiveBtn;
  final VoidCallback onPositive;
  final VoidCallback onLeftBtn;
  final MaterialLocalizations localizations;

  const ButtonActions({
    Key key,
    this.negativeBtn,
    @required this.onNegative,
    this.positiveBtn,
    @required this.onPositive,
    this.onLeftBtn,
    @required this.localizations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget negativeButton = FlatButton(
      child: Text(
        negativeBtn ?? localizations.cancelButtonLabel,
        style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
      ),
      onPressed: onNegative,
    );

    final Widget positiveButton = FlatButton(
      child: Text(
        positiveBtn ?? localizations.okButtonLabel,
        style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
      ),
      onPressed: onPositive,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius28),
          bottomRight: Radius.circular(borderRadius28),
        ),
      ),
      child: ButtonBar(
        buttonPadding: EdgeInsets.all(16),
        alignment
            : MainAxisAlignment.spaceAround,
        children: [negativeButton, positiveButton],
      ),
    );
  }
}

// Shows the selected date in large font and toggles between year and day mode


class _DatePickerHeader extends StatelessWidget {
  const _DatePickerHeader({
    Key key,
    @required this.selectedDate,
  })  : assert(selectedDate != null),
        super(key: key);

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    EdgeInsets padding;
    MainAxisAlignment mainAxisAlignment;

    padding = const EdgeInsets.all(16.0);
    mainAxisAlignment = MainAxisAlignment.center;

    final Widget yearButton = Text(
      selectedDate.year.toString(),
      style: TextStyle(fontSize: fontSize18, color: Colors.white),
    );

    final Widget dayButton = Text(
      localizations.formatMediumDate(selectedDate),
      style: TextStyle(fontSize: fontSize24, color: Colors.white),
    );

    BorderRadius borderRadiusData = BorderRadius.only(
      topLeft: Radius.circular(borderRadius28),
      topRight: Radius.circular(borderRadius28),
    );

    return Container(
      decoration: BoxDecoration(
        // gradient: grad,
        borderRadius: borderRadiusData,
      ),
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          yearButton,
          dayButton,
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double viewTileHeight =
        constraints.viewportMainAxisExtent / (_kMaxDayPickerRowCount + 1);
    final double tileHeight = math.max(_kDayPickerRowHeight, viewTileHeight);

    return SliverGridRegularTileLayout(
      crossAxisCount: columnCount,
      mainAxisStride: tileHeight,
      crossAxisStride: tileWidth,
      childMainAxisExtent: tileHeight,
      childCrossAxisExtent: tileWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

const _DayPickerGridDelegate _kDayPickerGridDelegate = _DayPickerGridDelegate();

/// Displays the days of a given month and allows choosing a day.
///
/// The days are arranged in a rectangular grid with one column for each day of
/// the week.
///
/// The day picker widget is rarely used directly. Instead, consider using
/// [showDatePicker], which creates a date picker dialog.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
///  * [showTimePicker], which shows a dialog that contains a material design
///    time picker.
class DayPicker extends StatelessWidget {
  /// Creates a day picker.
  ///
  /// Rarely used directly. Instead, typically used as part of a [MonthPicker].
  DayPicker({
    Key key,
    @required this.selectedDate,
    @required this.currentDate,
    @required this.onChanged,
    @required this.firstDate,
    @required this.lastDate,
    @required this.displayedMonth,
    this.selectableDayPredicate,
    this.locale,
  })  : 
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate selectableDayPredicate;

  final Locale locale;

  /// Builds widgets showing abbreviated days of week. The first widget in the
  /// returned list corresponds to the first day of week for the current locale.
  ///
  /// Examples:
  ///
  /// ```
  /// ┌ Sunday is the first day of week in the US (en_US)
  /// |
  /// S M T W T F S  <-- the returned list contains these widgets
  /// _ _ _ _ _ 1 2
  /// 3 4 5 6 7 8 9
  ///
  /// ┌ But it's Monday in the UK (en_GB)
  /// |
  /// M T W T F S S  <-- the returned list contains these widgets
  /// _ _ _ _ 1 2 3
  /// 4 5 6 7 8 9 10
  /// ```
  List<Widget> _getDayHeaders(
    TextStyle headerStyle,
    MaterialLocalizations localizations,
  ) {
    final List<Widget> result = <Widget>[];
    for (int i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      final String weekday = localizations.narrowWeekdays[i];
      result.add(ExcludeSemantics(
        child: Center(child: Text(weekday, style: headerStyle)),
      ));
      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) break;
    }

    return result;
  }

  // Do not use this directly - call getDaysInMonth instead.

  /// Returns the number of days in a month, according to the proleptic
  /// Gregorian calendar.
  ///
  /// This applies the leap year logic introduced by the Gregorian reforms of
  /// 1582. It will not give valid results for dates prior to that time.

  int _computeFirstDayOffset(
      int year, int month, MaterialLocalizations localizations) {
    // 0-based day of week, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;
    // 0-based day of week, with 0 representing Sunday.
    final int firstDayOfWeekFromSunday = localizations.firstDayOfWeekIndex;
    // firstDayOfWeekFromSunday recomputed to be Monday-based
    final int firstDayOfWeekFromMonday = (firstDayOfWeekFromSunday - 1) % 7;
    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the 1-st of the month.
    return (weekdayFromMonday - firstDayOfWeekFromMonday) % 7;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final int year = displayedMonth.year;
    final int month = displayedMonth.month;
    final int daysInMonth = getDaysInMonth(year, month);
    final int firstDayOffset = _computeFirstDayOffset(
      year,
      month,
      localizations,
    );

    final List<Widget> labels =
        _getDayHeaders(themeData.textTheme.caption, localizations);
    for (int i = 0; true; i += 1) {
      // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
      // a leap year.
      final int day = i - firstDayOffset + 1;
      if (day > daysInMonth) break;
      if (day < 1) {
        labels.add(Container());
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);
        final bool disabled = dayToBuild.isAfter(lastDate) ||
            dayToBuild.isBefore(firstDate) ||
            (selectableDayPredicate != null &&
                !selectableDayPredicate(dayToBuild));

        BoxDecoration decoration;
        TextStyle itemStyle = themeData.textTheme.body1;

        final bool isSelectedDay = selectedDate.year == year &&
            selectedDate.month == month &&
            selectedDate.day == day;
        if (isSelectedDay) {
          // The selected day gets a circle background highlight, and a contrasting text color.
          itemStyle = themeData.accentTextTheme.body2;
          decoration = BoxDecoration(shape: BoxShape.circle, gradient: grad2);
        } else if (disabled) {
          itemStyle = themeData.textTheme.body1.copyWith(
            color: themeData.disabledColor,
          );
        } else if (currentDate.year == year &&
            currentDate.month == month &&
            currentDate.day == day) {
          // The current day gets a different text color.
          itemStyle = themeData.textTheme.body2.copyWith(
            color: Colors.purple,
          );
        }

        Widget dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Semantics(
              // We want the day of month to be spoken first irrespective of the
              // locale-specific preferences or TextDirection. This is because
              // an accessibility user is more likely to be interested in the
              // day of month before the rest of the date, as they are looking
              // for the day of month. To do that we prepend day of month to the
              // formatted full date.
              label:
                  '${localizations.formatDecimal(day)}, ${localizations.formatFullDate(dayToBuild)}',
              selected: isSelectedDay,
              sortKey: OrdinalSortKey(day.toDouble()),
              child: ExcludeSemantics(
                child: Text(localizations.formatDecimal(day), style: itemStyle),
              ),
            ),
          ),
        );

        if (!disabled) {
          dayWidget = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              onChanged(dayToBuild);
            },
            child: dayWidget,
          );
        }

        labels.add(dayWidget);
      }
    }

    String monthYearHeader = "";

    monthYearHeader = localizations.formatMonthYear(displayedMonth);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 76,
              child: Center(
                child: ExcludeSemantics(
                  child: Text(monthYearHeader,
                      style: TextStyle(fontSize: fontSize24)),
                ),
              ),
            ),
            Flexible(
              child: GridView.custom(
                gridDelegate: _kDayPickerGridDelegate,
                childrenDelegate: SliverChildListDelegate(
                  labels,
                  addRepaintBoundaries: false,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthPicker extends StatefulWidget {
  /// Creates a month picker.
  ///
  /// Rarely used directly. Instead, typically used as part of the dialog shown
  /// by [showDatePicker].
  MonthPicker({
    Key key,
    @required this.selectedDate,
    @required this.onChanged,
    @required this.firstDate,
    @required this.lastDate,
    this.selectableDayPredicate,
    this.locale,
  })  : assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(selectedDate.isAfter(firstDate) ||
            selectedDate.isAtSameMomentAs(firstDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a month.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate selectableDayPredicate;

  /// Optional era year.
  final Locale locale;

  @override
  _MonthPickerState createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    // Initially display the pre-selected date.
    final int monthPage = _monthDelta(widget.firstDate, widget.selectedDate);
    _dayPickerController = PageController(initialPage: monthPage);
    _updateCurrentDate();

    // Setup the fade animation for chevrons
    _chevronOpacityController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(MonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      final int monthPage = _monthDelta(widget.firstDate, widget.selectedDate);
      _dayPickerController = PageController(initialPage: monthPage);
    }
  }

  MaterialLocalizations localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
  }

  DateTime _todayDate;
  Timer _timer;
  PageController _dayPickerController;
  AnimationController _chevronOpacityController;

  void _updateCurrentDate() {
    _todayDate = DateTime.now();
    final DateTime tomorrow =
        DateTime(_todayDate.year, _todayDate.month, _todayDate.day + 1);
    Duration timeUntilTomorrow = tomorrow.difference(_todayDate);
    // so we don't miss it by rounding
    timeUntilTomorrow += const Duration(seconds: 1);
    _timer?.cancel();
    _timer = Timer(timeUntilTomorrow, () {
      setState(() => _updateCurrentDate());
    });
  }

  static int _monthDelta(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 +
        endDate.month -
        startDate.month;
  }

  /// Add months to a month truncated date.
  DateTime _addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
    return DateTime(
      monthDate.year + monthsToAdd ~/ 12,
      monthDate.month + monthsToAdd % 12,
    );
  }

  Widget _buildItems(BuildContext context, int index) {
    final DateTime month = _addMonthsToMonthDate(widget.firstDate, index);
    return DayPicker(
      key: ValueKey<DateTime>(month),
      selectedDate: widget.selectedDate,
      currentDate: _todayDate,
      onChanged: widget.onChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      displayedMonth: month,
      selectableDayPredicate: widget.selectableDayPredicate,
      locale: widget.locale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // The month picker just adds month navigation to the day picker, so make
      // it the same height as the DayPicker
      height: _kMaxDayPickerHeight,
      child: Stack(
        children: <Widget>[
          Semantics(
            sortKey: _MonthPickerSortKey.calendar,
            child: NotificationListener<ScrollStartNotification>(
              onNotification: (_) {
                _chevronOpacityController.forward();
                return false;
              },
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (_) {
                  _chevronOpacityController.reverse();
                  return false;
                },
                child: PageView.builder(
                  key: ValueKey<DateTime>(widget.selectedDate),
                  controller: _dayPickerController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _monthDelta(widget.firstDate, widget.lastDate) + 1,
                  itemBuilder: _buildItems,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _chevronOpacityController?.dispose();
    _dayPickerController?.dispose();
    super.dispose();
  }
}

// Defines semantic traversal order of the top-level widgets inside the month
// picker.
class _MonthPickerSortKey extends OrdinalSortKey {
  const _MonthPickerSortKey(double order) : super(order);

  static const _MonthPickerSortKey previousMonth = _MonthPickerSortKey(1.0);
  static const _MonthPickerSortKey nextMonth = _MonthPickerSortKey(2.0);
  static const _MonthPickerSortKey calendar = _MonthPickerSortKey(3.0);
}

class _DatePickerDialog extends StatefulWidget {
  const _DatePickerDialog({
    Key key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.initialDatePickerMode,
    this.locale,
    this.negativeBtn,
    this.positiveBtn,
    this.leftBtn,
    this.onLeftBtn,
  }) : super(key: key);

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final SelectableDayPredicate selectableDayPredicate;
  final DatePickerMode initialDatePickerMode;

  final Locale locale;

  final String negativeBtn;
  final String positiveBtn;
  final String leftBtn;
  final VoidCallback onLeftBtn;

  @override
  _DatePickerDialogState createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<_DatePickerDialog> {
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  bool _announcedInitialDate = false;

  MaterialLocalizations localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    if (!_announcedInitialDate) {
      _announcedInitialDate = true;
    }
  }

  DateTime _selectedDate;
  final GlobalKey _pickerKey = GlobalKey();

  void _vibrate() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        HapticFeedback.vibrate();
        break;
      case TargetPlatform.iOS:
        break;
      case TargetPlatform.macOS:
        break;
    }
  }

  

  void _handleDayChanged(DateTime value) {
    _vibrate();
    setState(() {
      _selectedDate = value;
    });
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  void _handleOk() {
    Navigator.of(context).pop(_selectedDate);
  }

  Widget _buildPicker() {
    return MonthPicker(
      key: _pickerKey,
      selectedDate: _selectedDate,
      onChanged: _handleDayChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      locale: widget.locale,
      selectableDayPredicate: widget.selectableDayPredicate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Widget picker = _buildPicker();

    final Widget actions = ButtonActions(
      negativeBtn: widget.negativeBtn,
      onNegative: _handleCancel,
      positiveBtn: widget.positiveBtn,
      onPositive: _handleOk,
      onLeftBtn: widget.onLeftBtn,
      localizations: localizations,
    );
    final Widget header = _DatePickerHeader(
      selectedDate: _selectedDate,
    );
    final Dialog dialog = Dialog(
        child: Container(
      decoration: BoxDecoration(
        gradient: grad,
        color: theme.dialogBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          header,
          Flexible(child: picker),
          actions,
        ],
      ),
    ));

    return Theme(
      data: theme.copyWith(dialogBackgroundColor: Colors.transparent),
      child: dialog,
    );
  }
}

Future<DateTime> showRoundedDatePicker({
  @required BuildContext context,
  DateTime initialDate,
  DateTime firstDate,
  DateTime lastDate,
  SelectableDayPredicate selectableDayPredicate,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
  Locale locale,
  ThemeData theme,
  bool barrierDismissible = false,
  Color background = Colors.transparent,
  String negativeBtn,
  String positiveBtn,
  String leftBtn,
  VoidCallback onLeftBtn,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= DateTime(initialDate.year - 1);
  lastDate ??= DateTime(initialDate.year + 1);
  theme ??= ThemeData();

  Widget child = GestureDetector(
    onTap: () {
      if (!barrierDismissible) {
        Navigator.pop(context);
      }
    },
    child: Container(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          //
        },
        child: _DatePickerDialog(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          selectableDayPredicate: selectableDayPredicate,
          initialDatePickerMode: initialDatePickerMode,
          locale: locale,
          negativeBtn: negativeBtn,
          positiveBtn: positiveBtn,
          leftBtn: leftBtn,
          onLeftBtn: onLeftBtn,
        ),
      ),
    ),
  );


  if (locale != null) {
    child = Localizations.override(
      context: context,
      locale: locale,
      child: child,
    );
  }

  return await showDialog<DateTime>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => Theme(data: theme, child: child),
  );
}

