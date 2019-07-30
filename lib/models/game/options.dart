
class Options {

  String video_quality;
  bool video_disable_rotation;

	Options.fromJsonMap(Map<String, dynamic> map): 
		video_quality = map["video_quality"],
		video_disable_rotation = map["video_disable_rotation"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['video_quality'] = video_quality;
		data['video_disable_rotation'] = video_disable_rotation;
		return data;
	}
}
