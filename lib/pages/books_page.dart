import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  final List<String> bookCovers = [
    'assets/book1.jpg',
    'assets/book2.jpg',
    'assets/book3.jpg',
    'assets/book4.jpg',
    'assets/book5.jpg',
    'assets/book6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFFFFBEA),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Search for books',
                        labelStyle: TextStyle(
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
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.search,
                            color: Color(0xFFFFCF23),
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    itemCount: bookCovers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return BookItem(bookCover: bookCovers[index]);
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
  final String bookCover;

  BookItem({required this.bookCover});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            bookCover,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Book Title",
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

