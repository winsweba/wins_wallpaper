class WallpaperModel {
  String photograher;
  String photograher_url;
  int photograher_id;
  SrcModel src;

  WallpaperModel({
  this.photograher,
  this.photograher_url, 
  this.photograher_id, 
  this.src,});

  factory WallpaperModel.fromMap( 
    Map<String, dynamic> jsonData){
      return WallpaperModel(
        src: SrcModel.fromMap(jsonData["src"]),
        //src: jsonData["src"],
        photograher_url: jsonData["photograher_url"],
        photograher_id: jsonData["photograher_id"],
        photograher: jsonData["photograher"], 
      );
  }

}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel({
    this.original,
    this.small,
    this.portrait
  });

   factory SrcModel.fromMap( 
    Map<String, dynamic> jsonData){
      return SrcModel( 
        portrait: jsonData["portrait"],
        original: jsonData["original"],
        small: jsonData["small"], 
      );
      } 
}