part of "../avatar_gallery.dart";

class AvatarPickup extends SearchDelegate<List<String>?> {
  final bool multiSelect;
  final List<String> selectedAvatars = [];

  List<AvatarTags>? _listAvatarTags;

  AvatarPickup({this.multiSelect = false});

  bool checkTags(AvatarTags avatarTags, List<String> queryList) {
    bool res = false;
    for (var query in queryList) {
      res = avatarTags.tags.any((tag) => tag.contains(query));
    }
    return res;
  }

  List<AvatarTags>? get listAvatarTags {
    if (_listAvatarTags == null) return null;

    if (query.isEmpty) return _listAvatarTags;

    List<String> queryList =
        query.replaceAll(",", " ").replaceAll("-", " ").split(" ").toList();

    return _listAvatarTags!
        .where((element) => checkTags(element, queryList))
        .toList();
  }

  void onChangeSelectedAvatars(List<String> value) {
    selectedAvatars.clear();
    selectedAvatars.addAll(value);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    var clearButton = RefreshableButtonGroupItem(
        controller: RefreshableButtonGroupItemController(icon: Icons.clear),
        onTap: () => query = "");

    var okButton = RefreshableButtonGroupItem(
        controller: RefreshableButtonGroupItemController(icon: Icons.check),
        onTap: () {
          List<String> res =
              selectedAvatars.map((e) => "lib/assets/$e").toList();
          close(context, res);
        });

    var buttonGroupController =
        RefreshableButtonGroupController(itemList: [clearButton, okButton]);
    var buttonGroup = RefreshableButtonGroup(controller: buttonGroupController);
    return [buttonGroup];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            close(context, []);
          },
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (kDebugMode) {
      print("buildResults");
    }
    if (listAvatarTags == null) {
      return _futureContent();
    } else {
      return AvatarGridView(
        listAvatarTags: listAvatarTags!,
        onSelectedAvatars: (selectedAvatarList) =>
            onChangeSelectedAvatars(selectedAvatarList),
      );
    }
  }

  Future<List<AvatarTags>> _getAvatarList() async {
    final String response = await rootBundle
        .loadString("packages/avatar_gallery/lib/assets/icon_tags.json");
    final List<dynamic> data = await jsonDecode(response);
    _listAvatarTags = data
        .map((e) =>
            AvatarTags(icon: e["icon"], tags: List<String>.from(e["tags"])))
        .toList();
    return listAvatarTags!;
  }

  Widget _futureContent() {
    return FutureBuilder<List<AvatarTags>>(
      future: _getAvatarList(),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.error),
            );

          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).indicatorColor),
            );

          case ConnectionState.active:
            return AvatarGridView(
              listAvatarTags: snapshot.data!,
              onSelectedAvatars: (selectedAvatarList) =>
                  onChangeSelectedAvatars(selectedAvatarList),
            );

          case ConnectionState.done:
            return AvatarGridView(
              listAvatarTags: snapshot.data!,
              onSelectedAvatars: (selectedAvatarList) =>
                  onChangeSelectedAvatars(selectedAvatarList),
            );
        }
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (listAvatarTags == null) {
      return _futureContent();
    } else {
      return AvatarGridView(
        listAvatarTags: listAvatarTags!,
        onSelectedAvatars: (selectedAvatarList) =>
            onChangeSelectedAvatars(selectedAvatarList),
      );
    }
  }
}
