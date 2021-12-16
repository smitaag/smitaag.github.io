import 'package:flutter/material.dart';

import 'theme.dart';

class SearchHome extends StatefulWidget {
  const SearchHome({Key? key}) : super(key: key);

  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  String? _portal;
  String? _keyword;
  bool refreshUI = false;
  List<String> _searchResults = [];
  Widget updateResults() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot searchSnap) {
        // WHILE THE CALL IS BEING MADE AKA LOADING
        if (!searchSnap.hasData) {
          return const Center(child: Text('Loading'));
        }

        // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
        if (searchSnap.hasError) {
          return Center(child: Text(searchSnap.error.toString()));
        }
        return ListView.builder(
            itemCount: searchSnap.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Text('${searchSnap.data[index].title}');
            });
      },
      future: getProjectDetails(),
    );
  }

  Future getProjectDetails() async {
    var list = <String?>['foo', 'bar', 'baz'];
    return list;
  }

  Future<void> showSearchResults() async {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * .85,
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * .05,
                MediaQuery.of(context).size.width * .04,
                MediaQuery.of(context).size.width * .05,
                MediaQuery.of(context).size.width * .04),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //  padding: EdgeInsets.zero,
                children: <Widget>[
                  Text(
                    'Experience new way of looking for best candidates/jobs',
                    style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontFamily: 'AkkuratPro',
                        fontSize: 17.0),
                  ),
                  Row(
                    children: [
                      TextFormField(
                        obscureText: false,
                        maxLines: 1,
                        minLines: 1,
                        style: lightInputTextStyle,
                        keyboardType: TextInputType.phone,
                        onSaved: (value) => _portal = value,
                        onChanged: (value) {
                          setState(() {
                            _portal = value;
                          });
                        },
                      ),
                      TextFormField(
                        obscureText: false,
                        maxLines: 1,
                        minLines: 1,
                        style: lightInputTextStyle,
                        keyboardType: TextInputType.phone,
                        onSaved: (value) => _keyword = value,
                        onChanged: (value) {
                          setState(() {
                            _keyword = value;
                          });
                        },
                      )
                    ],
                  ),
                  MaterialButton(
                    child: const Text("Show Results"),
                    onPressed: () {
                      setState(() {
                        refreshUI = true;
                      });
                    },
                  ),
                  Expanded(child: updateResults()),
                ]),
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(
      //   barIndex: 0,
      // ),

      onWillPop: () async {
        return false;
      },
    );
  }
}
