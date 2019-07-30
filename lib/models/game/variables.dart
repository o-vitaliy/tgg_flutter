
class Variables {

  String endvenuename;
  String endvenueaddress;
  String clientname;

	Variables.fromJsonMap(Map<String, dynamic> map): 
		endvenuename = map["endvenuename"],
		endvenueaddress = map["endvenueaddress"],
		clientname = map["clientname"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['endvenuename'] = endvenuename;
		data['endvenueaddress'] = endvenueaddress;
		data['clientname'] = clientname;
		return data;
	}
}
