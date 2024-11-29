import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'insert.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Map<String, dynamic>> Buku = [];

  @override
  void initState() {
    super.initState();
    fetchBuku();
  }

  Future<void> fetchBuku() async {
    final response = await Supabase.instance.client.from('Buku').select();

    setState(() {
      Buku = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // Cream background
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8B560), // Cream-based AppBar
        title: const Text('Perpustakaan'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: fetchBuku,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Buku.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: Buku.length,
                itemBuilder: (context, index) {
                  final dataBuku = Buku[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8DC), // Light cream for card
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataBuku['title'] ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown, // Cream-compatible text color
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Penulis: ${dataBuku['author'] ?? 'Unknown'}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.brown,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          dataBuku['description'] ?? 'No Description',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddBookPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
