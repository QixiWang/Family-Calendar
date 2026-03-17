import 'dart:ui';

import 'package:calendar/screens/calendar_screen.dart';
import 'package:calendar/screens/select_family_screen.dart';
import 'package:flutter/material.dart';

import 'family_screen.dart';
import 'memo_detail_screen.dart';
import 'settings_screen.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({Key? key}) : super(key: key);

  @override
  State<MemoScreen> createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  static const bgColor = Color(0xFFF8F7F6);
  static const primaryColor = Color(0xFF0F172A);
  static const accentColor = Color(0xFFE2B736);
  static const secondaryAccent = Color(0xFFFDE047);
  static const borderColor = Color.fromRGBO(236, 91, 19, 0.05);

  final List<_MemoSection> _sections = const [
    _MemoSection(
      title: 'Today',
      items: [
        _MemoItem(
          title: 'Grocery List for Sunday',
          dateLabel: '2:45 PM',
          body:
              'Milk, organic eggs, sourdough flour, and some fresh lavender for the kitchen window...',
        ),
      ],
    ),
    _MemoSection(
      title: 'Yesterday',
      items: [
        _MemoItem(
          title: 'Grocery List for Sunday',
          dateLabel: '2:45 PM',
          body:
              'Milk, organic eggs, sourdough flour, and some fresh lavender for the kitchen window...',
        ),
      ],
    ),
    _MemoSection(
      title: 'Last Month',
      items: [
        _MemoItem(
          title: 'Sourdough Starter Tips',
          dateLabel: 'Oct 24',
          body:
              'Remember to discard half before feeding. Use filtered water only. Keep in a warm spot near the stove…',
        ),
        _MemoItem(
          title: 'Winter Garden Planning',
          dateLabel: 'Oct 12',
          body:
              'Order garlic bulbs by the end of the week. Mulch the strawberry beds. Check the greenhouse…',
        ),
      ],
    ),
    _MemoSection(
      title: '2025',
      items: [
        _MemoItem(
          title: 'New Year Resolutions',
          dateLabel: 'Jan 01',
          body: 'More time in nature, less time on screens.…',
          opacity: 0.8,
        ),
      ],
    ),
  ];

  int _selectedNavIndex = 0;

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
                      Expanded(child: _buildContent()),
                      const SizedBox(height: 94),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _buildHeader(),
                ),
                Positioned(
                  right: 24,
                  bottom: 112,
                  child: _buildFab(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildBottomNav(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F5).withOpacity(0.8),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Center(
            child: Text(
              'Memos',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: primaryColor,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 128),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _sections
              .map((section) => _buildSection(section))
              .toList(growable: false),
        ),
      ),
    );
  }

  Widget _buildSection(_MemoSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            section.title.toUpperCase(),
            style: const TextStyle(
              color: accentColor,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...section.items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _MemoCard(
                    item: item,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MemoDetailScreen(
                            title: item.title,
                            body: item.body,
                          ),
                        ),
                      );
                    },
                  ),
                ))
            .toList(growable: false),
      ],
    );
  }

  Widget _buildFab() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const MemoDetailScreen(
              title: 'Morning Thoughts',
              body:
                  'Today was a peaceful morning in the garden. The light through the trees felt so soft and golden. I should remember to water the lavender plants this evening and maybe start that new book I bought last weekend. The cottage feels so quiet and still.',
            ),
          ),
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
          child: Icon(
            Icons.edit,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
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
                // Already on Memo
              }),
              _bottomNavItem(Icons.people, 'Family', 1, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SelectFamilyScreen()));
              }),
              _bottomNavItem(Icons.calendar_today, 'Today', 2, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CalendarScreen()));
              }),
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

class _MemoSection {
  final String title;
  final List<_MemoItem> items;

  const _MemoSection({required this.title, required this.items});
}

class _MemoItem {
  final String title;
  final String dateLabel;
  final String body;
  final double opacity;

  const _MemoItem({
    required this.title,
    required this.dateLabel,
    required this.body,
    this.opacity = 1,
  });
}

class _MemoCard extends StatelessWidget {
  final _MemoItem item;
  final VoidCallback? onTap;

  const _MemoCard({Key? key, required this.item, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _MemoScreenState.borderColor),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _MemoScreenState.primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item.dateLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF64748B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );

    final effectiveCard = GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: card,
    );

    if (item.opacity < 1) {
      return Opacity(opacity: item.opacity, child: effectiveCard);
    }

    return effectiveCard;
  }
}
