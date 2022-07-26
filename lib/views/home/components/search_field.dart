import 'package:flutter/material.dart';

import '../../../models/bookshop_model.dart';
import '../../product_details_page/product_details_page.dart';
import '../../search_pages/api_search_page.dart';

import 'package:get/get.dart';
class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.82,
      width: MediaQuery.of(context).size.width * 0.79,
      decoration: BoxDecoration(
        // color: kSecondaryColor.withOpacity(0.1),
        border: Border.all(color: const Color(0xFF1A8F00)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onTap: () async {
          showSearch(context: context, delegate: EducanSearch());
        },
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search in Educan Shop ...",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}

class EducanSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              Get.back();
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.white,
        child: FutureBuilder<List<BookshopData>>(
          future: SearchPageApi.fetchData('Book', 'ASC', query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data!);
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => const Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.black),
        ),
      );

  Widget buildSuggestionsSuccess(List<BookshopData> suggestions) =>
      ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          // final queryText = suggestion.substring(0, query.length);
          final queryText = suggestion.title;
          // final remainingText = suggestion.substring(query.length);
          final remainingText = suggestion.title;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                query = suggestion.title!;

                // 1. Show Results
                // showResults(context);

                // 2. Close Search & Return Result
                // close(context, suggestion);

                // 3. Navigate to Result Page
                //  Navigato
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => ResultPage(suggestion),
                //   ),
                // );

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetailsView(
                          code: 88,
                          data: suggestion,
                        )));
              },
              leading: Image.network("https://educanug.com/Educan/${suggestion.filelogo!}"),
              // title: Text(suggestion),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: const [
                    TextSpan(
                      text: '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
