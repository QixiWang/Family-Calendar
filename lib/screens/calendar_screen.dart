import 'dart:ui';

import 'package:flutter/material.dart';

import '../assets/figma_assets.dart';
import '../models/task.dart';
import '../widgets/event_card.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import 'memo_screen.dart';
import 'notifications_screen.dart';
import 'select_family_screen.dart';
import 'settings_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static const bgColor = Color(0xFFFDFBF7);
  static const primaryColor = Color(0xFF0F172A);
  static const accentColor = Color(0xFFE2B736);
  static const secondaryAccent = Color(0xFFFDE047);

  int _selectedDayIndex = 2;
  int _selectedNavIndex = 2;

  final _days = const [
    {'label': 'Mon', 'day': '11'},
    {'label': 'Tue', 'day': '12'},
    {'label': 'Wed', 'day': '13'},
    {'label': 'Thu', 'day': '14'},
    {'label': 'Fri', 'day': '15'},
    {'label': 'Sat', 'day': '16'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 430,
            constraints: const BoxConstraints(maxWidth: 430),
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 50,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    children: [
                      const SizedBox(height: 74),
                      _buildDateSelector(),
                      const SizedBox(height: 8),
                      Expanded(child: _buildTimeline(context)),
                      const SizedBox(height: 94),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _buildHeader(context),
                ),
                Positioned(
                  right: 24,
                  bottom: 112,
                  child: _buildFab(context),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildBottomNav(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header
  Widget _buildHeader(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderAvatars(),
              const Text(
                'December',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                  letterSpacing: -0.5,
                ),
              ),
              _buildNotificationsButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderAvatars() {
    return Row(
      children: [
        _buildAvatar(FigmaAssets.imgMember1),
        const SizedBox(width: 0),
        _buildAvatar(FigmaAssets.imgMember2, overlap: -8),
      ],
    );
  }

  Widget _buildAvatar(String imageUrl, {double overlap = 0}) {
    return Transform.translate(
      offset: Offset(overlap, 0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 18, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const NotificationsScreen()),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.notifications, size: 18, color: primaryColor),
            ),
          ),
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: const BoxDecoration(
                color: Color(0xFFEF4444),
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
              child: const Text(
                '99+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Date selector
  Widget _buildDateSelector() {
    return SizedBox(
      height: 104,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final day = _days[index];
          final selected = index == _selectedDayIndex;

          return GestureDetector(
            onTap: () => setState(() => _selectedDayIndex = index),
            child: Container(
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: selected ? const Color(0x22E2B736) : Colors.white.withOpacity(0.5),
                border: Border.all(
                  color: selected ? accentColor : const Color(0xFFF1F5F9),
                  width: selected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day['label'] as String,
                    style: TextStyle(
                      color: selected ? accentColor : const Color(0xFF64748B),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    day['day'] as String,
                    style: TextStyle(
                      color: selected ? accentColor : primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Timeline
  Widget _buildTimeline(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _timeRow(
              '08:00',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _blueEvent(context),
                  const SizedBox(height: 16),
                  _greenEvent(context),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _timeDivider('09:00'),
            const SizedBox(height: 24),
            _timeRow('10:00', _purpleEvent(context)),
            const SizedBox(height: 24),
            _timeDivider('11:00'),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _timeRow(String time, Widget right) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              time,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }

  Widget _timeDivider(String time) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              time,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(height: 2, width: 282, color: const Color(0xFFF1F5F9)),
      ],
    );
  }

  // Event cards
  Widget _blueEvent(BuildContext context) {
    final task = Task(
      title: 'English Class',
      category: 'Education',
      date: DateTime.now(),
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1, minutes: 30)),
      notes: '',
      participants: ['Mom', 'Dad', 'Sister'],
      reminderEnabled: true,
    );

    return EventCard(
      color: const Color(0xFFE0F2FE),
      category: task.category,
      title: task.title,
      timeRange: '8:00 AM - 9:30 AM',
      participants: task.participants,
      trailingIcon: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.event, size: 18, color: primaryColor),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EditTaskScreen(
              initialTask: task,
              onUpdate: (updated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task updated')),
                );
              },
              onDelete: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task deleted')),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _greenEvent(BuildContext context) {
    final task = Task(
      title: 'Morning Yoga',
      category: 'Health',
      date: DateTime.now(),
      startTime: DateTime.now().add(const Duration(minutes: 30)),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      notes: "Mom's routine",
      participants: ['Mom'],
      reminderEnabled: true,
    );

    return EventCard(
      color: const Color(0xFFECFDF5),
      category: task.category,
      title: task.title,
      timeRange: '8:30 AM',
      participants: task.participants,
      subtitle: task.notes,
      trailingIcon: const SizedBox.shrink(),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EditTaskScreen(
              initialTask: task,
              onUpdate: (updated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task updated')),
                );
              },
              onDelete: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task deleted')),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _purpleEvent(BuildContext context) {
    final task = Task(
      title: 'Grocery Run',
      category: 'Family',
      date: DateTime.now(),
      startTime: DateTime.now().add(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(hours: 1, minutes: 45)),
      notes: "Dad's turn today",
      participants: ['Brother'],
      reminderEnabled: true,
    );

    return EventCard(
      color: const Color(0xFFF3E8FF),
      category: task.category,
      title: task.title,
      timeRange: '10:15 AM - 11:00 AM',
      participants: task.participants,
      subtitle: task.notes,
      trailingIcon: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.shopping_cart, size: 18, color: primaryColor),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EditTaskScreen(
              initialTask: task,
              onUpdate: (updated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task updated')),
                );
              },
              onDelete: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task deleted')),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddTaskScreen()),
        );
      },
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [accentColor, secondaryAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.3),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.add, size: 28, color: Colors.white),
        ),
      ),
    );
  }

  // Bottom navigation
  Widget _buildBottomNav(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            border: const Border(
              top: BorderSide(color: Color(0xFFF1F5F9)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomNavItem(Icons.chat_bubble_outline, 'Memo', 0, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MemoScreen()));
              }),
              _bottomNavItem(Icons.people, 'Family', 1, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SelectFamilyScreen()));
              }),
              _bottomNavItem(Icons.calendar_today, 'Today', 2),
              _bottomNavItem(Icons.settings, 'Settings', 3, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomNavItem(IconData icon, String label, int index, {VoidCallback? onTap}) {
    final selected = index == _selectedNavIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
        onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: selected ? accentColor : const Color(0xFF94A3B8),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? accentColor : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
