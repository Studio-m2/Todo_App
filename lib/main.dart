import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  String insert='';

  late List<String> todo=[];
  final String _listKey = 'myList';

  @override
  void initState()
  {

    super.initState();
    _loadList();






  }
  void _deleteList() async{

    SharedPreferences prefs  = await SharedPreferences.getInstance();
    await prefs .remove("_listKey");await prefs .clear();

  }
  void _saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_listKey, todo);
  }

  void _loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todo = (prefs.getStringList(_listKey) ?? []);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(centerTitle:true,backgroundColor:Colors.green,
        title:Text('Todo',style:TextStyle(fontFamily:'Raleway'),),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: TextField(

                onChanged: (String value){
                  insert=value;
                },
              ),
              title: Text("enter your data"),


              actions: [
                ElevatedButton.icon(onPressed: ()async{

                  setState(() {



                    todo.add(insert);




                  });



                  _saveList();
                  Navigator.pop(context);




                }, icon: Icon(Icons.save),label:Text('save') ,),
                ElevatedButton.icon(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.cancel),label:Text('cancle') ,),
              ],
            );
          });
        },

        child:Icon(Icons.add),

      ),
      body:ListView.separated(
        separatorBuilder:(BuildContext context,int index){
          return Divider(
            height: 1,
          );

        },

        itemCount:todo.length ,
        itemBuilder:(BuildContext context,int index){

          return ListTile(
            title:Text(todo[index]) ,
            tileColor:Colors.pink,
            trailing:Row(
              mainAxisSize:MainAxisSize.min,
              children: [



                ElevatedButton.icon(onPressed: (){

                  showDialog(context: context, builder: (context){
                    return AlertDialog(


                      content: TextField(
                        onChanged: (String value){
                          insert=value;
                        },
                      ),
                      title: Text("edit your data"),


                      actions: [
                        ElevatedButton.icon(onPressed: (){
                          setState(() {
                            todo[index]=insert;
                          });
                          _saveList();
                          Navigator.pop(context);
                        }, icon: Icon(Icons.edit),label:Text('edit') ,),
                        ElevatedButton.icon(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.cancel),label:Text('cancle') ,),
                      ],





                    );

                  });

                }, icon: Icon(Icons.edit),label:Text('Edit') ,),


SizedBox(width:10),


                ElevatedButton.icon(onPressed: (){



                  showDialog(context: context, builder: (context){
                    return AlertDialog(



                      title: Text("Are you want to delete"),


                      actions: [
                        ElevatedButton.icon(onPressed: (){
                          setState(() {
                            todo.removeAt(index);
                          });
                          _deleteList();

                          Navigator.pop(context);
                        }, icon: Icon(Icons.edit),label:Text('yes') ,),
                        ElevatedButton.icon(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.edit),label:Text('no') ,),
                      ],





                    );

                  });









                }, icon: Icon(Icons.delete),label:Text('delete') ,),




              ],),
          );

        },
      ) ,
    );
  }
}
































