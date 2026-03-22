import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateFamilyDialog extends StatefulWidget {
  const CreateFamilyDialog({Key? key}) : super(key: key);

  @override
  State<CreateFamilyDialog> createState() => _CreateFamilyDialogState();
}

class _CreateFamilyDialogState extends State<CreateFamilyDialog> {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> _findUserByUid(String uid) async {
    final firestore = FirebaseFirestore.instance;

    // 方案1：users 文档 id 就是 uid
    final directDoc = await firestore.collection('users').doc(uid).get();
    if (directDoc.exists) {
      return directDoc.data();
    }

    // 方案2：users 文档里有 uid 字段
    final query = await firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.data();
    }

    return null;
  }

  Future<void> _createFamily() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('Current user is null. Please login first.');
    }

    final familyName = _nameController.text.trim();

    if (familyName.isEmpty) {
      throw Exception('Please enter family name');
    }

    final firestore = FirebaseFirestore.instance;
    final uid = currentUser.uid;
    final now = Timestamp.now();

    final userData = await _findUserByUid(uid);

    final nickname = (
        userData?['nickname'] ??
            userData?['fullName'] ??
            userData?['name'] ??
            userData?['displayName'] ??
            currentUser.displayName ??
            'Unknown User'
    ).toString();

    final userPhotoUrl = (
        userData?['photoURL'] ??
            userData?['photoUrl'] ??
            userData?['avatar'] ??
            currentUser.photoURL ??
            ''
    ).toString().trim();

    // families/{familyId}
    final familyRef = firestore.collection('families').doc();
    final familyId = familyRef.id;

    // families/{familyId}/members/{uid}
    final memberRef = familyRef.collection('members').doc(uid);

    // users/{uid}/families/{familyId}
    final userFamilyRef = firestore
        .collection('users')
        .doc(uid)
        .collection('families')
        .doc(familyId);

    final batch = firestore.batch();

    batch.set(familyRef, {
      'familyId': familyId,
      'familyName': familyName,
      'description': '',
      'createdBy': uid,
      'createdAt': now,
      'updatedAt': now,
      'isArchived': false,
      'photoURL': '',
    });

    batch.set(memberRef, {
      'uid': uid,
      'nickname': nickname,
      'role': 'owner',
      'familyRole': 'owner',
      'status': 'active',
      'joinedAt': now,
    });

    batch.set(userFamilyRef, {
      'familyId': familyId,
      'familyName': familyName,
      'joinedAt': now,
      'role': 'owner',
      'photoURL': userPhotoUrl,
    });

    await batch.commit();
  }

  Future<void> _handleCreate() async {
    if (_isLoading) return;

    try {
      setState(() {
        _isLoading = true;
      });

      await _createFamily();

      if (!mounted) return;
      Navigator.of(context).pop(true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Family created successfully'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', ''),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: GestureDetector(
        onTap: _isLoading ? null : () => Navigator.of(context).pop(),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 340,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Create a family',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: _isLoading
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3EEE0),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Family name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EEE0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _nameController,
                      enabled: !_isLoading,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'e.g. Johnson Family',
                        hintStyle: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _isLoading ? null : _handleCreate,
                    child: Container(
                      width: double.infinity,
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
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          'Create',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}