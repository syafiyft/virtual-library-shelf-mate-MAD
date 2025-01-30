import 'package:flutter/material.dart';
import 'books_page.dart';
import 'favourites_page.dart';
import 'settings_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const BooksPage(),
    const FavouritesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      // Show the current page based on selected index
      bottomNavigationBar: Material(
        elevation: 10,
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: SizedBox(
            height: 108,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                // Highlight the current tab
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                selectedItemColor: const Color(0xFFFFCF23),
                unselectedItemColor: Colors.black,
                selectedLabelStyle: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Afacad',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                iconSize: 40,
                backgroundColor: Colors.white,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: 'Books',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favourites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
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

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _trendingBooks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTrendingBooks();
  }

  Future<void> _fetchTrendingBooks() async {
    final apiUrl =
        'https://www.googleapis.com/books/v1/volumes?q=subject:fiction&orderBy=relevance&maxResults=40';

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
            'title': volumeInfo['title'] ?? 'Unknown Title',
            'author': (volumeInfo['authors'] != null)
                ? volumeInfo['authors'][0]
                : 'Unknown Author',
            'thumbnail': volumeInfo['imageLinks']?['thumbnail'] ?? '',
            'description':
                volumeInfo['description'] ?? 'No description available',
            'previewLink': volumeInfo['previewLink'] ?? '',
            'rating': volumeInfo['averageRating']?.toString() ?? 'N/A',
            'id': item['id'] ?? 'Unknown ID',
          });
        }

        // Sort books by rating
        books.sort((a, b) {
          final ratingA = double.tryParse(a['rating'] ?? '0') ?? 0;
          final ratingB = double.tryParse(b['rating'] ?? '0') ?? 0;
          return ratingB.compareTo(ratingA);
        });

        setState(() {
          _trendingBooks = books;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _searchBooks(String query) async {
    final apiUrl =
        'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=10';

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

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultsPage(books: books),
          ),
        );
      }
    } catch (e) {
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
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Home',
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                                  _searchBooks(_searchController.text);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Trending Books',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _trendingBooks.length,
                                itemBuilder: (context, index) {
                                  final book = _trendingBooks[index];
                                  return ListTile(
                                    leading: book['thumbnail']!.isNotEmpty
                                        ? Image.network(book['thumbnail']!)
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
                                            imagePath: book['thumbnail']!,
                                            previewLink: book['previewLink']!,
                                            rating: book['rating']!,
                                            bookId: book['id']!,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultsPage extends StatelessWidget {
  final List<Map<String, String>> books;

  const SearchResultsPage({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            leading: book['thumbnail']!.isNotEmpty
                ? Image.network(book['thumbnail']!)
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
                    imagePath: book['thumbnail']!,
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
    );
  }
}
