import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String imagePath;

  BookDetailPage({
    required this.title,
    required this.author,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFC21A), // Match yellow background
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC21A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Book Cover Image Placeholder
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(
              imagePath,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          // Reduced White Section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Author
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'by $author',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: Colors.amber,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Rating
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < 4
                              ? Icons.star
                              : Icons.star_border, // Adjust for a 4-star rating
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    // Centered Read Button with Updated Properties
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0A0A0A), // Black color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Corner radius
                          ),
                          minimumSize: Size(100, 26), // Width and Height
                          padding: EdgeInsets.zero, // Remove extra padding
                        ),
                        child: Text(
                          'Read',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Comments Section
                    Text(
                      'Comment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_pic.jpg'),
                      ),
                      title: Text(
                        'Syafiy R.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        'Very nice book. I love it!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    Spacer(),
                    // Centered Comment Button with Updated Properties
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0A0A0A), // Black color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Corner radius
                          ),
                          minimumSize: Size(100, 26), // Width and Height
                          padding: EdgeInsets.zero, // Remove extra padding
                        ),
                        child: Text(
                          'Comment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
