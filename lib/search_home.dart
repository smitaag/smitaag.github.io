import 'package:flutter/foundation.dart';
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
  String? _location;
  String? _jobtitle;
  String? _exclude;
  String? infoMsg;
  bool refreshUI = false;
  List<String> _searchResults = [];
  final List<String> _platformsList = <String>[
    'LinkedIn',
    'Dribbble',
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
    var list = <String?>[''];
    String searchStr;
    switch (_selectedPortal) {
      case 'linkedin':
        //http://www.google.com/search?q=+"director+of+engineering"+"leoforce" -intitle:"profiles" -inurl:"dir/+"+site:in.linkedin.com/in/+OR+site:in.linkedin.com/pub/
        //http://www.google.com/search?q=+"director of engineering"+"leoforce" -intitle:"profiles" -inurl:"dir/+"+site:www.linkedin.com/in/+OR+site:www.linkedin.com/pub/

        //"http://www.google.com/search?q=+"leoforce"-"null" -intitle:"profiles" -inurl:"dir/+"+site:www.linkedin.com/in/+OR+site:www.linkedin.com/pub/"
        // //"Software+Engineer" - job title
        //HTML - keyword
        //"Intern"- exclude word
        //+"Current+%2A+Google+%2A+" - curret employer
        //http: //www.google.com/search?q=+"Software+Engineer"+"HTML" -"Intern" -intitle:"profiles" -inurl:"dir/+"+site:www.linkedin.com/in/+OR+site:www.linkedin.com/pub/+"Current+%2A+Google+%2A+"
        //site: in.linked.com --- *** in. is for country code INDIA
        String excludeStr = (_exclude != null) ? ('-"$_exclude"') : "";
        searchStr =
            'http://www.google.com/search?q=+"$_jobtitle"+"$_keyword" $excludeStr-intitle:"profiles" -inurl:"dir/+"+site:in.$_selectedPortal.com/in/+OR+site:in.$_selectedPortal.com/pub/';
        if (kDebugMode) {
          // ignore: avoid_print
          print(searchStr);
        }
        break;
      case 'stackoverflow':
        //"HTML+Developer" - keywords
        //"Berlin" - City/Country
        //http://www.google.com/search?q=site:stackoverflow.com/users -"Keeping a low profile."+"HTML+Developer"+"Berlin"
        searchStr =
            'http://www.google.com/search?q=site:$_selectedPortal.com/users -"Keeping a low profile."+"flutter+developer"+"hyderabad"-"0 * reputation"';
        break;
      case 'github':
        //"PHP+Developer" - keywords
        //"Paris" - Location
        //"http://www.google.com/search?q=site:github.com+"joined on" -intitle:"at master" -inurl:"tab" -inurl:"jobs." -inurl:"articles"+"leoforce"+"hyderabad""
        //http://www.google.com/search?q=site:github.com+"joined on" -intitle:"at master" -inurl:"tab" -inurl:"jobs." -inurl:"articles"+"PHP+Developer"+"Paris"
        String? locStr = (_location != null) ?  + "_location" : "";
        searchStr =
            'http://www.google.com/search?q=site:$_selectedPortal.com+"joined on" -intitle:"at master" -inurl:"tab" -inurl:"jobs." -inurl:"articles"+"$_keyword" $locStr';

        break;
      // case 'indeed':
      //   searchStr =
      //       'http://www.google.com/search?q=site:$_selectedPortal.com/users -"Keeping a low profile."+"$_keyword"+"$_location"-"0 * reputation"';
      //   break;
      case 'dribbble':
        //site:dribble.com -inurl:(followers|type|members|following|jobs|designers|players|buckets|places|skills|projects|tags|search|stories|users|draftees|likes|lists) -intitle:(following|likes) -"Hire Us"  "fghdfg" -"dfghdfg"
        //http://www.google.com/search?q=site:dribbble.com -inurl:(followers|type|members|following|jobs|designers|players|buckets|places|skills|projects|tags|search|stories|users|draftees|likes|lists) -intitle:(following|likes) -"Hire Us" +"kkkk" -"yyyy"
        searchStr =
            'http://www.google.com/search?q=site:$_selectedPortal.com -inurl:(followers|type|members|following|jobs|designers|players|buckets|places|skills|projects|tags|search|stories|users|draftees|likes|lists) -intitle:(following|likes) -"Hire Us"+"$_keyword"-"$_location"';
        break;

      default:
        searchStr =
            'http://www.google.com/search?q=+"$_keyword"-"$_exclude"+site:www.$_selectedPortal.com';
    }
    //ljhkjlkj

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
                                setState(() {
                                  refreshUI = false;
                                  _selectedPortal = "linkedin";
                                });
                              },
                            ),
                            GestureDetector(
                              child: Container(
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
                              onTap: () {
                                setState(() {
                                  refreshUI = false;
                                  _selectedPortal = "stackoverflow";
                                });
                              },
                            ),
                            GestureDetector(
                              child: Container(
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
                              onTap: () {
                                setState(() {
                                  refreshUI = false;
                                  _selectedPortal = "github";
                                });
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width * .1,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.green,
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0))),
                                child: const Center(child: Text('Dribbble')),
                              ),
                              onTap: () {
                                setState(() {
                                  refreshUI = false;
                                  _selectedPortal = "dribbble";
                                });
                              },
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
                                  refreshUI = false;
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
                                refreshUI = false;
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
                                  labelTextStr: "City or Country",
                                  hintTextStr: ""),
                              keyboardType: TextInputType.text,
                              onSaved: (value) => _location = value,
                              onChanged: (value) {
                                setState(() {
                                  refreshUI = false;
                                  _location = value;
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
                            onSaved: (value) => _jobtitle = value,
                            onChanged: (value) {
                              setState(() {
                                refreshUI = false;
                                _jobtitle = value;
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
                (_selectedPortal != null)
                    ? Text(
                        "Cool..you have selected $_selectedPortal, now go on.. and select your criteria for search.",
                        style:
                            TextStyle(color: Colors.indigo[900], fontSize: 22),
                      )
                    : Container(),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: MaterialButton(
                    child: const Text("Start searching"),
                    color: Colors.white,
                    onPressed: () {
                      if (_selectedPortal != null) {
                        setState(() {
                          refreshUI = true;
                        });
                      } else {
                        setState(() {
                          infoMsg = "Where do we look, select a portal first";
                        });
                      }
                    },
                  ),
                ),
                Text(infoMsg ?? ""),
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
