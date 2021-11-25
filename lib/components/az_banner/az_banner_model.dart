List<AzBannerModel> getAzBannerModelList(List<dynamic> list){
	List<AzBannerModel> result = [];
	list.forEach((item){
		result.add(AzBannerModel.fromJson(item));
	});
	return result;
}

class AzBannerModel {
	String url;
	String title;
	String link;

	AzBannerModel({this.url, this.title, this.link});

	AzBannerModel.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		title = json['title'];
		link = json['link'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['url'] = this.url;
		data['title'] = this.title;
		data['link'] = this.link;
		return data;
	}
}
