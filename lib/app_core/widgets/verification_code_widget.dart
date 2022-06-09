import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCodeWidget extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final ValueChanged<bool> onEditing;
  final TextInputType keyboardType;
  final int length;
  final double itemSize;
  // in case underline color is null it will use primaryColor from Theme
  final Color? underlineColor;
  final TextStyle textStyle;
  //TODO autofocus == true bug
  final bool autofocus;

  ///takes any widget, display it, when tap on that element - clear all fields
  final Widget? clearAll;

  VerificationCodeWidget({
    Key? key,
    required this.onCompleted,
    required this.onEditing,
    this.keyboardType = TextInputType.number,
    this.length = 4,
    this.underlineColor,
    this.itemSize = 50,
    this.textStyle = const TextStyle(fontSize: 25.0),
    this.autofocus = false,
    this.clearAll,
  })  : assert(length > 0),
        assert(itemSize > 0),
        super(key: key);

  @override
  _VerificationCodeWidgetState createState() => _VerificationCodeWidgetState();
}

class _VerificationCodeWidgetState extends State<VerificationCodeWidget>
    with SingleTickerProviderStateMixin {
  static final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];
  List<String> _code = [];
  int _currentIndex = 0;
  List<bool> hasValue = <bool>[];
  bool isEnabled = true;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _listFocusNode.clear();
    for (var i = 0; i < widget.length; i++) {
      _listFocusNode.add(FocusNode());
      _listControllerText.add(TextEditingController());
      _code.add('');
      hasValue.add(false);
    }
  }

  String _getInputVerify() {
    String verifyCode = "";
    for (var i = 0; i < widget.length; i++) {
      for (var index = 0; index < _listControllerText[i].text.length; index++) {
        if (_listControllerText[i].text[index] != "") {
          verifyCode += _listControllerText[i].text[index];
        }
      }
    }
    return verifyCode;
  }

  Widget _buildInputItem(int index) {
    return TextField(
      enabled: isEnabled,
      keyboardType: widget.keyboardType,
      maxLines: 1,
      maxLength: 1,
      controller: _listControllerText[index],
      focusNode: _listFocusNode[index],
      showCursor: true,


      // maxLengthEnforced: true,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      autocorrect: false,
      textAlign: TextAlign.center,
      autofocus: widget.autofocus,
      style: widget.textStyle,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: widget.underlineColor ?? Theme.of(context).primaryColor),
        ),
        counterText: "",
        contentPadding: EdgeInsets.all(((widget.itemSize * 2) / 10)),
        errorMaxLines: 1,
      ),
//      textInputAction: TextInputAction.previous,
      onChanged: (String value) {
        if ((_currentIndex + 1) == widget.length && value.isNotEmpty) {
          widget.onEditing(false);
        } else {
          widget.onEditing(true);
          isEditing = true;
        }
        _hasValue(index);

        if (value.isNotEmpty && index < widget.length ||
            index == 0 && value.isNotEmpty) {
          if (index == widget.length - 1) {
            widget.onCompleted(_getInputVerify());
            isEnabled = false;
            return;
          }

          if (_listControllerText[index + 1].value.text.isEmpty) {
            _listControllerText[index + 1].value =
                const TextEditingValue(text: "");
          }
          if (index < widget.length - 1) {
            _next(index);
          }

          return;
        }
        if (value.isEmpty && index >= 0) {
          _prev(index);
        }
      },
    );
  }

  void _hasValue(int index) {
    setState(() {
      if (_listControllerText[index].value.text.isEmpty) {
        hasValue[index] = false;
      } else {
        hasValue[index] = true;
      }
    });
  }

  void _next(int index) {
    if (index != widget.length - 1) {
      setState(() {
        _currentIndex = index + 1;
      });
      FocusScope.of(context).requestFocus(_listFocusNode[_currentIndex]);
    }
  }

  void _prev(int index) {
    if (index > 0) {
      setState(() {
        if (_listControllerText[index].text.isEmpty) {}
        _currentIndex = index - 1;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      FocusScope.of(context).requestFocus(_listFocusNode[_currentIndex]);
    }
  }

  List<Widget> _buildListWidget() {
    List<Widget> listWidget = <Widget>[];
    for (int index = 0; index < widget.length; index++) {
      double left = (index == 0) ? 0.0 : (widget.itemSize / 1.7);
      listWidget.add(Container(
          // padding: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: hasValue[index] ? Colors.black : Colors.grey[300],
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          height: widget.itemSize,
          width: widget.itemSize,
          margin: EdgeInsets.only(left: left),
          child: Center(child: _buildInputItem(index))));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildListWidget(),
            ),
            const SizedBox(
              height: 20,
            ),
            _clearAllWidget()
          ],
        ));
  }

  // Widget _clearAllWidget(child) {
  Widget _clearAllWidget() {
    return AnimatedSize(
      vsync: this,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 400),
      child: Container(
        margin: EdgeInsets.only(bottom: isEditing ? 20 : 0),
        width: isEditing ? 50 : 0,
        height: isEditing ? 50 : 0,
        child: GestureDetector(
          onTap: () {
            widget.onEditing(true);
            for (var i = 0; i < widget.length; i++) {
              _listControllerText[i].text = '';
              hasValue[i] = false;
              _code.clear();
              widget.onCompleted(_getInputVerify());
              isEnabled = true;
            }
            isEditing = false;

            setState(() {
              _currentIndex = 0;
              FocusScope.of(context).requestFocus(_listFocusNode[0]);
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            width: isEditing ? 50 : 0,
            height: isEditing ? 50 : 0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Icon(
              Icons.clear,
              color: Colors.black,
              size: isEditing ? 30 : 0,
            ),
          ),
        ),
      ),
    );
  }
}
