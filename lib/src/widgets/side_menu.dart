import 'package:ffms/src/screens/employees/employee_screen.dart';
import 'package:ffms/src/screens/orders/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/delivery/delivery_screen.dart';
import '../screens/expenses/expense_screen.dart';
import '../screens/inventory/inventory_screen.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/reports/reports_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'FFMS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _MenuItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.shopping_cart,
            title: 'Orders',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.restaurant_menu,
            title: 'Menu',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.local_shipping,
            title: 'Delivery',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DeliveryScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.inventory,
            title: 'Inventory',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InventoryScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.people,
            title: 'Employees',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmployeeScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.attach_money,
            title: 'Expenses',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExpenseScreen()),
            ),
          ),
          _MenuItem(
            icon: Icons.bar_chart,
            title: 'Reports',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReportsScreen()),
            ),
          ),
          const Spacer(),
          _MenuItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              context.read<AuthProvider>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
