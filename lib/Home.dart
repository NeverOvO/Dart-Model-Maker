
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double myFontSize = 12;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
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

  bool _needToJson = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _leftWidget(),
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
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            decoration: BoxDecoration(
              color: Colors.amberAccent.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
            child: Column(
              children: [
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
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: _allowOverride,
                        onChanged:(e){
                          setState(() {
                            _allowOverride = e;
                          });
                        },
                      ),
                    ),
                  ],
                ),
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
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: _allString,
                        onChanged:(e){
                          setState(() {
                            _allString = e;
                          });
                        },
                      ),
                    ),
                  ],
                ),
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
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: _needFinal,
                        onChanged:(e){
                          setState(() {
                            _needFinal = e;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text("ToJson功能",style: TextStyle(fontSize: myFontSize,fontWeight: FontWeight.w600)),
                        IconButton(
                          onPressed: (){
                            _tipsBox('启用此选项后，将生成ToJson模块，支持model类转换为Map/JSON；关闭后不额外生成',Colors.orange);
                          },
                          icon: const Icon(Icons.question_answer,color: Colors.orangeAccent,size: 15,),),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: _needToJson,
                        onChanged:(e){
                          setState(() {
                            _needToJson = e;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              alignment: Alignment.center,
              child: const Text("生成预览(长按复制)",style: TextStyle(color: Colors.black87),),
            ),
            onTap: () async{

              if(_modelJsonController.text == ""){
                _tipsBox('请输入接口报文JSON',Colors.orange);
                return;
              }

              Map jsonMap;
              try{
                jsonMap = jsonDecode(_modelJsonController.text);
              }catch(e){
                _tipsBox('JSON转Map失败，请检查JSON字符串格式',Colors.red[400]!);
                return;
              }

              if(_modelRootNameController.text == ""){
                _tipsBox('请输入Model根名',Colors.orange);
                return;
              }

              _previewModel(jsonMap,_modelRootNameController.text);
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
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              alignment: Alignment.center,
              child: const Text("生成Model文件",style: TextStyle(color: Colors.black87),),
            ),
            onTap: (){

              if(_modelFileNameController.text == ""){
                _tipsBox('请输入文件名', Colors.orange);
                return;
              }

              if(_modelJsonController.text == ""){
                _tipsBox('请输入接口报文JSON', Colors.orange);
                return;
              }

              Map jsonMap;
              try{
                jsonMap = jsonDecode(_modelJsonController.text);
              }catch(e){
                _tipsBox('JSON转Map失败，请检查JSON字符串格式', Colors.red[400]!);
                return;
              }

              if(_modelRootNameController.text == ""){
                _tipsBox('请输入Model根名', Colors.orange);
                return;
              }

              _makeModel(jsonMap,_modelFileNameController.text,_modelRootNameController.text);
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
    File file = File('$selectedDirectory/$fileName.dart');
    try{
      bool exists = await file.exists();
      if (!exists) {
        await file.create();
        _writeJSON(file,data);
        _tipsBox('$file文件创建成功',Colors.green);
      }else{
        if(fileOverwriteAlreadyExists){
          _writeJSON(file,data);
          _tipsBox('!!$file文件进行覆盖!!',Colors.green);
        }else{
          _tipsBox('!!$file文件已存在,请打开覆盖选项或自行修改文件!!',Colors.red[400]!);
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
  _makeModel(Map map,String fileName,String modelRootName) async {
    List resultList = [];
    int recursionKey = 1;

    try{
      resultList = await _disassemblyModel(map, recursionKey, rootModelName: modelRootName);

      //第四步写入文件
      String result = '';
      for (var it in resultList) {
        result += it + '\n';
      }
      setState(() {
        _modelPreviewJsonController.text = result;
      });
      _createFile(result, fileName: fileName, fileOverwriteAlreadyExists: _allowOverride);
    }catch(e){
      setState(() {
        _modelPreviewJsonController.text = "预览生成错误,错误原因为$e\n请检查Json格式是否正确,或前往https://github.com/NeverOvO/Dart-Model-Maker提交issues";
      });
    }

  }

  //预览
  _previewModel(Map map,String modelRootName) async{
    _modelPreviewJsonController.text = "";
    List resultList = [];
    int recursionKey = 1;

    try{
      resultList = await _disassemblyModel(map, recursionKey, rootModelName: modelRootName);

      //第四步写入文件
      String result = '';
      for (var it in resultList) {
        result += it + '\n';
      }
      setState(() {
        _modelPreviewJsonController.text = result;
      });
    }catch(e){
      setState(() {
        _modelPreviewJsonController.text = "预览生成错误,错误原因为$e\n请检查Json格式是否正确,或前往https://github.com/NeverOvO/Dart-Model-Maker提交issues";
      });
    }


  }

  //原json，递归层数，model根姓名，是否除List外全部使用String
  _disassemblyModel(Map map,int insideMapLength,{String rootModelName = 'Automatic'}){

    List modelList = [];
    int modelListLength = 0;

    String insideMapTitle = 'Model';
    String insideMapTitle2 = 'Data';

    if(insideMapLength == 1){
      insideMapTitle = 'Model';
      insideMapTitle2 = 'Data';
    }else if(insideMapLength == 2){
      insideMapTitle = 'Data';
      insideMapTitle2 = 'ListData';
    }else if(insideMapLength == 3){
      insideMapTitle = 'ListData';
      insideMapTitle2 = 'Inside${insideMapLength+1}Data';
    }else{
      insideMapTitle = 'Inside${insideMapLength}Data';
      insideMapTitle2 = 'Inside${insideMapLength+1}Data';
    }

    //新增头
    modelList.add("class $rootModelName$insideMapTitle{");
    modelListLength ++;

    //开始解析第一层
    map.forEach((key, value){
      //第一步，解析完成所有的key，并生成第一次的参数
      if(value.runtimeType != List){
        if(value is Map){
          //如果是Map类型进行一次解析

          String className = key.toString();
          if(className == "data"){
            className = rootModelName;
          }else{
            className = _toUpperCaseFirst(key.toString());
          }

          {
            List resultList = _disassemblyModel(value,insideMapLength + 1,rootModelName: className);
            modelList.addAll(resultList);
          }

          if(_needFinal){
            modelList.insert(modelListLength++, "\tfinal $className$insideMapTitle2? $key;");
          }else{
            modelList.insert(modelListLength++, "\t$className$insideMapTitle2? $key;");
          }

        }else if(value.runtimeType.toString() == "Null"){ // 特别处理null类型
          if(_needFinal){
            modelList.insert(modelListLength++, "\tfinal String? $key;//请注意:原类型为Null");//"final int? code;"
          }else{
            modelList.insert(modelListLength++, "\tString? $key;//请注意:原类型为Null");//"final int? code;"
          }
        }else{
          if(_needFinal){
            modelList.insert(modelListLength++, "\tfinal ${_allString ? "String" : value.runtimeType.toString()}? $key;");//"final int? code;"
          }else{
            modelList.insert(modelListLength++, "\t${_allString ? "String" : value.runtimeType.toString()}? $key;");//"final int? code;"
          }
        }
      }else{
        //进行递归的第二层
        List vv = value;
        Map insideMap;

        String className = key.toString();
        if(className == "data"){
          className = rootModelName;
        }else{
          className = _toUpperCaseFirst(key.toString());
        }

        if(vv.isEmpty){ // 数组为空时直接将其定义为普通数组
          if(_needFinal){
            modelList.insert(modelListLength++, "\tfinal List? $key;");//"final int? code;"
          }else{
            modelList.insert(modelListLength++, "\tList? $key;");//"final int? code;"
          }
        }else{
          if(vv.first is Map){
            insideMap = vv.first;
          }else if(vv.first is String){
            insideMap = jsonDecode(vv.first);
          }else{
            insideMap = {};//这里就不进行处理了 让用户自己搞定
          }

          {
            List resultList = _disassemblyModel( insideMap,insideMapLength + 1,rootModelName: className);
            modelList.addAll(resultList);
          }

          if(_needFinal){
            modelList.insert(modelListLength++, "\tfinal List<$className$insideMapTitle2>? $key;");//"final int? code;"
          }else{
            modelList.insert(modelListLength++, "\tList<$className$insideMapTitle2>? $key;");//"final int? code;"
          }
        }

      }
    });
    modelList.insert(modelListLength++, "");

    //第二步，生成Constructor
    String k1String = '';
    map.forEach((key, value) {
      k1String += "${'this.' + key},";
    });
    modelList.insert(modelListLength++, "\t" + rootModelName + insideMapTitle +"({" + k1String + '});');//"final int? code;"

    //第三步生成工厂类
    modelList.insert(modelListLength++, "");
    modelList.insert(modelListLength++, "\tfactory $rootModelName$insideMapTitle.fromJson(Map<dynamic, dynamic> json) {");//"final int? code;"
    modelList.insert(modelListLength++, "\t\treturn $rootModelName$insideMapTitle(");//"final int? code;"
    map.forEach((key, value) {
      if(value.runtimeType != List){
        if(value is Map){
          String className = key.toString();
          if(className == "data"){
            className = rootModelName;
          }else{
            className = _toUpperCaseFirst(key.toString());
          }
          modelList.insert(modelListLength++, "\t\t\t$key : json['$key'] != null ? $className$insideMapTitle2.fromJson(json['$key']) : null,");
        }else{
          if(value.runtimeType == String || _allString || value.runtimeType.toString() == "Null"){
            modelList.insert(modelListLength++, "\t\t\t$key : json['$key'].toString(),");
          }else{
            modelList.insert(modelListLength++, "\t\t\t$key : json['$key'],");
          }
        }
      }else{
        String className = key.toString();
        if(className == "data"){
          className = rootModelName;
        }else{
          className = _toUpperCaseFirst(key.toString());
        }
        List vv = value;
        if(vv.isEmpty){
          modelList.insert(modelListLength++, "\t\t\t$key : json['$key'],");//"final int? code;"
        }else{
          modelList.insert(modelListLength++, "\t\t\t$key : (json['$key'] as List).map((i) => $className$insideMapTitle2.fromJson(i)).toList(),");//"final int? code;"
        }
      }
    });
    modelList.insert(modelListLength++, "\t\t);");//"final int? code;"
    modelList.insert(modelListLength++, "\t}");//"final int? code;"

    if(_needToJson){
      //第四部生产ToJSon
      modelList.insert(modelListLength++, "");
      modelList.insert(modelListLength++, "\tMap<String,dynamic> toJson(){");
      modelList.insert(modelListLength++, "\t\tfinal Map<String,dynamic> jsonMap = <String,dynamic>{");
      map.forEach((key, value) {
        modelList.insert(modelListLength++, "\t\t\t\"$key\" : $key,");
      });
      modelList.insert(modelListLength++, "\t\t};");
      modelList.insert(modelListLength++, "\t\treturn jsonMap;");
      modelList.insert(modelListLength++, "\t}");
    }

    //结尾
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

  String _toUpperCaseFirst(String name){
    return name[0].toUpperCase() + name.substring(1);
  }
}
