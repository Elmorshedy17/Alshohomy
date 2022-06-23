import 'package:flutter/material.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_manager.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_response.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';
import 'package:shahowmy_app/features/home/widgets/open_list_tile.dart';
import 'package:shahowmy_app/shared/custom_bottom_sheet/custom_bottom_sheet.dart';
import 'package:shahowmy_app/shared/custom_list_tile/custom_list_tile.dart';
import 'package:shahowmy_app/shared/custom_text_field/custom_under_line_text_field.dart';
import 'package:shahowmy_app/shared/main_button/main_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/shared/remove_focus/remove_focus.dart';




class EnquiryWidget extends StatefulWidget {
  const EnquiryWidget({Key? key}) : super(key: key);

  @override
  State<EnquiryWidget> createState() => _EnquiryWidgetState();
}

class _EnquiryWidgetState extends State<EnquiryWidget> {

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  // AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController _numberController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();




  final numberFocus = FocusNode();

  final nameFocus = FocusNode();

  final destinationFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState

    if(!locator<SearchInfoManager>().subject.hasValue){
      locator<SearchInfoManager>().execute();

    }
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final searchInfoManager = context.use<SearchInfoManager>();
    final homeManager = context.use<HomeManager>();

    return Center(
      child: GestureDetector(
        onTap: (){
          removeFocus(context);
        },
        child: Material(
          color: Colors.transparent,
          child: Observer<SearchInfoResponse>(
              stream: searchInfoManager.subject.stream,
              onRetryClicked: (){
                searchInfoManager.execute();
              },
              onSuccess: (context, searchInfoSnapshot) {
              return Container(
                padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                // height: MediaQuery.of(context).size.height * .76,
                // width: MediaQuery.of(context).size.width * .8,
                // child:const SizedBox.expand(child: FlutterLogo()),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:const EdgeInsets.only(top: 15,right: 10,left: 10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                // Center(child: Text("استعلام",style: AppFontStyle.labelBlackStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 18),)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("استعلام",style: AppFontStyle.labelBlackStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 18),),
                                    InkWell(
                                        onTap: (){
                                          homeManager.resetManager(paginationReset: true, searchReset: true, statusReset: true);
                                          homeManager.reCallManager();
                                          searchInfoManager.resetDestinationsList();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("إعادة تعيين",style: AppFontStyle.labelBlackStyle.copyWith(fontSize: 12),)),

                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),

                          Column(
                children: [
                  //// number start
                  CustomUnderLineTextFiled(
                      onFieldSubmitted: (v){
                        FocusScope.of(context)
                            .requestFocus(nameFocus);
                      },
                      textStyle: AppFontStyle.textFiledHintStyle.copyWith(fontSize: 15,color: AppStyle.oil),
                      currentFocus: numberFocus,
                      keyboardType: TextInputType.number,
                      controller: _numberController,
                      labelText: "رقم",
                      hintText: "رقم",
                      validationBool: true,
                      validationErrorMessage: "",
                  ),
  
                  const SizedBox(
                      height: 25,
                  ),
                  //// number end





                  //// name start
                  CustomUnderLineTextFiled(
                     //  onFieldSubmitted: (v){
                     // removeFocus(context)();
                     //  },
                    onFieldSubmitted: (v){
                      FocusScope.of(context)
                          .requestFocus(destinationFocus);
                      searchInfoManager.open.sink.add(true);

                    },
                      currentFocus: nameFocus,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      labelText: "الاسم",
                      hintText: "الاسم",
                      validationBool: true,
                      validationErrorMessage: "",
                  ),
                  const SizedBox(
                      height: 25,
                  ),
                  //// name end



                  //// destination start
                  CustomAnimatedOpenTileWithoutDispose(
                    // headerTxt: statusSnapshot.data!.name,
                    headerWidget: StreamBuilder<Destination>(
                        initialData: Destination(
                          id: "",
                          name: "جهة",
                        ),
                        stream: homeManager.destinationSubject.stream,
                        builder: (context, statusSnapshot) {
                          // return Text("${statusSnapshot.data!.name}");
                          return Expanded(
                            child: TextField(


                              enabled: searchInfoManager.open.value == false ? false : true,
                              controller: locator<SearchInfoManager>().searchDestinationController,
                              focusNode: destinationFocus,
                              onSubmitted: (v){
                                // contactsInfoManager.searchInContacts(word: searchController.text);
                                // searchInfoManager.searchInDestinations(word: searchDestinationController.text);
                                removeFocus(context);
                                // FocusScope.of(context)
                                //     .requestFocus(destinationFocus);
                              },
                              onChanged: (v){

                                searchInfoManager.searchInDestinations(word: locator<SearchInfoManager>().searchDestinationController.text);

                              },
                              decoration: InputDecoration(
                                // hintStyle: TextStyle(fontSize: 17),
                                hintText: '${statusSnapshot.data!.name}',
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.symmetric(vertical: 10), //Change this value to custom as you like
                                isDense: true,
                              ),

                            ),
                          );
                        }
                    ),
                    body: Column(
                      children: [
                        // Card(
                        //   elevation: 3,
                        //   child: Row(
                        //     children: [
                        //       const Icon(Icons.search,color: AppStyle.oil,),
                        //       const SizedBox(
                        //         width: 7,
                        //       ),
                        //       Container(
                        //         height: 20,
                        //         width: 1,
                        //         color: AppStyle.oil,
                        //       ),
                        //       const SizedBox(
                        //         width: 10,
                        //       ),
                        //       Flexible(
                        //         child: TextField(
                        //           // onTap: (){
                        //           //   FocusScope.of(context)
                        //           //       .requestFocus(destinationFocus);
                        //           // },
                        //           // autofocus:true,
                        //
                        //           controller: searchDestinationController,
                        //           focusNode: destinationFocus,
                        //           onSubmitted: (v){
                        //             // contactsInfoManager.searchInContacts(word: searchController.text);
                        //             // searchInfoManager.searchInDestinations(word: searchDestinationController.text);
                        //             removeFocus(context)();
                        //             // FocusScope.of(context)
                        //             //     .requestFocus(destinationFocus);
                        //           },
                        //           onChanged: (v){
                        //             searchInfoManager.searchInDestinations(word: searchDestinationController.text);
                        //           },
                        //           decoration:const InputDecoration(
                        //             // hintStyle: TextStyle(fontSize: 17),
                        //             hintText: 'ابحث في الجهات',
                        //             border: InputBorder.none,
                        //             contentPadding: EdgeInsets.symmetric(vertical: 10), //Change this value to custom as you like
                        //             isDense: true,
                        //           ),
                        //
                        //         ),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),
                        StreamBuilder<List<Destination>>(
                            initialData: const [],
                            stream: searchInfoManager.destinationsSubject.stream,
                            builder: (context, destinationsListSnapshot) {
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: destinationsListSnapshot.data!.length,
                              physics:const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return  InkWell(
                                  onTap: (){
                                    // locator<SearchInfoManager>().searchDestinationController.text = destinationsListSnapshot.data![index].name!;

                                    homeManager.destinationSubject.sink.add(destinationsListSnapshot.data![index]);
                                    searchInfoManager.searchInDestinations(word: locator<SearchInfoManager>().searchDestinationController.text);
                                  },
                                  child: Container(
                                    padding:const EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Expanded(child: Text("${destinationsListSnapshot.data![index].name}",style: TextStyle(color: homeManager.destinationSubject.value.id == destinationsListSnapshot.data![index].id ? AppStyle.oil : Colors.black,fontWeight: homeManager.destinationSubject.value.id == destinationsListSnapshot.data![index].id ? FontWeight.bold : FontWeight.normal),)),
                                   if(homeManager.destinationSubject.value.id == destinationsListSnapshot.data![index].id)  const Icon(Icons.check,color: AppStyle.oil,)
                                      ],
                                    ),
                                  ),
                                );
                              }, separatorBuilder: (BuildContext context, int index) {
                              return const Divider();
                            },);
                          }
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(
                      height: 15,
                  ),
                  //// destination end



                  //// status end start
                  StreamBuilder<Destination>(
                    initialData: Destination(
                      id: "",
                      name:  "حالة",
                    ),
                    stream: homeManager.statusSubject.stream,
                    builder: (context, statusSnapshot) {
                      return CustomAnimatedOpenTile(
                          headerTxt: statusSnapshot.data!.name,
                          body: ListView.separated(
                              shrinkWrap: true,
                              itemCount: searchInfoSnapshot.data!.statusValues!.length,
                              physics:const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return  InkWell(
                                  onTap: (){
                                    homeManager.statusSubject.sink.add(searchInfoSnapshot.data!.statusValues![index]);
                                    homeManager.changeStatus(
                                        newStatusId: "${searchInfoSnapshot.data!.statusValues![index].id}",
                                        resetHomeStatus: true);
                                  },
                                  child: Container(
                                    padding:const EdgeInsets.only(top: 5),
                                    child: Text("${searchInfoSnapshot.data!.statusValues![index].name}"),
                                  ),
                                );
                              }, separatorBuilder: (BuildContext context, int index) {
                                return const Divider();
                          },),
                      );
                    }
                  ),

                  const SizedBox(
                      height: 15,
                  ),
                  //// status end
                ],
              ),

                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: MainButtonWidget(title: "بحث",width: 150.w,onClick: (){
                        homeManager.word = _nameController.text;
                        homeManager.searchId = _numberController.text;
                        homeManager.resetManager(paginationReset: true, searchReset: false, statusReset: false);
                        homeManager.reCallManager();
                        Navigator.of(context).pop();
                      }),
                    ),
                  ],
                ),
                // margin:const EdgeInsets.symmetric(horizontal: 20),
                // decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
              );
            }
          ),
        ),
      ),
    );
  }
}



void showEnquiryDialog (BuildContext context){
  customBottomSheet(
    context: context,
    bottomSheetHeight: 0.9,
    topBorderRadius: 20,
    childWidget:const EnquiryWidget(),
  );
}