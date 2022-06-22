import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function() onSearch;
  final Function() onClear;
  const SearchBar({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          boxShadow: kElevationToShadow[1],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      border: InputBorder.none,
                    ),
                    controller: searchController,
                    onEditingComplete: onSearch,
                  )),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(36)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: searchController.text == ""
                      ? const Icon(
                          Icons.search,
                          color: Colors.purple,
                        )
                      : IconButton(
                          onPressed: onClear,
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.purple,
                          )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
