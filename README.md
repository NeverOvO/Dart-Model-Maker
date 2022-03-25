#更新日志

## 2022.3.25更新日志
- 1：对List参数，若List为空时出现解析错误，修正：List参数若为空时，则将其仅定义为"List 参数名"；
- 2：对value为Null的情况下，key的runtimeType为Null，为了避免一些错误，我将Null类型全部转换为String类型，且在后面会加上注释："//请注意:原类型为Null"；
- 3：优化了按钮点击后的体验，在发生了一些错误的情况下，程序可能无任何的返回，本次更新后会在预览窗口提示部分Json解析中出现的错误；
- 4：个人使用中，对于最外层的data参数，在旧版本的情况下，他直接会被叫做 DataMap、DataData等，此版本，将data的参数名称特殊处理，采用rootName来定义，例：rootNameData；
- 5：将Class名称的开头字母大写，来避免Flutter的规范化提醒，此为默认项，后续有需要会将此功能作为可选。

# Dart模型制作 （Dart Model Maker ）

使用递归来实现多层model，理论上支持三层以上的json，但是没测试过，之后慢慢优化修改。
支持用户自选路径，在自选路径下存在同名文件时将有一个参数控制是否覆盖文件。

后续应该会给打包出来作为一个小工具使用，目前考虑的是：
- 支持定义文件名
- 定义class名称
- 是否将所有非List参数修改为String
- 是否需要增加final关键字

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
