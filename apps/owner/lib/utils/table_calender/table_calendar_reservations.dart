// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/util.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/table_calender/utils.dart';
import 'package:owner/utils/utils.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'customization/calendar_builders.dart';
import 'customization/calendar_style.dart';
import 'customization/days_of_week_style.dart';
import 'customization/header_style.dart';
import 'shared/utils.dart';
import 'table_calendar_base.dart';
import 'widgets/calendar_header.dart';
import 'widgets/cell_content.dart';

/// Signature for `onDaySelected` callback. Contains the selected day and focused day.
typedef OnDaySelected = void Function(DateTime selectedDay, DateTime focusedDay);

/// Signature for `onRangeSelected` callback.
/// Contains start and end of the selected range, as well as currently focused day.
typedef OnRangeSelected = void Function(DateTime? start, DateTime? end, DateTime focusedDay);

/// Modes that range selection can operate in.
enum RangeSelectionMode { disabled, toggledOff, toggledOn, enforced }

/// Highly customizable, feature-packed Flutter calendar with gestures, animations and multiple formats.
class TableCalendarReservations<T> extends StatefulWidget {
  /// Locale to format `TableCalendar` dates with, for example: `'en_US'`.
  ///
  /// If nothing is provided, a default locale will be used.
  final dynamic locale;

  /// The start of the selected day range.
  final DateTime? rangeStartDay;

  /// The end of the selected day range.
  final DateTime? rangeEndDay;

  /// DateTime that determines which days are currently visible and focused.
  final DateTime focusedDay;

  /// The first active day of `TableCalendar`.
  /// Blocks swiping to days before it.
  ///
  /// Days before it will use `disabledStyle` and trigger `onDisabledDayTapped` callback.
  final DateTime firstDay;

  /// The last active day of `TableCalendar`.
  /// Blocks swiping to days after it.
  ///
  /// Days after it will use `disabledStyle` and trigger `onDisabledDayTapped` callback.
  final DateTime lastDay;

  /// DateTime that will be treated as today. Defaults to `DateTime.now()`.
  ///
  /// Overriding this property might be useful for testing.
  final DateTime? currentDay;

  /// List of days treated as weekend days.
  /// Use built-in `DateTime` weekday constants (e.g. `DateTime.monday`) instead of `int` literals (e.g. `1`).
  final List<int> weekendDays;

  /// Specifies `TableCalendar`'s current format.
  final CalendarFormat calendarFormat;

  /// `Map` of `CalendarFormat`s and `String` names associated with them.
  /// Those `CalendarFormat`s will be used by internal logic to manage displayed format.
  ///
  /// To ensure proper vertical swipe behavior, `CalendarFormat`s should be in descending order (i.e. from biggest to smallest).
  ///
  /// For example:
  /// ```dart
  /// availableCalendarFormats: const {
  ///   CalendarFormat.month: 'Month',
  ///   CalendarFormat.week: 'Week',
  /// }
  /// ```
  final Map<CalendarFormat, String> availableCalendarFormats;

  /// Determines the visibility of calendar header.
  final bool headerVisible;

  /// Determines the visibility of the row of days of the week.
  final bool daysOfWeekVisible;

  /// When set to true, tapping on an outside day in `CalendarFormat.month` format
  /// will jump to the calendar page of the tapped month.
  final bool pageJumpingEnabled;

  /// When set to true, updating the `focusedDay` will display a scrolling animation
  /// if the currently visible calendar page is changed.
  final bool pageAnimationEnabled;

  /// When set to true, `CalendarFormat.month` will always display six weeks,
  /// even if the content would fit in less.
  final bool sixWeekMonthsEnforced;

  /// When set to true, `TableCalendar` will fill available height.
  final bool shouldFillViewport;

  /// Used for setting the height of `TableCalendar`'s rows.
  final double rowHeight;

  /// Used for setting the height of `TableCalendar`'s days of week row.
  final double daysOfWeekHeight;

