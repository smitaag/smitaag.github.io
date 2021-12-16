import 'package:flutter/material.dart';
import 'package:super_search/url_service.dart';

import 'theme.dart';

class SearchHome extends StatefulWidget {
  const SearchHome({Key? key}) : super(key: key);

  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  String? _portal;
  String? _keyword;
  String? _exclude;
  bool refreshUI = false;
  List<String> _searchResults = [];
  final List<String> _platformsList = <String>[
    'LinkedIn',
    'Indeed',
    'Github',
    'StackOverflow'
  ];
  String? _selectedPortal;
  Widget updateResults() {
    //http://www.google.com/search?q=site:stackoverflow.com/users -"Keeping a low profile."+"flutter+developer"+"hyderabad"-"0 * reputation"
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
              return Text('${searchSnap.data[index]}');
            });
      },
      future: getSearchResults(),
    );
  }

  Future getSearchResults() async {
    var list = <String?>['foo', 'bar', 'baz'];
    String searchStr =
        'http://www.google.com/search?q=site:stackoverflow.com/users -"Keeping a low profile."+"flutter+developer"+"hyderabad"-"0 * reputation"';
    hitUrl(searchStr: searchStr);
    return list;
  }

  Future<void> showSearchResults() async {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Colors.cyan,
          //height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * .05,
              MediaQuery.of(context).size.width * .04,
              MediaQuery.of(context).size.width * .05,
              MediaQuery.of(context).size.width * .04),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
              //  padding: EdgeInsets.zero,
              children: <Widget>[
                Text(
                  'Experience new way of looking for best candidates/jobs',
                  style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontFamily: 'RalewayRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .05,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .05,
                  child: Row(
                    children: [
                      const Text(
                        "Select platform you want to search??",
                        style: TextStyle(color: Colors.white, fontSize: 27),
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                //color: Colors.orange,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.orange,
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0))),
                                width: MediaQuery.of(context).size.width * .1,
                                child: const Center(child: Text('LinkedIn')),
                              ),
                              onTap: () {
                                _selectedPortal = "LinkedIn";
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.purple,
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0))),
                              width: MediaQuery.of(context).size.width * .1,
                              //  color: Colors.purple,
                              child:
                                  const Center(child: Text('Stack Overflow')),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .1,
                              height: MediaQuery.of(context).size.width * .1,
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.pink,
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0))),
                              child: const Center(child: Text('Git Hub')),
                            ),
                            Container(
                              margin: const EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width * .1,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0))),
                              child: const Center(child: Text('Indeed')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Row(
                        children: [
                          const Text(
                            "Include Keywords",
                            style: TextStyle(color: Colors.white, fontSize: 27),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          Expanded(
                            child: TextFormField(
                              obscureText: false,
                              maxLines: 1,
                              minLines: 1,
                              style: const TextStyle(
                                  color: Colors.amber, fontSize: 20),
                              decoration: CommonStyle.textFieldStyle(
                                  labelTextStr:
                                      "For example Full stack developer, Manager etc",
                                  hintTextStr: ""),
                              keyboardType: TextInputType.text,
                              onSaved: (value) => _keyword = value,
                              onChanged: (value) {
                                setState(() {
                                  _keyword = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .1,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Row(
                        children: [
                          const Text(
                            "Exclude Keywords",
                            style: TextStyle(color: Colors.white, fontSize: 27),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          Expanded(
                              child: TextFormField(
                            obscureText: false,
                            maxLines: 1,
                            minLines: 1,
                            style: const TextStyle(
                                color: Colors.amber, fontSize: 20),
                            decoration: CommonStyle.textFieldStyle(
                                labelTextStr:
                                    "For exampleertgg Assistant, Trainee etc",
                                hintTextStr: ""),
                            keyboardType: TextInputType.text,
                            onSaved: (value) => _exclude = value,
                            onChanged: (value) {
                              setState(() {
                                _exclude = value;
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Row(
                        children: [
                          const Text(
                            "Location",
                            style: TextStyle(color: Colors.white, fontSize: 27),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          Expanded(
                            child: TextFormField(
                              obscureText: false,
                              maxLines: 1,
                              minLines: 1,
                              style: const TextStyle(
                                  color: Colors.amber, fontSize: 20),
                              decoration: CommonStyle.textFieldStyle(
                                  labelTextStr: "For example India, USA etc",
                                  hintTextStr: ""),
                              keyboardType: TextInputType.text,
                              onSaved: (value) => _keyword = value,
                              onChanged: (value) {
                                setState(() {
                                  _keyword = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .1,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Row(
                        children: [
                          const Text(
                            "Job Title",
                            style: TextStyle(color: Colors.white, fontSize: 27),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          Expanded(
                              child: TextFormField(
                            obscureText: false,
                            maxLines: 1,
                            minLines: 1,
                            style: const TextStyle(
                                color: Colors.amber, fontSize: 20),
                            decoration: CommonStyle.textFieldStyle(
                                labelTextStr:
                                    "For example Project Manager, Co-founder etc",
                                hintTextStr: ""),
                            keyboardType: TextInputType.text,
                            onSaved: (value) => _exclude = value,
                            onChanged: (value) {
                              setState(() {
                                _exclude = value;
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .02,
                ),
                (_exclude != null)
                    ? ((_keyword == null)
                        ? Text("So..you wanted to search for $_keyword")
                        : (Text(
                            "So..you wanted to search for $_keyword and want to exclude words like $_exclude")))
                    : Container(),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: MaterialButton(
                    child: const Text("Start searching"),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        refreshUI = true;
                      });
                    },
                  ),
                ),
                (refreshUI)
                    ? Divider(
                        height: MediaQuery.of(context).size.height * .1,
                      )
                    : Container(),
                (refreshUI) ? Expanded(child: updateResults()) : Container(),
              ]),
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
