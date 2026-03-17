import 'dart:ui';

import 'package:flutter/material.dart';

import 'calendar_screen.dart';
import 'create_family_dialog.dart';
import 'family_screen.dart';
import 'memo_screen.dart';
import 'settings_screen.dart';

// Remote avatars (expires after ~7 days from Figma export)
const _avatar1 = 'https://www.figma.com/api/mcp/asset/5dc71948-299e-4b3b-8f45-10afbf1a750a';
const _avatar2 = 'https://www.figma.com/api/mcp/asset/06ff95bd-fcec-4f6d-b260-778a17cbf7ae';
const _avatar3 = 'https://www.figma.com/api/mcp/asset/d1a3cb03-516d-4788-a974-afeeb6c81cc1';
const _avatar4 = 'https://www.figma.com/api/mcp/asset/03802e4e-f495-4b7e-902a-f25d65096656';
const _avatar5 = 'https://www.figma.com/api/mcp/asset/99a00811-045c-47fa-8c19-8bb31fe139a4';
const _avatar6 = 'https://www.figma.com/api/mcp/asset/436113e7-c2dd-46a7-85f6-0bbfb0be1806';
const _avatar7 = 'https://www.figma.com/api/mcp/asset/c4ac9b5a-eb93-4cfe-bde6-ac024476efbd';
const _avatar8 = 'https://www.figma.com/api/mcp/asset/86824d61-0625-4c86-8c95-a942c59dab7b';
const _avatar9 = 'https://www.figma.com/api/mcp/asset/63ffd1a8-2bd8-4239-a051-a79bafc20a76';

// Color constants
const _background = Color(0xFFFCFBF8);
const _cardBg = Color(0xFFFFFFFF);
const _headline = Color(0xFF0F172A);
const _accent = Color(0xFFFAC638);
const _border = Color.fromRGBO(255, 255, 255, 0.2);

class SelectFamilyScreen extends StatefulWidget {
  const SelectFamilyScreen({Key? key}) : super(key: key);

  @override
  State<SelectFamilyScreen> createState() => _SelectFamilyScreenState();
}

class _SelectFamilyScreenState extends State<SelectFamilyScreen> {

  final List<_FamilyGroup> _groups = const [
    _FamilyGroup(
      name: 'Our Cozy Home',
      memberCount: 4,
      avatars: [_avatar1, _avatar2, _avatar3],
      extraCount: 1,
    ),
    _FamilyGroup(
      name: 'Smith Family',
      memberCount: 6,
      avatars: [_avatar4, _avatar5, _avatar6],
      extraCount: 3,
    ),
    _FamilyGroup(
      name: 'Grandma\'s House',
      memberCount: 3,
      avatars: [_avatar7, _avatar8, _avatar9],
      extraCount: 0,
    ),
  ];

  int _selectedNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 430,
            constraints: const BoxConstraints(maxWidth: 430),
            height: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      const SizedBox(height: 77),
                      Expanded(child: _buildList()),
                      const SizedBox(height: 242),
                    ],
                  ),
                ),
                Positioned(top: 0, left: 0, right: 0, child: _buildTopBar()),
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 100,
                  child: _buildCreateFamilyButton(),
                ),
                Positioned(left: 0, right: 0, bottom: 0, child: _buildBottomNav()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 77,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: Text(
          'Select Family',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _headline,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _groups
            .map((group) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _FamilyGroupCard(
                    group: group,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const FamilyScreen()),
                      );
                    },
                  ),
                ))
            .toList(growable: false),
      ),
    );
  }

  Widget _buildCreateFamilyButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _showCreateFamilyDialog,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFFAC638), Color(0xFFF59E0B)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFAC638).withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add, color: Colors.black87, size: 18),
                SizedBox(width: 8),
                Text(
                  'Create New Family',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'You can join another group via invitation link',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  void _showCreateFamilyDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) {
        return const CreateFamilyDialog();
      },
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
              _navItem(Icons.chat_bubble_outline, 'Memo', 0, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MemoScreen()));
              }),
              _navItem(Icons.people, 'Family', 1, onTap: null),
              _navItem(Icons.calendar_today, 'Today', 2, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CalendarScreen()));
              }),
              _navItem(Icons.settings, 'Settings', 3, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index, {VoidCallback? onTap}) {
    final selected = index == _selectedNavIndex;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: selected ? _accent : const Color(0xFF94A3B8),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? _accent : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyGroup {
  final String name;
  final int memberCount;
  final List<String> avatars;
  final int extraCount;

  const _FamilyGroup({
    required this.name,
    required this.memberCount,
    required this.avatars,
    required this.extraCount,
  });
}

class _FamilyGroupCard extends StatelessWidget {
  final _FamilyGroup group;
  final VoidCallback? onTap;

  const _FamilyGroupCard({Key? key, required this.group, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          border: Border.all(color: _border),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: _headline,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${group.memberCount} family members',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _accent,
              ),
            ),
            const SizedBox(height: 16),
            _buildAvatars(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatars() {
    final avatars = group.avatars;
    final children = <Widget>[];
    for (var i = 0; i < avatars.length; i++) {
      children.add(
        Container(
          margin: EdgeInsets.only(left: i == 0 ? 0 : 0),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFCFBF8), width: 2),
          ),
          child: ClipOval(
            child: Image.network(
              avatars[i],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade300),
            ),
          ),
        ),
      );
    }

    if (group.extraCount > 0) {
      children.add(
        Container(
          margin: EdgeInsets.only(left: 0),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _accent.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFCFBF8), width: 2),
          ),
          child: Center(
            child: Text(
              '+${group.extraCount}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: _accent,
              ),
            ),
          ),
        ),
      );
    }

    return Row(children: children);
  }
}
