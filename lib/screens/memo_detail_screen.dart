import 'dart:ui';

import 'package:flutter/material.dart';

import 'add_task_screen.dart';

class MemoDetailScreen extends StatelessWidget {
  final String title;
  final String body;

  const MemoDetailScreen({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  static const _background = Color(0xFFF8F7F6);
  static const _primaryColor = Color(0xFF0F172A);
  static const _accentColor = Color(0xFFFAC638);
  static const _cardBorder = Color.fromRGBO(250, 198, 56, 0.05);
  static const _bodyText = Color(0xFF334155);

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
                      const SizedBox(height: 89),
                      Expanded(child: _buildContent()),
                      const SizedBox(height: 112),
                    ],
                  ),
                ),
                Positioned(top: 0, left: 0, right: 0, child: _buildAppBar(context)),
                Positioned(
                  left: 46,
                  right: 46,
                  bottom: 20,
                  child: _buildAddTaskButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          height: 89,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F5).withOpacity(0.8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EEE0),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: _primaryColor,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Edit Memo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: _primaryColor,
                      letterSpacing: -0.45,
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: _accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: _accentColor,
                      letterSpacing: 0.35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        children: [
          const SizedBox(height: 39),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _cardBorder),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFAC638).withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(25, 21, 25, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _primaryColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: _bodyText,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddTaskScreen()));
      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
        child: const Center(
          child: Text(
            'Add Task',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
