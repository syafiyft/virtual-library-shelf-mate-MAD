import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import 'book_detail.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _books = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks("bestsellers"); // Fetch random books on page load
  }

  // Fetch books from Google Books API
  Future<void> _fetchBooks(String query) async {
    final apiUrl =
        'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=40';

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Map<String, String>> books = [];

        for (var item in data['items'] ?? []) {
          final volumeInfo = item['volumeInfo'];
          books.add({
            'id': item['id'] ?? 'Unknown ID',
            'title': volumeInfo['title'] ?? 'Unknown Title',
            'author': (volumeInfo['authors'] != null)
                ? volumeInfo['authors'][0]
                : 'Unknown Author',
            'thumbnail': volumeInfo['imageLinks']?['thumbnail'] ?? '',
            'description':
                volumeInfo['description'] ?? 'No description available',
            'previewLink': volumeInfo['previewLink'] ?? '',
            'rating': volumeInfo['averageRating']?.toString() ?? 'N/A',
          });
        }

        setState(() {
          _books = books;
        });
      }
    } catch (error) {
      print('Error fetching books: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Text(
                          'Books',
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Search for books',
                        labelStyle: const TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Color(0xFFFFCF23),
                            size: 28,
                          ),
                          onPressed: () {
                            if (_searchController.text.isNotEmpty) {
                              _fetchBooks(_searchController.text);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _books.isEmpty
                        ? const Center(
                            child: Text(
                              'No books found. Try searching for something else!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GridView.builder(
                              itemCount: _books.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) {
                                return BookItem(
                                  title: _books[index]['title']!,
                                  author: _books[index]['author']!,
                                  thumbnail: _books[index]['thumbnail']!,
                                  description: _books[index]['description']!,
                                  previewLink: _books[index]['previewLink']!,
                                  rating: _books[index]['rating']!,
                                  id: _books[index]['id'] ?? 'Unknown ID',
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  final String title;
  final String author;
  final String thumbnail;
  final String description;
  final String previewLink;
  final String rating;
  final String id;

  const BookItem({
    super.key,
    required this.title,
    required this.author,
    required this.thumbnail,
    required this.description,
    required this.previewLink,
    required this.rating,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              title: title,
              author: author,
              description: description,
              imagePath: thumbnail,
              previewLink: previewLink,
              rating: rating,
              bookId: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              thumbnail,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Afacad',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