  /// Specifies the duration of size animation that takes place whenever `calendarFormat` is changed.
  final Duration formatAnimationDuration;

  /// Specifies the curve of size animation that takes place whenever `calendarFormat` is changed.
  final Curve formatAnimationCurve;

  /// Specifies the duration of scrolling animation that takes place whenever the visible calendar page is changed.
  final Duration pageAnimationDuration;

  /// Specifies the curve of scrolling animation that takes place whenever the visible calendar page is changed.
  final Curve pageAnimationCurve;

  /// `TableCalendar` will start weeks with provided day.
  ///
  /// Use `StartingDayOfWeek.monday` for Monday - Sunday week format.
  /// Use `StartingDayOfWeek.sunday` for Sunday - Saturday week format.
  final StartingDayOfWeek startingDayOfWeek;

  /// `HitTestBehavior` for every day cell inside `TableCalendar`.
  final HitTestBehavior dayHitTestBehavior;

  /// Specifies swipe gestures available to `TableCalendar`.
  /// If `AvailableGestures.none` is used, the calendar will only be interactive via buttons.
  final AvailableGestures availableGestures;

  /// Configuration for vertical swipe detector.
  final SimpleSwipeConfig simpleSwipeConfig;

  /// Style for `TableCalendar`'s header.
  final HeaderStyle headerStyle = HeaderStyle();

  /// Style for days of week displayed between `TableCalendar`'s header and content.
  final DaysOfWeekStyle daysOfWeekStyle;

  /// Style for `TableCalendar`'s content.
  final CalendarStyle calendarStyle = CalendarStyle();

  /// Set of custom builders for `TableCalendar` to work with.
  /// Use those to fully tailor the UI.
  final CalendarBuilders<T> calendarBuilders;

  /// Current mode of range selection.
  ///
  /// * `RangeSelectionMode.disabled` - range selection is always off.
  /// * `RangeSelectionMode.toggledOff` - range selection is currently off, can be toggled by longpressing a day cell.
  /// * `RangeSelectionMode.toggledOn` - range selection is currently on, can be toggled by longpressing a day cell.
  /// * `RangeSelectionMode.enforced` - range selection is always on.
  final RangeSelectionMode rangeSelectionMode;

  /// Function that assigns a list of events to a specified day.
  final List<T> Function(DateTime day)? eventLoader;

  /// Function deciding whether given day should be enabled or not.
  /// If `false` is returned, this day will be disabled.
  final bool Function(DateTime day)? enabledDayPredicate;

  /// Function deciding whether given day should be marked as selected.
  final bool Function(DateTime day)? selectedDayPredicate;

  /// Function deciding whether given day is treated as a holiday.
  final bool Function(DateTime day)? holidayPredicate;

  /// Called whenever a day range gets selected.
  final OnRangeSelected? onRangeSelected;

  /// Called whenever any day gets tapped.
  final OnDaySelected? onDaySelected;

  /// Called whenever any day gets long pressed.
  final OnDaySelected? onDayLongPressed;

  /// Called whenever any disabled day gets tapped.
  final void Function(DateTime day)? onDisabledDayTapped;

  /// Called whenever any disabled day gets long pressed.
  final void Function(DateTime day)? onDisabledDayLongPressed;

  /// Called whenever header gets tapped.
  final void Function(DateTime focusedDay)? onHeaderTapped;

  /// Called whenever header gets long pressed.
  final void Function(DateTime focusedDay)? onHeaderLongPressed;

  /// Called whenever currently visible calendar page is changed.
  final void Function(DateTime focusedDay)? onPageChanged;

  /// Called whenever `calendarFormat` is changed.
  final void Function(CalendarFormat format)? onFormatChanged;

  /// Called when the calendar is created. Exposes its PageController.
  final void Function(PageController pageController)? onCalendarCreated;

  final List<PriceRange> pricesRanges;

  final List<Reservation> reservedRanges;

  final String defaultPrice;

