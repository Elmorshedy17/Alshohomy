import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';

import '../app_core.dart';

// ignore: must_be_immutable
class FormsStateHandling extends StatefulWidget {
  final ManagerState? managerState;
  final VoidCallback? onClickCloseErrorBtn;
  final Widget child;
  final String? errorMsg;

  const FormsStateHandling({
    Key? key,
    this.managerState = ManagerState.idle,
    required this.child,
    this.onClickCloseErrorBtn,
    this.errorMsg = '',
  }) : super(key: key);

  @override
  _FormsStateHandlingState createState() => _FormsStateHandlingState();
}

class _FormsStateHandlingState extends State<FormsStateHandling> {
  @override
  Widget build(BuildContext context) {
    if (widget.managerState == ManagerState.loading) {
      return Stack(
        children: [
          AbsorbPointer(
            child: widget.child,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // color: Colors.black12.withOpacity(0.34),
              color: Colors.transparent,
              child: const Center(
                child: SpinKitWave(
                  color: AppStyle.oil,
                  itemCount: 5,
                  size: 50.0,
                ),
              )),
        ],
      );
    } else if (widget.managerState == ManagerState.error) {
      return WillPopScope(
        onWillPop: () async {
          widget.onClickCloseErrorBtn!();
          return false;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: widget.onClickCloseErrorBtn,
              child: AbsorbPointer(
                child: widget.child,
              ),
            ),
            _errorWidget(context, DialogRequest(description: widget.errorMsg))
          ],
        ),
      );
    } else if (widget.managerState == ManagerState.unknownError) {
      return WillPopScope(
        onWillPop: () async {
          widget.onClickCloseErrorBtn!();
          return false;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: widget.onClickCloseErrorBtn,
              child: AbsorbPointer(
                child: widget.child,
              ),
            ),
            _errorWidget(context, DialogRequest(description: widget.errorMsg))
          ],
        ),
      );
    } else if (widget.managerState == ManagerState.socketError) {
      return WillPopScope(
        onWillPop: () async {
          widget.onClickCloseErrorBtn!();
          return false;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: widget.onClickCloseErrorBtn,
              child: AbsorbPointer(
                child: widget.child,
              ),
            ),
            _errorWidget(context, DialogRequest(description: widget.errorMsg))
          ],
        ),
      );
    } else {
      return widget.child;
    }
  }

  Widget _errorWidget(BuildContext context, DialogRequest request) {
    return FadeInUp(
      child: CustomDialog(
        titleColor: Colors.black,
        title: request.title,
        description: request.description,
        descriptionColor: AppStyle.oil,
        // imageInBodyUrl: AppAssets.DIALOG_CONFIRM,
        // onCloseBtn: widget.onClickCloseErrorBtn,
        confirmBtnTxt: "حاول مجددا",
        onClickConfirmBtn: widget.onClickCloseErrorBtn,
        confirmBtnColor: AppStyle.oil,
      ),
    );
  }
}
