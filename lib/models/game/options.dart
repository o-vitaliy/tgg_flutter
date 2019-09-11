
class Options {

  String videoQuality;
  bool videoDisableRotation;

	Options.fromJsonMap(Map<String, dynamic> map): 
		videoQuality = map["video_quality"],
		videoDisableRotation = map["video_disable_rotation"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['video_quality'] = videoQuality;
		data['video_disable_rotation'] = videoDisableRotation;
		return data;
	}
}
