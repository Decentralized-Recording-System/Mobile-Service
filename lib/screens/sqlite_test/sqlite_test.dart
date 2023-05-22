import 'dart:async';
import 'package:flutter/material.dart';

import '../../model/index.dart';
import '../../services/index.dart';

class Books extends StatefulWidget {
  static const String id = 'Books';
  const Books({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BooksState();
  }
}

class _BooksState extends State<Books> {
  late TelemeticsDatabase _db;
  late Future<List<TelemeticsDatabaseModel>> books;
  int i = 0;

  @override
  void initState() {
    _db = TelemeticsDatabase.instance;
    books = _db.readAllData();
    super.initState();
  }

  Future<void> clearBook() async {
    await _db.deleteAll();
    setState(() {
      books = _db.readAllData();
    });
  }

  Future<void> deleteBook(int id) async {
    await _db.delete(id);
    setState(() {
      books = _db.readAllData();
    });
  }

  // Future<void> editBook(TelemeticsDatabaseModel book) async {
  //   book = book.copy(score: 12, highestValue: 11.0, lowestValue: 2.0);
  //   await _db.update(book);
  //   setState(() {
  //     books = _db.readAllData();
  //   });
  // }

  Future<void> newBook() async {
    i++;
    TelemeticsDatabaseModel book = TelemeticsDatabaseModel(
      score: 12,
      brakingValue: 12,
      dangerousBrakeValue: 10,
      dangerousTurnValue: 2,
    );
    TelemeticsDatabaseModel newBook = await _db.create(book);
    setState(() {
      books = _db.readAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<TelemeticsDatabaseModel>>(
            future: books,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: snapshot.data!.isNotEmpty
                          ? ListView.separated(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                TelemeticsDatabaseModel book =
                                    snapshot.data![index];

                                Widget card;
                                card = Card(
                                    margin: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit),
                                          ),
                                          title: Text('${book.score}'),
                                          subtitle: Text(
                                              'hightestscore: ${book.brakingValue}'),
                                          trailing: IconButton(
                                            onPressed: () =>
                                                deleteBook(book.id!),
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ),
                                      ],
                                    ));
                                return card;
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(),
                            )
                          : const Center(child: Text('No items')),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                // กรณี error
                return Text('${snapshot.error}');
              }

              return const RefreshProgressIndicator();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newBook(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
