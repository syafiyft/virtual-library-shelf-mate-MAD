import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookViewer extends StatefulWidget {
  final String bookId; // Google Books ID

  const BookViewer({Key? key, required this.bookId}) : super(key: key);

  @override
  _BookViewerState createState() => _BookViewerState();
}

class _BookViewerState extends State<BookViewer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://books.google.com/books?id=${widget.bookId}&printsec=frontcover'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Viewer',
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFFFC21A),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