  final String? headerIcon;

  final Function? headerIconAction;

  final bool showFooter;

  /// Creates a `TableCalendar` widget.
  TableCalendarReservations({
    Key? key,
    required DateTime focusedDay,
    required DateTime firstDay,
    required DateTime lastDay,
    required this.pricesRanges,
    required this.reservedRanges,
    required this.defaultPrice,
    DateTime? currentDay,
    this.locale,
    this.rangeStartDay,
    this.rangeEndDay,
    this.weekendDays = const [DateTime.saturday, DateTime.sunday],
    this.calendarFormat = CalendarFormat.month,
    this.availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.twoWeeks: '2 weeks',
      CalendarFormat.week: 'Week',
    },
    this.headerVisible = true,
    this.daysOfWeekVisible = true,
    this.pageJumpingEnabled = true,
    this.pageAnimationEnabled = true,
    this.sixWeekMonthsEnforced = false,
    this.shouldFillViewport = false,
    this.rowHeight = 70.0,
    this.daysOfWeekHeight = 0,
    this.formatAnimationDuration = const Duration(milliseconds: 200),
    this.formatAnimationCurve = Curves.linear,
    this.pageAnimationDuration = const Duration(milliseconds: 300),
    this.pageAnimationCurve = Curves.easeOut,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
    this.dayHitTestBehavior = HitTestBehavior.opaque,
    this.availableGestures = AvailableGestures.all,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    this.daysOfWeekStyle = const DaysOfWeekStyle(),
    this.calendarBuilders = const CalendarBuilders(),
    this.rangeSelectionMode = RangeSelectionMode.toggledOff,
    this.eventLoader,
    this.enabledDayPredicate,
    this.selectedDayPredicate,
    this.holidayPredicate,
    this.onRangeSelected,
    this.onDaySelected,
    this.onDayLongPressed,
    this.onDisabledDayTapped,
    this.onDisabledDayLongPressed,
    this.onHeaderTapped,
    this.onHeaderLongPressed,
    this.onPageChanged,
    this.onFormatChanged,
    this.onCalendarCreated,
    this.headerIcon,
    this.headerIconAction,
    this.showFooter = false,
  })  : assert(availableCalendarFormats.keys.contains(calendarFormat)),
        assert(availableCalendarFormats.length <= CalendarFormat.values.length),
        assert(weekendDays.isNotEmpty ? weekendDays.every((day) => day >= DateTime.monday && day <= DateTime.sunday) : true),
        focusedDay = normalizeDate(focusedDay),
        firstDay = normalizeDate(firstDay),
        lastDay = normalizeDate(lastDay),
        currentDay = currentDay ?? DateTime.now(),
        super(key: key);

  @override
  _TableCalendarReservationsState<T> createState() => _TableCalendarReservationsState<T>();
}

