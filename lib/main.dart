import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() {
    return _RandomWordsState();
  }

}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  final _saved = <WordPair>{};


  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: (buildContext, i) {
      if (i.isOdd) {
        return const Divider();
      }

      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(20));
      }
      return _buildRowText(_suggestions[index]);
    });
  }

  Widget _buildRowText(WordPair wordPair) {
    final alreadySaved = _saved.contains(wordPair);

    return ListTile(
      title: Text(
          wordPair.asPascalCase,
          style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
          semanticLabel: alreadySaved ? 'Bo luu' : 'Luu',
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: 'Danh sach da luu',
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }


  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: ((context) {
        final tilesSavedList = _saved.map((wordPair) => ListTile(
          title: Text(
            wordPair.asPascalCase,
            style: _biggerFont,
          )
        ));

        final tilesSavedListdevide = ListTile.divideTiles(
          context: context,
          tiles: tilesSavedList,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Danh sach da luu'),
          ),
          body: ListView(children: tilesSavedListdevide),
        );
      })
    ));
  }
}
