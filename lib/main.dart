import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Search_data_list(),
    );
  }
}

class Search_data_list extends StatefulWidget {
  const Search_data_list({super.key});

  @override
  State<Search_data_list> createState() => _Search_data_listState();
}

class _Search_data_listState extends State<Search_data_list> {

  TextEditingController search= TextEditingController();

  RxInt searchonoff=0.obs;
	RxInt searchindex=0.obs;
	RxList searchindexlist=<int>[].obs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchonoff.value=0;
      searchindex.value=-1;
    });
    super.initState();
  }

  List name = [
    "Apple",
    "Orange",
    "Banana",
    "Chiku",
    "Mango",
    "Lemon",
    "Papaya",
    "Guava",
    "Golden kiwi",
    "Pineapple",
    "Blackberry",
    "Blueberry",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(()=> Scaffold(
        appBar: AppBar(
          title: const Text("Search Data From List",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: () {
                if(searchonoff.value==0)
                {
                  searchonoff.value=1;
                  searchindex.value=-1;
                  search.text='';
                }
                else
                {
                  searchonoff.value=0;
                  searchindex.value=-1;
                  search.text='';
                }
              },
              icon: Icon( searchonoff.value==0 ? Icons.search : Icons.close),
            )
          ],
        ),
        body: Column(
          children: [
            searchonoff.value==1 ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 17,right: 17),
                  child: 
                  SizedBox(
                    height: 50,
                    child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: true,
                      controller: search,
                      cursorColor: Colors.black,
                      style: const TextStyle(height: 1),
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 16,right: 10,bottom: 5),
                          child: Icon(Icons.search,color: Colors.grey,size: 20,),
                        ),
                        labelText: 'Search',
                        labelStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(),)
                      ),
                      onChanged: (value){
                        if(value.isEmpty)
                        {
                          searchindex.value=-1;
                            searchindexlist.clear();
                        }
                        else
                        {
                          searchindexlist.clear();
                          searchindex.value=-1;
                          for (var element in name) {
                            searchindex.value++;
                            String name=element;
                            if(name.toLowerCase().contains(value.toLowerCase()))
                            {
                                searchindexlist.add(searchindex.value);
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ): const SizedBox(),
            Expanded(
              child: ListView.builder(
                itemCount: searchindex.value==-1 ?  name.length : searchindexlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.auto_awesome),
                    ),
                    title: Text(
                      searchindex.value==-1 ? name[index] : name[searchindexlist[index]],
                      style: const TextStyle(fontSize: 15)
                    ),
                    subtitle: const Text("Successsoft Infotech",style: TextStyle(fontSize: 10,height: 0),),
                  );
                }, 
              )
            )
          ],
        ),
      ),
    ));
  }
}


