import 'package:hmpaisrn/data/agencies.dart';

class Rocket {
  String name;
  int id;
  String defaultPads;
  String wikiURL;
  String changed;
  List<String> infoURLs;
  String originalImageURL;
  String thumbImageURL;
  String detailImageURL;
  List<int> imageSizes;
  Agencies agencies;
  String familyname;

  Rocket(
      {this.id,
      this.name,
      this.defaultPads,
      this.wikiURL,
      this.changed,
      this.infoURLs,
      this.originalImageURL,
      this.imageSizes,
      this.agencies,
      this.familyname});

  Rocket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    defaultPads = json['defaultPads'];
    wikiURL = json['wikiURL'];
    changed = json['changed'];
    familyname = json['familyname'];
    infoURLs = List.castFrom(json['infoURLs']);
    originalImageURL = json['imageURL'];
    imageSizes = List.castFrom(json['imageSizes']);
    if (json['agencies'] != null && List.castFrom(json['agencies']).isNotEmpty)
      agencies = Agencies.fromJson(json['agencies'][0]);

    // default rocket img if there is none provided
    if (originalImageURL == '' || originalImageURL == 'Array') {
      originalImageURL =
          'https://s3.amazonaws.com/launchlibrary/RocketImages/placeholder_320.png';
    }

    // set default if imageSizes is empty
    thumbImageURL = originalImageURL;
    detailImageURL = originalImageURL;

    if (imageSizes.length > 0) {
      final smallestImageSize = imageSizes.first;
      final largestImageSize = imageSizes.last;

      // example: "https://s3.amazonaws.com/launchlibrary/RocketImages/Falcon9Block5.jpg_1920.jpg"
      final prePostUrl = originalImageURL.split('_');

      if (prePostUrl.length > 1) {
        // pos 0 is the resolution, pos 1 the file ending
        final resEnding = prePostUrl[1].split('.');

        thumbImageURL = "${prePostUrl[0]}_$smallestImageSize.${resEnding[1]}";
        detailImageURL = "${prePostUrl[0]}_$largestImageSize.${resEnding[1]}";
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['defaultPads'] = this.defaultPads;
    data['wikiURL'] = this.wikiURL;
    data['changed'] = this.changed;
    data['infoURLs'] = this.infoURLs;
    data['imageURL'] = this.originalImageURL;
    data['imageSizes'] = this.imageSizes;
    return data;
  }
}
