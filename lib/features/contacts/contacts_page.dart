import 'package:flutter/material.dart';
import 'package:shahowmy_app/app_core/resources/app_style/app_style.dart';
import 'package:shahowmy_app/features/contacts/Contacts_response.dart';
import 'package:shahowmy_app/features/contacts/contacts_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/shared/not_available_widget/not_available_widget.dart';
import 'package:shahowmy_app/shared/remove_focus/remove_focus.dart';
import 'package:shahowmy_app/shared/url_launcher/url_launcher.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locator<ContactsInfoManager>().execute();
  }

  @override
  Widget build(BuildContext context) {
    final contactsInfoManager = context.use<ContactsInfoManager>();

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor:const Color(0xfff7f7f7),
        title: const Text("جهات الاتصال"),
        centerTitle: true,
        leading: const SizedBox(),
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child:const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.arrow_forward),
            ),
          )
        ],
      ),
      body: Observer<ContactsInfoResponse>(
          stream: contactsInfoManager.subject.stream,
          onRetryClicked: (){
            contactsInfoManager.execute();
          },
          onSuccess: (context, contactsSnapshot) {
          return StreamBuilder<List<Contact>>(
            initialData: const [],
            stream: contactsInfoManager.contactsSubject,
            builder: (context, contactsListSnapshot) {
              return Container(
                padding:const EdgeInsets.all(15),
                child: Stack(
                  children: [
                    contactsListSnapshot.data!.isNotEmpty ? Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: contactsListSnapshot.data!.length,
                            // physics:const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return  Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        Expanded(child: Text("الاسم : ${contactsListSnapshot.data![index].name}")),
                                          Icon(Icons.person,size: 20,color: Colors.blueAccent.withOpacity(.5),),

                                        ],),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text("الجهة : ${contactsListSnapshot.data![index].destination}")),
                                          Icon(Icons.home_work_outlined,size: 20,color: Colors.blueGrey.withOpacity(.5),),
                                        ],),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: (){
                                          openURL("tel://${contactsListSnapshot.data![index].phone}");
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text("رقم الهاتف : ${contactsListSnapshot.data![index].phone}",style:const TextStyle(color: AppStyle.oil),)),
                                            Icon(Icons.phone,size: 20,color: Colors.green.withOpacity(.5),),
                                          ],),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }, separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 25,
                              endIndent: 15,
                              indent: 15,
                              color: AppStyle.oil.withOpacity(.7),
                            );
                          },),
                        ),
                      ],
                    ):NotAvailableComponent(
              view: Icon(Icons.contact_phone_outlined,size: 125.sp,color: Colors.blueGrey.withOpacity(.4),),
              title: 'لا توجد جهات اتصال متاحه',
              ),
                    Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Card(
                          elevation: 3,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  contactsInfoManager.searchInContacts(word: searchController.text);
                                },
                                child:const SizedBox(
                                    width: 35,
                                    // color: Colors.red,
                                    child:  Icon(Icons.search,color: AppStyle.oil,)),
                              ),

                              Container(
                                height: 20,
                                width: 1,
                                color: AppStyle.oil,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextField(
                                  controller: searchController,
                                  onSubmitted: (v){
                                    contactsInfoManager.searchInContacts(word: searchController.text);
                                  },
                                  decoration:const InputDecoration(
                                    // hintStyle: TextStyle(fontSize: 17),
                                    hintText: 'ابحث',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 10), //Change this value to custom as you like
                                    isDense: true,
                                  ),

                                ),
                              ),
                              InkWell(
                                  onTap: (){
                                    contactsInfoManager.resetContactList();
                                    searchController.clear();
                                    removeFocus(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(Icons.clear,size: 17,color: Colors.blueGrey.withOpacity(.9),),
                                  )),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            }
          );
        }
      ),

    );
  }
}

