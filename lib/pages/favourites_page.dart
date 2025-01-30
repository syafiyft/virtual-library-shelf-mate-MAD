import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import 'book_detail.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFFFFBEA),
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Text(
                          'Favourites',
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: favoritesProvider.favorites.length,
                  itemBuilder: (context, index) {
                    final book = favoritesProvider.favorites[index];
                    return ListTile(
                      leading: book['imagePath']!.isNotEmpty
                          ? Image.network(book['imagePath']!)
                          : const Icon(Icons.book),
                      title: Text(book['title']!),
                      subtitle: Text('by ${book['author']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(
                              title: book['title']!,
                              author: book['author']!,
                              description: book['description']!,
                              imagePath: book['imagePath']!,
                              previewLink: book['previewLink']!,
                              rating: book['rating']!,
                              bookId: book['id'] ?? 'Unknown ID',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
