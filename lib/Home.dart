
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:',),
            Text('', style: Theme.of(context).textTheme.headline4,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          _readJSON();

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //创建文件的主入口
  void _createFile(String data,{String fileName = 'automodel',bool fileOverwriteAlreadyExists = false}) async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();// file_picker: ^4.4.0
    File _file = File('$selectedDirectory/$fileName.dart');
    try{
      bool exists = await _file.exists();
      if (!exists) {
        await _file.create();
        _writeJSON(_file,data);
      }else{
        if(fileOverwriteAlreadyExists){
          print({'!!$_file文件进行覆盖!!'});
          _writeJSON(_file,data);
        }else{
          print({'!!$_file文件已存在!!'});
        }
      }
    }catch(e){
      print(e);
    }
  }

  //写入文件
  _writeJSON(File file,String obj) async{
    try {
      return file.writeAsString(obj);
    }
    catch (err) {
      print(err);
    }
  }

  //读取文件与测试用例
  _readJSON() async{

    File file = File("/Volumes/mac/Users/biex/Downloads/autogeneratemodel/lib/josn.json");
    String str = await file.readAsString();
    Map _jsonMap = jsonDecode(str);
    _makeModel(_jsonMap);

  }

  //制作
  _makeModel(Map map) async{
    List _resultList = [];
    int _recursionKey = 1;
    const String _modelRootName = 'neverRootResponse';

    bool _allString = true;

    _resultList = await _disassemblyModel(map,_recursionKey,rootModelName: _modelRootName,allString: _allString);

    //第四步写入文件
    String _result = '';
    for(var it in _resultList){
      _result += it + '\n';
    }
    _createFile(_result,fileName: "automodel",fileOverwriteAlreadyExists: true);


  }


  //原json，递归层数，model根姓名，是否除List外全部使用String
  _disassemblyModel(Map map,int insideMapLength,{String rootModelName = 'Automatic' , bool allString = false}){

    List modelList = [];
    List _resultList = [];
    int modelListLength = 0;

    String _insideMapTitle = 'Model';
    String _insideMapTitle2 = 'Data';

    if(insideMapLength == 1){
      _insideMapTitle = 'Model';
      _insideMapTitle2 = 'Data';
    }else if(insideMapLength == 2){
      _insideMapTitle = 'Data';
      _insideMapTitle2 = 'ListData';
    }else if(insideMapLength == 3){
      _insideMapTitle = 'ListData';
      _insideMapTitle2 = 'List' + (insideMapLength+1).toString() +'Data';
    }else{
      _insideMapTitle = 'List' + insideMapLength.toString() +'Data';
      _insideMapTitle2 = 'List' + (insideMapLength+1).toString() +'Data';
    }

    //新增头
    modelList.add("class " + rootModelName + _insideMapTitle + "{");
    modelListLength ++;

    //开始解析第一层
    map.forEach((key, value){
      //第一步，解析完成所有的key，并生成第一次的参数
      if(value.runtimeType != List){
        modelList.insert(modelListLength++, "\tfinal " + (allString ? "String" : value.runtimeType.toString()) + "? " + key.toString() + ";");//"final int? code;"
      }else{
        //进行递归的第二层
        // _resultList = await _disassemblyModel(map,_recursionKey,rootModelName: _modelRootName);
        List vv = value;
        Map _insideMap;

        if(vv.first is Map){
          _insideMap = vv.first;
        }else if(vv.first is String){
          _insideMap = jsonDecode(vv.first);
        }else{
          _insideMap = {};//这里就不进行处理了 让用户自己搞定
        }

        {
          _resultList = _disassemblyModel(_insideMap,insideMapLength + 1,rootModelName: rootModelName,allString: allString);
          modelList.addAll(_resultList);
        }

        modelList.insert(modelListLength++, "\tfinal List<" + rootModelName + _insideMapTitle2 +">? " + key.toString() + ";");//"final int? code;"
      }
    });
    modelList.insert(modelListLength++, "");

    //第二步，生成Constructor
    String _k1String = '';
    map.forEach((key, value) {
      _k1String += 'this.' + key + ", ";
    });
    modelList.insert(modelListLength++, "\t" + rootModelName + _insideMapTitle +"({" + _k1String + '});');//"final int? code;"

    //第三步生成工厂类
    modelList.insert(modelListLength++, "");
    modelList.insert(modelListLength++, "\tfactory " + rootModelName + _insideMapTitle +".fromJson(Map<dynamic, dynamic> json) {");//"final int? code;"
    modelList.insert(modelListLength++, "\t\treturn " + rootModelName + _insideMapTitle +"(");//"final int? code;"
    map.forEach((key, value) {
      if(value.runtimeType != List){
        if(key.runtimeType == String || allString){
          modelList.insert(modelListLength++, "\t\t\t" + key.toString() + " : " + "json['" + key.toString() + "'].toString(),");
        }else{
          modelList.insert(modelListLength++, "\t\t\t" + key.toString() + " : " + "json['" + key.toString() + "'],");
        }
      }else{
        modelList.insert(modelListLength++, "\t\t\t" + key.toString() + " : (json['" + key.toString() + "'] as List).map((i) => " + rootModelName + _insideMapTitle2 +".fromJson(i)).toList(),");//"final int? code;"
      }
    });
    modelList.insert(modelListLength++, "\t\t);");//"final int? code;"
    modelList.insert(modelListLength++, "\t}");//"final int? code;"
    modelList.insert(modelListLength++, "}");//"final int? code;"

    return modelList;
  }

}
