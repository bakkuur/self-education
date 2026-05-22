import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('القائمة', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(title: const Text('الرئيسية'), onTap: () => Navigator.pop(context)),
          ListTile(title: const Text('المواد'), onTap: () => Navigator.pop(context)),
          ListTile(title: const Text('الإعدادات'), onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}