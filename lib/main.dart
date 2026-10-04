import 'package:flutter/material.dart';

void main() {
  runApp(const FoodOrderApp());
}

class FoodOrderApp extends StatelessWidget {
  const FoodOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Pemesanan Makanan',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1. HALAMAN LOGIN MOBILE
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Aplikasi Pemesanan Makanan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(onPressed: _login, child: const Text('Login')),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. HALAMAN UTAMA & FORM PEMESANAN
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _orders = [];
  String _selectedMenu = 'Nasi Goreng';
  final _catatanController = TextEditingController();

  void _submitOrder() {
    setState(() {
      _orders.add({
        'menu': _selectedMenu,
        'catatan': _catatanController.text.isEmpty ? '-' : _catatanController.text,
        'status': 'Baru'
      });
    });
    _catatanController.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pesanan Berhasil Dibuat!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pemesanan Makanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Form Pemesanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedMenu,
              items: ['Nasi Goreng', 'Ayam Bakar', 'Mie Goreng'].map((menu) {
                return DropdownMenuItem(value: menu, child: Text(menu));
              }).toList(),
              onChanged: (val) => setState(() => _selectedMenu = val!),
              decoration: const InputDecoration(labelText: 'Pilih Menu', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(controller: _catatanController, decoration: const InputDecoration(labelText: 'Catatan Tambahan', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _submitOrder, child: const Text('Kirim Pesanan')),
            const Divider(height: 32),
            const Text('Daftar Pesanan Saya', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: _orders.isEmpty
                  ? const Center(child: Text('Belum ada pesanan.'))
                  : ListView.builder(
                      itemCount: _orders.length,
                      itemBuilder: (ctx, i) => Card(
                        child: ListTile(
                          title: Text(_orders[i]['menu']!),
                          subtitle: Text('Catatan: ${_orders[i]['catatan']}'),
                          trailing: Chip(label: Text(_orders[i]['status']!)),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}