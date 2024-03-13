import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(DictionaryApp());
}

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  @override
  Future<void> getData (String word) async {
    final String url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';
    final response = await http.get(
        Uri.parse(url));
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DictionaryHomePage(),
    );
  }
}

class DictionaryHomePage extends StatefulWidget {
  @override
  _DictionaryHomePageState createState() => _DictionaryHomePageState();
}

class _DictionaryHomePageState extends State<DictionaryHomePage> {
  // Sample dictionary data
  Map<String, String> dictionary = {

    //'apple': 'a round fruit with red or green skin and a whitish interior',
    //'banana':
    //'a long curved fruit that grows in clusters and has soft pulpy flesh and yellow skin when ripe',
    //'orange': 'a round juicy citrus fruit with a tough bright reddish-yellow rind',
    //'grape': 'a small round or oval fruit with a smooth skin and a juicy pulp',
    // Add more words and their definitions as needed
  };

  String searchQuery = '';
  String result = '';

  void searchDictionary(String query) {
    setState(() {
      if (dictionary.containsKey(query)) {
        result = dictionary[query]!;
      } else {
        result = '';
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Word Not Found'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.error_outline, color: Colors.red),
                    title: Text(
                      'The word "$query" was not found in the dictionary.',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dictionary App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              maxLength: 10, // Limit the length of the search query to 10 characters
              decoration: InputDecoration(
                labelText: 'Enter a word',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.substring(0, value.length < 20 ? value.length : 20); // Limit the search query length
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                searchDictionary(searchQuery.toLowerCase());
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Text(
                      result.isEmpty ? 'Enter a word to search.' : result,
                      style: TextStyle(fontSize: 20, color: Colors.blue), // Add color to the text
                    ),
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




