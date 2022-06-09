import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';

import '../app_core.dart';

typedef _OnSuccessFunction<T> = Widget Function(BuildContext context, T data);
typedef _OnErrorFunction = Widget Function(BuildContext context, Object error);
typedef _OnWaitingFunction = Widget Function(BuildContext context);

class Observer<T> extends StatelessWidget {
  final Stream<T>? stream;

  final _OnSuccessFunction<T> onSuccess;
  final _OnWaitingFunction? onWaiting;
  final _OnErrorFunction? onError;
  // final Manager manager;
  final double errorWidgetMargin;
  final VoidCallback? onRetryClicked;

  Observer({
    Key? key,
    // required this.manager,
    required this.stream,
    required this.onSuccess,
    this.onWaiting,
    this.onError,
    this.errorWidgetMargin = 0.0,
    this.onRetryClicked,
  }) : super(key: key);

  final _retryManager = RetryManager();

  Function get _defaultOnWaiting => (context) => const Center(
        child: SpinKitWave(
          color: AppStyle.oil,
          itemCount: 5,
          size: 50.0,
        ),
      );
  Function get _defaultOnError => (context, error) {
        String errorMsg;
        if (error.error is SocketException) {
          // errorMsg = context.translate(AppStrings.NO_INTERNET_CONNECTION);
          errorMsg = 'لا يوجد إتصال بالشبكة';
          return Center(
            child: FittedBox(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: errorWidgetMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInDown(
                      duration: const Duration(seconds: 2),
                      child: Flash(
                        infinite: true,
                        duration: const Duration(seconds: 5),
                        child: Icon(
                          Icons.network_check,
                          color: AppStyle.oil,
                          size: 300.w,
                        ),
                      ),
                    ),
                    FadeInDown(
                      duration: const Duration(seconds: 2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorMsg,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FadeInUp(
                      duration: const Duration(seconds: 2),
                      child: SizedBox(
                        height: 55,
                        // width: MediaQuery.of(context).size.width * 0.5,
                        width: 225.w,
                        child: RaisedButton(
                          color: AppStyle.oil,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: AppStyle.oil,
                            ),
                          ),
                          child: Text(
                            // context.translate(AppStrings.RETRY),
                           'أعد المحاولة',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: onRetryClicked ??
                              () async {
                                // manager.streamDataObj();
                                // _retryManager.inRetry.add(true);
                                // await Future.delayed(const Duration(seconds: 1), () {
                                //   manager.streamDataObj();
                                //   _retryManager.inRetry.add(false);
                                // });
                                // manager.streamDataObj();
                              },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          // errorMsg = context.translate(AppStrings.SOMETHING_WENT_WRONG);
          errorMsg =  'حدث خطأ ما حاول مرة أخرى لاحقاً';

          return Center(
            child: FittedBox(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: errorWidgetMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInDown(
                      duration: const Duration(seconds: 2),
                      child: Flash(
                        infinite: true,
                        duration: const Duration(seconds: 5),
                        child: Icon(
                          Icons.error_outline_sharp,
                          color: AppStyle.oil,
                          size: 300.w,
                        ),
                      ),
                    ),
                    FadeInDown(
                      duration: const Duration(seconds: 2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorMsg,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FadeInUp(
                      duration: const Duration(seconds: 2),
                      child: SizedBox(
                        height: 55,
                        width: 225.w,
                        child: RaisedButton(
                          color: AppStyle.oil,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: AppStyle.oil,
                            ),
                          ),
                          child: Text(
                            // context.translate(AppStrings.RETRY),
                             'أعد المحاولة',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: onRetryClicked ??
                              () async {
                                // manager.streamDataObj();
                                // _retryManager.inRetry.add(true);
                                // await Future.delayed(const Duration(seconds: 1), () {
                                //   manager.streamDataObj();
                                //   _retryManager.inRetry.add(false);
                                // });
                                // manager.streamDataObj();
                              },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      };

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context);

    return StreamBuilder<bool>(
        initialData: false,
        stream: _retryManager.retry$,
        builder: (context, AsyncSnapshot<bool> retrySnapshot) {
          return retrySnapshot.data!
              ? _defaultOnWaiting(context)
              : StreamBuilder(
                  stream: stream,
                  builder: (context, AsyncSnapshot<T>? snapshot) {
                    if (snapshot!.hasError) {
                      return (onError != null)
                          ? onError!(context, snapshot.error!)
                          : _defaultOnError(context, snapshot.error);
                    }

                    if (snapshot.hasData) {
                      T data = snapshot.data!;
                      return onSuccess(context, data);
                    } else {
                      return (onWaiting != null)
                          ? onWaiting!(context)
                          : _defaultOnWaiting(context);
                    }
                  },
                );
        });
  }
}

class RetryManager extends Manager {
  final BehaviorSubject<bool> _retrySubject =
      BehaviorSubject<bool>.seeded(false);
  Stream<bool> get retry$ => _retrySubject.stream;
  Sink<bool> get inRetry => _retrySubject.sink;
  @override
  void dispose() {
    _retrySubject.close();
  }

  @override
  void clearSubject() {}
}
