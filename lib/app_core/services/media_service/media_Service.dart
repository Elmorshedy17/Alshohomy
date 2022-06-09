// import 'package:image_picker/image_picker.dart';
// import 'package:meta/meta.dart';
//
// class MediaService {
//   bool isVideo = false;
//
//   final ImagePicker picker = ImagePicker();
//
//   XFile? _selectedImage;
//
//   bool get hasSelectedImage => _selectedImage != null;
//   XFile? pickedXFile;
//   XFile get selectedImage => _selectedImage!;
//
//   removeSelectedImage() {
//     _selectedImage = null;
//   }
//
//   getImage({@required bool? fromGallery}) async {
//     pickedXFile = await picker.pickImage(
//         source: fromGallery! ? ImageSource.gallery : ImageSource.camera);
//     if (pickedXFile != null) {
//       _selectedImage = XFile(pickedXFile!.path);
//     }
//     print('xXx Original Image: $_selectedImage');
//     return _selectedImage;
//   }
//
//
//
//   getVideo({@required bool? fromGallery}) async {
//     pickedXFile = await picker.pickVideo(
//         source: fromGallery! ? ImageSource.gallery : ImageSource.camera);
//     if (pickedXFile != null) {
//       _selectedImage = XFile(pickedXFile!.path);
//     }
//     print('xXx Original Image: $_selectedImage');
//     return _selectedImage;
//   }
//
// }
//
//
