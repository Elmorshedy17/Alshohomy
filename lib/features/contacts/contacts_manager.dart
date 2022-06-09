import 'package:rxdart/rxdart.dart';
import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:shahowmy_app/features/contacts/Contacts_response.dart';
import 'package:shahowmy_app/features/contacts/contacts_repo.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_repo.dart';
import 'package:shahowmy_app/features/get_search_info/get_search_info_response.dart';
import 'package:shahowmy_app/features/home/home_manager.dart';



class ContactsInfoManager extends Manager<ContactsInfoResponse> {
  final BehaviorSubject<ContactsInfoResponse> subject =
  BehaviorSubject<ContactsInfoResponse>();

  final BehaviorSubject<List<Contact>> contactsSubject =
  BehaviorSubject<List<Contact>>();

List<Contact> contacts = [];

void resetContactList(){
  contacts.clear();
  contacts = List.from(subject.value.contact!);
  contactsSubject.sink.add(contacts);
}

void searchInContacts({required String word}){
  contacts.clear();
  for (var contact in subject.value.contact!) {
    if(contact.name!.contains(word) || contact.phone!.contains(word) || contact.destination!.contains(word)){
      contacts.add(contact);
    }
  }
  contactsSubject.sink.add(contacts);
}

  void execute(){
   ContactsInfoRepo.getContactsInfo().then((value) {
      if (value.error == null) {
        subject.add(value);
     contacts = List.from(value.contact!);
        contactsSubject.sink.add(contacts);
      } else {
        subject.addError(value.error);
      }
    });
  }



  @override
  void dispose() {}

  @override
  void clearSubject() {}
}