class _TableCalendarReservationsState<T> extends State<TableCalendarReservations<T>> {
  late final PageController _pageController;
  late final ValueNotifier<DateTime> _focusedDay;
  late RangeSelectionMode _rangeSelectionMode;
  DateTime? _firstSelectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(widget.focusedDay);
    _rangeSelectionMode = widget.rangeSelectionMode;
  }

  @override
  void didUpdateWidget(TableCalendarReservations<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_focusedDay.value != widget.focusedDay) {
      _focusedDay.value = widget.focusedDay;
    }

    if (_rangeSelectionMode != widget.rangeSelectionMode) {
      _rangeSelectionMode = widget.rangeSelectionMode;
    }

    if (widget.rangeStartDay == null && widget.rangeEndDay == null) {
      _firstSelectedDay = null;
    }
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  bool get _isRangeSelectionToggleable => _rangeSelectionMode == RangeSelectionMode.toggledOn || _rangeSelectionMode == RangeSelectionMode.toggledOff;

  bool get _isRangeSelectionOn => _rangeSelectionMode == RangeSelectionMode.toggledOn || _rangeSelectionMode == RangeSelectionMode.enforced;

  bool get _shouldBlockOutsideDays => !widget.calendarStyle.outsideDaysVisible && widget.calendarFormat == CalendarFormat.month;

  void _onDayTapped(DateTime day) {
    final isOutside = day.month != _focusedDay.value.month;
    if (isOutside && _shouldBlockOutsideDays) {
      return;
    }

    if (_isDayDisabled(day)) {
      return widget.onDisabledDayTapped?.call(day);
    }

    _updateFocusOnTap(day);

    if (_isRangeSelectionOn && widget.onRangeSelected != null) {
      if (_firstSelectedDay == null) {
        _firstSelectedDay = day;
        widget.onRangeSelected!(_firstSelectedDay, null, _focusedDay.value);
      } else {
        if (isSelectedWithinReservationRange(_firstSelectedDay!, day)) {
          _firstSelectedDay = null;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Those days are already reserved"),
          ));
        } else if (day.isAfter(_firstSelectedDay!)) {
          widget.onRangeSelected!(_firstSelectedDay, day, _focusedDay.value);
          _firstSelectedDay = null;
        } else if (day.isBefore(_firstSelectedDay!)) {
          widget.onRangeSelected!(day, _firstSelectedDay, _focusedDay.value);
          _firstSelectedDay = null;
        }
      }
    } else {
      widget.onDaySelected?.call(day, _focusedDay.value);
    }
  }

  void _onDayLongPressed(DateTime day) {
    final isOutside = day.month != _focusedDay.value.month;
    if (isOutside && _shouldBlockOutsideDays) {
      return;
    }

    if (_isDayDisabled(day)) {
      return widget.onDisabledDayLongPressed?.call(day);
    }

    if (widget.onDayLongPressed != null) {
      _updateFocusOnTap(day);
      return widget.onDayLongPressed!(day, _focusedDay.value);
    }

    if (widget.onRangeSelected != null) {
      if (_isRangeSelectionToggleable) {
        _updateFocusOnTap(day);
        _toggleRangeSelection();

        if (_isRangeSelectionOn) {
          _firstSelectedDay = day;
          widget.onRangeSelected!(_firstSelectedDay, null, _focusedDay.value);
        } else {
          _firstSelectedDay = null;
          widget.onDaySelected?.call(day, _focusedDay.value);
        }
      }
    }
  }

  void _updateFocusOnTap(DateTime day) {
    if (widget.pageJumpingEnabled) {
      _focusedDay.value = day;
      return;
    }

    if (widget.calendarFormat == CalendarFormat.month) {
      if (_isBeforeMonth(day, _focusedDay.value)) {
        _focusedDay.value = _firstDayOfMonth(_focusedDay.value);
      } else if (_isAfterMonth(day, _focusedDay.value)) {
        _focusedDay.value = _lastDayOfMonth(_focusedDay.value);
      } else {
        _focusedDay.value = day;
      }
    } else {
      _focusedDay.value = day;
    }
  }

  void _toggleRangeSelection() {
    if (_rangeSelectionMode == RangeSelectionMode.toggledOn) {
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    } else {
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    }
  }

  void _onLeftChevronTap() {
    _pageController.previousPage(
      duration: widget.pageAnimationDuration,
      curve: widget.pageAnimationCurve,
    );
  }

  void _onRightChevronTap() {
    _pageController.nextPage(
      duration: widget.pageAnimationDuration,
      curve: widget.pageAnimationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: const BorderRadiusDirectional.all(Radius.circular(15))),
      child: Column(
        children: [
          if (widget.headerVisible)
            ValueListenableBuilder<DateTime>(
              valueListenable: _focusedDay,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: widget.headerIcon == null ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                  children: [
                    CalendarHeader(
                      headerTitleBuilder: widget.calendarBuilders.headerTitleBuilder,
                      focusedMonth: value,
                      onLeftChevronTap: _onLeftChevronTap,
                      onRightChevronTap: _onRightChevronTap,
                      onHeaderTap: () => widget.onHeaderTapped?.call(value),
                      onHeaderLongPress: () => widget.onHeaderLongPressed?.call(value),
                      headerStyle: widget.headerStyle,
                      availableCalendarFormats: widget.availableCalendarFormats,
                      calendarFormat: widget.calendarFormat,
                      locale: context.locale.languageCode,
                      onFormatButtonTap: (format) {
                        assert(
                          widget.onFormatChanged != null,
                          'Using `FormatButton` without providing `onFormatChanged` will have no effect.',
                        );

                        widget.onFormatChanged?.call(format);
                      },
                    ),
                    if (widget.headerIcon != null)
                      GestureDetector(
                        child: Container(
                            margin: const EdgeInsetsDirectional.only(end: 14),
                            child: Image.asset(widget.headerIcon!, color: kWhite)),
                        onTap: () {
                          widget.headerIconAction?.call();
                        },
                      ),
                  ],
                );
              },
            ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      isArabic ? "الأحد" : "Sun",
                      style: helveticRegular(color: kWhite, fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      isArabic ? "الأثنين" : "Mon",
                      style: helveticRegular(color: kWhite, fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      isArabic ? "الثلاثاء" : "Tue",
                      style: helveticRegular(color: kWhite, fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      isArabic ? "الأربعاء" : "Wed",
                      style: helveticRegular(color: kWhite, fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      isArabic ? "الخميس" : "Thu",
                      style: helveticRegular(color: kWhite, fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      isArabic ? "الجمعة" : "Fri",
                      style: helveticRegular(color: kWhite, fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      isArabic ? "السبت" : "Sat",
                      style: helveticRegular(color: kWhite, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: widget.shouldFillViewport ? 1 : 0,
            child: TableCalendarBase(
              onCalendarCreated: (pageController) {
                _pageController = pageController;
                widget.onCalendarCreated?.call(pageController);
              },
              focusedDay: _focusedDay.value,
              calendarFormat: widget.calendarFormat,
              availableGestures: widget.availableGestures,
              firstDay: widget.firstDay,
              lastDay: widget.lastDay,
              startingDayOfWeek: widget.startingDayOfWeek,
              dowDecoration: widget.daysOfWeekStyle.decoration,
              rowDecoration: widget.calendarStyle.rowDecoration,
              tableBorder: widget.calendarStyle.tableBorder,
              dowVisible: widget.daysOfWeekVisible,
              dowHeight: widget.daysOfWeekHeight,
              rowHeight: (MediaQuery.of(context).size.width - 26) / 7,
              formatAnimationDuration: widget.formatAnimationDuration,
              formatAnimationCurve: widget.formatAnimationCurve,
              pageAnimationEnabled: widget.pageAnimationEnabled,
              pageAnimationDuration: widget.pageAnimationDuration,
              pageAnimationCurve: widget.pageAnimationCurve,
              availableCalendarFormats: widget.availableCalendarFormats,
              simpleSwipeConfig: widget.simpleSwipeConfig,
              sixWeekMonthsEnforced: widget.sixWeekMonthsEnforced,
              onPageChanged: (focusedDay) {
                _focusedDay.value = focusedDay;
                widget.onPageChanged?.call(focusedDay);
              },
              dowBuilder: (BuildContext context, DateTime day) => null,
              dayBuilder: (context, day, focusedMonth) {
                return GestureDetector(
                  behavior: widget.dayHitTestBehavior,
                  onTap: () => _onDayTapped(day),
                  onLongPress: () => _onDayLongPressed(day),
                  child: _buildCell(day, focusedMonth),
                );
              },
            ),
          ),
          if (widget.showFooter)
            Container(
              margin: const EdgeInsetsDirectional.only(start: 13, end: 13, top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(2)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        LocaleKeys.reserved.tr(),
                        style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(color: reservedGuestColor, borderRadius: BorderRadius.circular(2)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        LocaleKeys.reserved.tr(),
                        style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(color: Theme.of(context).selectedRowColor, borderRadius: BorderRadius.circular(2)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        LocaleKeys.pending.tr(),
                        style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCell(DateTime day, DateTime focusedDay) {
    final isOutside = day.month != focusedDay.month;

    if (isOutside && _shouldBlockOutsideDays) {
      return Container();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final shorterSide = constraints.maxHeight > constraints.maxWidth ? constraints.maxWidth : constraints.maxHeight;

        final children = <Widget>[];

        final isWithinRange =
            widget.rangeStartDay != null && widget.rangeEndDay != null && _isWithinRange(day, widget.rangeStartDay!, widget.rangeEndDay!);

        final isRangeStart = isSameDay(day, widget.rangeStartDay);
        final isRangeEnd = isSameDay(day, widget.rangeEndDay);

        Widget? rangeHighlight = widget.calendarBuilders.rangeHighlightBuilder?.call(context, day, isWithinRange);

        if (rangeHighlight == null) {
          if (isWithinRange) {
            rangeHighlight = Center(
              child: Container(
                margin: EdgeInsetsDirectional.only(
                  start: isRangeStart ? constraints.maxWidth * 0.5 : 0.0,
                  end: isRangeEnd ? constraints.maxWidth * 0.5 : 0.0,
                ),
                height: (shorterSide - widget.calendarStyle.cellMargin.vertical) * widget.calendarStyle.rangeHighlightScale,
                color: widget.calendarStyle.rangeHighlightColor ?? Theme.of(context).primaryColorLight,
              ),
            );
          }
        }

        if (isInReservationState(day)) {
          rangeHighlight = Center(
            child: Container(
              margin: EdgeInsetsDirectional.only(
                start: isRangeStart ? constraints.maxWidth * 0.5 : 0.0,
                end: isRangeEnd ? constraints.maxWidth * 0.5 : 0.0,
              ),
              height: (shorterSide - widget.calendarStyle.cellMargin.vertical) * widget.calendarStyle.rangeHighlightScale,
            ),
          );
        }

        if (rangeHighlight != null) {
          children.add(rangeHighlight);
        }

        final isToday = isSameDay(day, widget.currentDay);
        final isReservedDay = isReserved(day);
        final isReservedDayInPast = isReserved(day) &&
            (day.isBefore(kToday)) ;
        final isPendingDay = isPending(day);
        final isDisabled = _isDayDisabled(day);
        final isWeekend = _isWeekend(day, weekendDays: widget.weekendDays);
        final isFirstDayInReservation = _isFirstDayInReservation(day);
        final isLastDayInReservation = _isLastDayInReservation(day);
        Widget content = CellContent(
          price: getDayPrice(day),
          day: day,
          focusedDay: focusedDay,
          calendarStyle: widget.calendarStyle,
          calendarBuilders: widget.calendarBuilders,
          isTodayHighlighted: widget.calendarStyle.isTodayHighlighted,
          isToday: isToday,
          isSelected: widget.selectedDayPredicate?.call(day) ?? false,
          isRangeStart: isRangeStart,
          isRangeEnd: isRangeEnd,
          isWithinRange: isWithinRange,
          isOutside: isOutside,
          isDisabled: isDisabled,
          isWeekend: isWeekend,
          isHoliday: widget.holidayPredicate?.call(day) ?? false,
          locale: context.locale.languageCode,
          isPending: isPendingDay,
          isReservedByCustomer: isReservedDay && isReservedByCustomer(day) && day.isAfter(kToday),
          isReservedByGuest: isReservedDay && !isReservedByCustomer(day) && day.isAfter(kToday),
          isReservedDayInPast: isReservedDayInPast,
          isFirstDayInReservation: isFirstDayInReservation,
          isLastDayInReservation: isLastDayInReservation,
        );

        children.add(content);

        if (!isDisabled) {
          final events = widget.eventLoader?.call(day) ?? [];
          Widget? markerWidget = widget.calendarBuilders.markerBuilder?.call(context, day, events);

          if (events.isNotEmpty && markerWidget == null) {
            final center = constraints.maxHeight / 2;

            final markerSize =
                widget.calendarStyle.markerSize ?? (shorterSide - widget.calendarStyle.cellMargin.vertical) * widget.calendarStyle.markerSizeScale;

            final markerAutoAlignmentTop =
                center + (shorterSide - widget.calendarStyle.cellMargin.vertical) / 2 - (markerSize * widget.calendarStyle.markersAnchor);

            markerWidget = PositionedDirectional(
              top: widget.calendarStyle.markersAutoAligned ? markerAutoAlignmentTop : widget.calendarStyle.markersOffset.top,
              bottom: widget.calendarStyle.markersAutoAligned ? null : widget.calendarStyle.markersOffset.bottom,
              start: widget.calendarStyle.markersAutoAligned ? null : widget.calendarStyle.markersOffset.start,
              end: widget.calendarStyle.markersAutoAligned ? null : widget.calendarStyle.markersOffset.end,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: events.take(widget.calendarStyle.markersMaxCount).map((event) => _buildSingleMarker(day, event, markerSize)).toList(),
              ),
            );
          }

          if (markerWidget != null) {
            children.add(markerWidget);
          }
        }

        return Stack(
          alignment: widget.calendarStyle.markersAlignment,
          clipBehavior: widget.calendarStyle.canMarkersOverflow ? Clip.none : Clip.hardEdge,
          children: children,
        );
      },
    );
  }

  Widget _buildSingleMarker(DateTime day, T event, double markerSize) {
    return widget.calendarBuilders.singleMarkerBuilder?.call(context, day, event) ??
        Container(
          width: markerSize,
          height: markerSize,
          margin: widget.calendarStyle.markerMargin,
          decoration: widget.calendarStyle.markerDecoration ??
              BoxDecoration(
                  color: const Color(0xFF263238), border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25))),
        );
  }

  bool _isWithinRange(DateTime day, DateTime start, DateTime end) {
    if (isSameDay(day, start) || isSameDay(day, end)) {
      return true;
    }

    if (day.isAfter(start) && day.isBefore(end)) {
      return true;
    }

    return false;
  }

  bool _isDayDisabled(DateTime day) {
    return day.isBefore(widget.firstDay) ||
        day.isAfter(widget.lastDay) ||
        !_isDayAvailable(day) ||
        isInReservationState(day) ||
        _isToday(day);
  }

  bool _isToday(DateTime day) {
    return day.day == kToday.day &&
        day.month == kToday.month &&
        day.year == kToday.year;
  }

  bool _isDayAvailable(DateTime day) {
    return widget.enabledDayPredicate == null ? true : widget.enabledDayPredicate!(day);
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date = month.month < 12 ? DateTime.utc(month.year, month.month + 1) : DateTime.utc(month.year + 1);
    return date.subtract(const Duration(days: 1));
  }

  bool _isBeforeMonth(DateTime day, DateTime month) {
    if (day.year == month.year) {
      return day.month < month.month;
    } else {
      return day.isBefore(month);
    }
  }

  bool _isAfterMonth(DateTime day, DateTime month) {
    if (day.year == month.year) {
      return day.month > month.month;
    } else {
      return day.isAfter(month);
    }
  }

  bool _isWeekend(
    DateTime day, {
    List<int> weekendDays = const [DateTime.saturday, DateTime.sunday],
  }) {
    return weekendDays.contains(day.weekday);
  }

  bool isInReservationState(DateTime day) {
    bool isReserved = false;
    widget.reservedRanges.asMap().forEach((key, value) {
      if (day.month >= value.from!.month && day.month <= value.to!.month) {
        if ((day.isAfter(value.from!) || day.isAtSameMomentAs(value.from!)) && (day.isBefore(value.to!) || day.isAtSameMomentAs(value.to!))) {
          isReserved = true;
        }
      }
    });
    return isReserved;
  }

  bool isReserved(DateTime day) {
    bool isInReservationState = false;
    bool isActuallyReserved = false;
    widget.reservedRanges.asMap().forEach((key, value) {
      if (day.month >= value.from!.month && day.month <= value.to!.month) {
        if ((day.isAfter(value.from!) || day.isAtSameMomentAs(value.from!)) && (day.isBefore(value.to!) || day.isAtSameMomentAs(value.to!))) {
          isInReservationState = true;
          if (value.status == ReservationStatus.approved.name) {
            isActuallyReserved = true;
          }
        }
      }
    });
    return isInReservationState && isActuallyReserved;
  }

  bool isPending(DateTime day) {
    bool isInReservationState = false;
    bool isPending = false;
    widget.reservedRanges.asMap().forEach((key, value) {
      if (day.month >= value.from!.month && day.month <= value.to!.month) {
        if ((day.isAfter(value.from!) || day.isAtSameMomentAs(value.from!)) && (day.isBefore(value.to!) || day.isAtSameMomentAs(value.to!))) {
          isInReservationState = true;
          if (value.status == ReservationStatus.pending.name) {
            isPending = true;
          }
        }
      }
    });
    return isInReservationState && isPending;
  }

  bool isSelectedWithinReservationRange(DateTime start, DateTime end) {
    bool inRange = false;
    for (var i = 0; i < widget.reservedRanges.length; i++) {
      inRange = isInRange(widget.reservedRanges[i], start, end);
      if (inRange) break;
    }
    return inRange;
  }

  bool isInRange(Reservation reservedRange, DateTime start, DateTime end) {
    var selectedRangeStart = start;
    var selectedRangeEnd = end;
    // if start is bigger than end means that the user reversed the range selection like from day 25 to day 21 so we should reverse it to facilitate check
    if (end.isBefore(start)) {
      selectedRangeStart = end;
      selectedRangeEnd = start;
    }
    DateTime reservedRangeStart = reservedRange.from!;
    return (reservedRangeStart.isAfter(selectedRangeStart) || reservedRangeStart.isAtSameMomentAs(selectedRangeStart)) &&
        (reservedRangeStart.isBefore(selectedRangeEnd) ||
            reservedRangeStart.isAtSameMomentAs(selectedRangeEnd)); // is the reserved range start between selected range start and end?
  }

  String getDayPrice(DateTime day) {
    String price = widget.defaultPrice;
    widget.pricesRanges.asMap().forEach((key, value) {
      if ((day.isAfter(value.startDay!) || day.isAtSameMomentAs(value.startDay!)) &&
          (day.isBefore(value.endDay!) || day.isAtSameMomentAs(value.endDay!))) {
        price = value.price!;
      }
    });
    return price;
  }

  bool isReservedByCustomer(DateTime day) {
    final reservation = findReservationByDay(day, widget.reservedRanges);
    return reservation?.customer != null ? true : false;
  }

  bool _isFirstDayInReservation(DateTime day) {
    bool isFirstDay= false;

    widget.reservedRanges.asMap().forEach((key, reservation) {
      if (!isFirstDay) {
        final firstReservationDay = reservation.from;
        isFirstDay = day.year == firstReservationDay?.year &&
            day.month == firstReservationDay?.month &&
            day.day == firstReservationDay?.day;
      }
    });
    return isFirstDay;
  }

  bool _isLastDayInReservation(DateTime day) {
    bool isFirstDay = false;
    widget.reservedRanges.asMap().forEach((key, reservation) {
      if (!isFirstDay) {
        final firstReservationDay = reservation.to;
        isFirstDay = day.year == firstReservationDay?.year &&
            day.month == firstReservationDay?.month &&
            day.day == firstReservationDay?.day;
      }
    });
    return isFirstDay;
  }
}