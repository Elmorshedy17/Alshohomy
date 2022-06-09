// import 'package:image_picker/image_picker.dart';
// import 'package:meta/meta.dart';
//
// class MediaServiceBannerAndImage {
//   // bool isVideo = false;
//
//   final ImagePicker picker = ImagePicker();
//
//   XFile? _selectedImageBanner;
//   XFile? _selectedImage;
//
//   bool get hasSelectedImageBanner => _selectedImageBanner != null;
//   bool get hasSelectedImage => _selectedImage != null;
//   // BannerAndImage? bannerAndImage;
//   XFile? pickedXFileImage;
//   XFile? pickedXFileBanner;
//   XFile get selectedImageBanner => _selectedImageBanner!;
//   XFile get selectedImage => _selectedImage!;
//
//   removeSelectedBanner() {
//     _selectedImageBanner = null;
//   }
//   removeSelectedImage() {
//     _selectedImage = null;
//   }
//
//   removeSelectedImageAndBanner(){
//     removeSelectedBanner();
//     removeSelectedImage();
//   }
//
//   getImage({@required bool? fromGallery,@required bool? isBanner}) async {
//     if(isBanner == true){
//       pickedXFileBanner = await picker.pickImage(
//           source: fromGallery! ? ImageSource.gallery : ImageSource.camera);
//       if (pickedXFileBanner != null) {
//         _selectedImageBanner = XFile(pickedXFileBanner!.path);
//       }
//       print('xXx Original Image: $_selectedImageBanner');
//       return _selectedImageBanner;
//     }else{
//       pickedXFileImage = await picker.pickImage(
//           source: fromGallery! ? ImageSource.gallery : ImageSource.camera);
//       if (pickedXFileImage != null) {
//         _selectedImage = XFile(pickedXFileImage!.path);
//       }
//       print('xXx Original Image: $_selectedImage');
//       return _selectedImage;
//     }
//
//   }
// }
//
// //
// // class BannerAndImage{
// //   XFile? pickedXFileImage,pickedXFileBanner;
// //   BannerAndImage({this.pickedXFileBanner,this.pickedXFileImage});
// // }