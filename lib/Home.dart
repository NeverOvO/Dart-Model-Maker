
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double myFontSize = 13;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _modelFileNameController = TextEditingController();

  final TextEditingController _modelRootNameController = TextEditingController();

  final TextEditingController _modelJsonController = TextEditingController();

  final TextEditingController _modelPreviewJsonController = TextEditingController();

  bool _allowOverride = true;

  bool _allString = true;

  bool _needFinal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(
          children: [
            Expanded(
              child: _leftWidget(),
              flex: 2,
            ),
            const VerticalDivider(width: 1,color: Colors.black,),
            Expanded(
              child: _rightWidget(),
            ),
          ],
        ),
      ),
    );
  }

  //左侧的文本输入部分
  Widget _leftWidget(){
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
              labelText: "请输入文件名",
              labelStyle: TextStyle(color: Colors.black87,fontSize: myFontSize),
              floatingLabelStyle: TextStyle(color: Colors.green),
            ),
            controller: _modelFileNameController,
            autocorrect:false,
            style: const TextStyle(color: Colors.black,fontSize: myFontSize),
          ),
          const SizedBox(height: 10,),
          TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
              labelText: "请输入Model根名",
              labelStyle: TextStyle(color: Colors.black87,fontSize: myFontSize),
              floatingLabelStyle: TextStyle(color: Colors.green),
            ),
            controller: _modelRootNameController,
            autocorrect:false,
            style: const TextStyle(color: Colors.black,fontSize: myFontSize),
          ),
          const Text("例如：输入'Automatic',输出为'AutomaticModel/AutomaticData',具体可以在设置中更改",style: TextStyle(fontSize: 10,color: Colors.lightBlue),),
          const SizedBox(height: 10,),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
                labelText: "请输入接口报文JSON",
                labelStyle: TextStyle(color: Colors.black87,fontSize: myFontSize),
                floatingLabelStyle: TextStyle(color: Colors.green),
                alignLabelWithHint: true,
              ),
              maxLines: null,
              minLines: null,
              expands: true,
              textAlignVertical:TextAlignVertical.top,
              controller: _modelJsonController,
              autocorrect:false,
              style: const TextStyle(color: Colors.black,fontSize: myFontSize),
            ),
          ),
        ],
      ),
    );
  }

  //右侧的选项部分
  Widget _rightWidget(){
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        children: [
          const Text("基本选项",style: TextStyle(fontSize: myFontSize + 2,fontWeight: FontWeight.w600),),
          const SizedBox(height: 5,),
          const Divider(height: 1,color: Colors.black,),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("允许文件覆盖",style: TextStyle(fontSize: myFontSize,fontWeight: FontWeight.w600)),
                  IconButton(
                    onPressed: (){
                      _tipsBox('启用此选项后，将允许直接覆盖同名文件；关闭后，将提示用户进行修改',Colors.orange);
                    },
                    icon: const Icon(Icons.question_answer,color: Colors.orangeAccent,size: 15,),),
                ],
              ),
              CupertinoSwitch(
                value: _allowOverride,
                onChanged:(e){
                  setState(() {
                    _allowOverride = e;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("启用类型全String",style: TextStyle(fontSize: myFontSize,fontWeight: FontWeight.w600)),
                  IconButton(
                    onPressed: (){
                      _tipsBox('启用此选项后，将除了List，Map类型外的其他参数类型转换为String类型；关闭后，将使用参数的原本类型',Colors.orange);
                    },
                    icon: const Icon(Icons.question_answer,color: Colors.orangeAccent,size: 15,),),
                ],
              ),
              CupertinoSwitch(
                value: _allString,
                onChanged:(e){
                  setState(() {
                    _allString = e;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("final修饰词",style: TextStyle(fontSize: myFontSize,fontWeight: FontWeight.w600)),
                  IconButton(
                    onPressed: (){
                      _tipsBox('启用此选项后，将在参数前添加final，例如final String? id；关闭后为String? id',Colors.orange);
                    },
                    icon: const Icon(Icons.question_answer,color: Colors.orangeAccent,size: 15,),),
                ],
              ),
              CupertinoSwitch(
                value: _needFinal,
                onChanged:(e){
                  setState(() {
                    _needFinal = e;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider(height: 1,color: Colors.black,),
          const SizedBox(height: 10,),

          ElevatedButton(
            child: Container(
              child: const Text("生成预览(长按复制)",maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              alignment: Alignment.center,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async{

              if(_modelJsonController.text == ""){
                _tipsBox('请输入接口报文JSON',Colors.orange);
                return;
              }

              Map _jsonMap;
              try{
                _jsonMap = jsonDecode(_modelJsonController.text);
              }catch(e){
                _tipsBox('JSON转Map失败，请检查JSON字符串格式',Colors.red[400]!);
                return;
              }

              if(_modelRootNameController.text == ""){
                _tipsBox('请输入Model根名',Colors.orange);
                return;
              }

              _previewModel(_jsonMap,_modelRootNameController.text,_allString,_needFinal);
            },

            onLongPress: (){
              if(_modelPreviewJsonController.text == ''){
                _tipsBox('请先单击生成预览',Colors.red[400]!);
                return;
              }

              Clipboard.setData(ClipboardData(text: _modelPreviewJsonController.text));
              _tipsBox('复制成功', Colors.green);
            },
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            child: Container(
              child: const Text("生成Model文件",maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              alignment: Alignment.center,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: (){

              if(_modelFileNameController.text == ""){
                _tipsBox('请输入文件名', Colors.orange);
                return;
              }

              if(_modelJsonController.text == ""){
                _tipsBox('请输入接口报文JSON', Colors.orange);
                return;
              }

              Map _jsonMap;
              try{
                _jsonMap = jsonDecode(_modelJsonController.text);
              }catch(e){
                _tipsBox('JSON转Map失败，请检查JSON字符串格式', Colors.red[400]!);
                return;
              }

              if(_modelRootNameController.text == ""){
                _tipsBox('请输入Model根名', Colors.orange);
                return;
              }

              _makeModel(_jsonMap,_modelFileNameController.text,_modelRootNameController.text,_allString,_needFinal);
            },
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
                labelText: "点击'生成预览/生成Model文件'后这里会展示生成Model",
                labelStyle: TextStyle(color: Colors.black87,fontSize: 8),
                floatingLabelStyle: TextStyle(color: Colors.amber),
                alignLabelWithHint: false,
              ),
              maxLines: null,
              minLines: null,
              expands: true,
              textAlignVertical:TextAlignVertical.top,
              controller: _modelPreviewJsonController,
              autocorrect:false,
              style: const TextStyle(color: Colors.black,fontSize: 8),
            ),
          ),

        ],
      ),
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
        _tipsBox('$_file文件创建成功',Colors.green);
      }else{
        if(fileOverwriteAlreadyExists){
          _writeJSON(_file,data);
          _tipsBox('!!$_file文件进行覆盖!!',Colors.green);
        }else{
          _tipsBox('!!$_file文件已存在,请打开覆盖选项或自行修改文件!!',Colors.red[400]!);
        }
      }
    }catch(e){
      _tipsBox(e.toString(),Colors.red[400]!);
    }
  }

  //写入文件
  _writeJSON(File file,String obj) async{
    try {
      return file.writeAsString(obj);
    }
    catch (err) {
      _tipsBox(err.toString(),Colors.red[400]!);
    }
  }

  //制作
  _makeModel(Map map,String fileName,String modelRootName,bool allString , bool needFinal) async {
    List _resultList = [];
    int _recursionKey = 1;


    _resultList = await _disassemblyModel(map, _recursionKey, rootModelName: modelRootName, allString: allString, needFinal: needFinal);

    //第四步写入文件
    String _result = '';
    for (var it in _resultList) {
      _result += it + '\n';
    }
    setState(() {
      _modelPreviewJsonController.text = _result;
    });
    _createFile(_result, fileName: fileName, fileOverwriteAlreadyExists: _allowOverride);

  }

  //预览
  _previewModel(Map map,String modelRootName,bool allString , bool needFinal) async{
    List _resultList = [];
    int _recursionKey = 1;


    _resultList = await _disassemblyModel(map, _recursionKey, rootModelName: modelRootName, allString: allString ,needFinal: needFinal);

    //第四步写入文件
    String _result = '';
    for (var it in _resultList) {
      _result += it + '\n';
    }
    setState(() {
      _modelPreviewJsonController.text = _result;
    });

  }

  //原json，递归层数，model根姓名，是否除List外全部使用String
  _disassemblyModel(Map map,int insideMapLength,{String rootModelName = 'Automatic' , bool allString = false ,bool needFinal = true}){

    List modelList = [];
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
      _insideMapTitle2 = 'Inside' + (insideMapLength+1).toString() +'Data';
    }else{
      _insideMapTitle = 'Inside' + insideMapLength.toString() +'Data';
      _insideMapTitle2 = 'Inside' + (insideMapLength+1).toString() +'Data';
    }

    //新增头
    modelList.add("class " + rootModelName + _insideMapTitle + "{");
    modelListLength ++;

    //开始解析第一层
    map.forEach((key, value){
      //第一步，解析完成所有的key，并生成第一次的参数
      if(value.runtimeType != List){
        if(value is Map){
          //如果是Map类型进行一次解析
          {
            List _resultList = _disassemblyModel(value,insideMapLength,rootModelName: (key.toString() + 'Map'),allString: allString , needFinal:  needFinal);
            modelList.addAll(_resultList);
          }

          if(needFinal){
            modelList.insert(modelListLength++, "\tfinal " + key.toString() + 'Map' + _insideMapTitle + "? " + key.toString() + ";");
          }else{
            modelList.insert(modelListLength++, "\t" + key.toString() + 'Map' + _insideMapTitle + "? " + key.toString() + ";");
          }

        }else{

          if(needFinal){
            modelList.insert(modelListLength++, "\tfinal " + (allString ? "String" : value.runtimeType.toString()) + "? " + key.toString() + ";");//"final int? code;"
          }else{
            modelList.insert(modelListLength++, "\t" + (allString ? "String" : value.runtimeType.toString()) + "? " + key.toString() + ";");//"final int? code;"
          }
        }
      }else{
        //进行递归的第二层
        print(key.toString());
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
          List _resultList = _disassemblyModel(_insideMap,insideMapLength + 1,rootModelName: (key.toString() + "List"),allString: allString ,needFinal: needFinal);
          modelList.addAll(_resultList);
        }

        if(needFinal){
          modelList.insert(modelListLength++, "\tfinal List<" + rootModelName + _insideMapTitle2 +">? " + key.toString() + ";");//"final int? code;"
        }else{
          modelList.insert(modelListLength++, "\tList<" + rootModelName + _insideMapTitle2 +">? " + key.toString() + ";");//"final int? code;"
        }

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
        if(value is Map){//json['mapD'] != null ? new MapD.fromJson(json['mapD']) : null;
          modelList.insert(modelListLength++, "\t\t\t" + key.toString() + " : "
              + "json['" + key.toString() + "'] != null ? " + key.toString() + 'Map' + _insideMapTitle + ".fromJson(json['" + key.toString() + "']) : null,");
        }else{
          if(key.runtimeType == String || allString){
            modelList.insert(modelListLength++, "\t\t\t" + key.toString() + " : " + "json['" + key.toString() + "'].toString(),");
          }else{
            modelList.insert(modelListLength++, "\t\t\t" + key.toString() + " : " + "json['" + key.toString() + "'],");
          }
        }
      }else{
        modelList.insert(modelListLength++, "\t\t\t" + key.toString() + " : (json['" + key.toString() + "'] as List).map((i) => " + rootModelName + _insideMapTitle2 +".fromJson(i)).toList(),");//"final int? code;"
      }
    });
    modelList.insert(modelListLength++, "\t\t);");//"final int? code;"
    modelList.insert(modelListLength++, "\t}");//"final int? code;"
    modelList.insert(modelListLength++, "}");//"final int? code;"
    modelList.insert(modelListLength++, "");
    return modelList;
  }

  //提示
  void _tipsBox(String text,Color colors){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: "了解!",
          textColor: Colors.black,
          onPressed: (){
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        ),
        content:Text(text,style: const TextStyle(fontSize: 12),),
        backgroundColor: colors,
        padding:const EdgeInsets.fromLTRB(10, 15, 10, 15),
      ),
    );
  }
}
