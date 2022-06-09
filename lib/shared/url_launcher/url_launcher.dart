import 'package:shahowmy_app/app_core/app_core.dart';
import 'package:url_launcher/url_launcher.dart';

openURL(urlLink) async {
  var url = urlLink;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  } else {
    locator<ToastTemplate>().show('Could not launch $url');
  }
}
