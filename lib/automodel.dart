class neverRootResponseModel{
	final String? code;
	final String? msg;
	final mapDMapModel? mapD;
	final List<neverRootResponseData>? data;

	neverRootResponseModel({this.code, this.msg, this.mapD, this.data, });

	factory neverRootResponseModel.fromJson(Map<dynamic, dynamic> json) {
		return neverRootResponseModel(
			code : json['code'].toString(),
			msg : json['msg'].toString(),
			mapD : json['mapD'] != null ? mapDMapModel.fromJson(json['mapD']) : null,
			data : (json['data'] as List).map((i) => neverRootResponseData.fromJson(i)).toList(),
		);
	}
}

class mapDMapModel{
	final String? instType;
	final String? instId;
	final String? last;
	final String? lastSz;
	final String? askPx;
	final String? askSz;
	final String? bidPx;
	final String? bidSz;
	final String? open24h;
	final String? high24h;
	final String? low24h;
	final String? volCcy24h;
	final String? vol24h;
	final String? ts;
	final String? sodUtc0;
	final sodUtc8MapModel? sodUtc8;

	mapDMapModel({this.instType, this.instId, this.last, this.lastSz, this.askPx, this.askSz, this.bidPx, this.bidSz, this.open24h, this.high24h, this.low24h, this.volCcy24h, this.vol24h, this.ts, this.sodUtc0, this.sodUtc8, });

	factory mapDMapModel.fromJson(Map<dynamic, dynamic> json) {
		return mapDMapModel(
			instType : json['instType'].toString(),
			instId : json['instId'].toString(),
			last : json['last'].toString(),
			lastSz : json['lastSz'].toString(),
			askPx : json['askPx'].toString(),
			askSz : json['askSz'].toString(),
			bidPx : json['bidPx'].toString(),
			bidSz : json['bidSz'].toString(),
			open24h : json['open24h'].toString(),
			high24h : json['high24h'].toString(),
			low24h : json['low24h'].toString(),
			volCcy24h : json['volCcy24h'].toString(),
			vol24h : json['vol24h'].toString(),
			ts : json['ts'].toString(),
			sodUtc0 : json['sodUtc0'].toString(),
			sodUtc8 : json['sodUtc8'] != null ? sodUtc8MapModel.fromJson(json['sodUtc8']) : null,
		);
	}
}

class sodUtc8MapModel{
	final String? instType;
	final String? instId;
	final String? last;
	final String? lastSz;
	final String? askPx;
	final String? askSz;
	final String? bidPx;
	final String? bidSz;
	final String? open24h;
	final String? high24h;
	final String? low24h;
	final String? volCcy24h;
	final String? vol24h;
	final String? ts;
	final String? sodUtc0;
	final List<sodUtc8MapData>? sodUtc8;

	sodUtc8MapModel({this.instType, this.instId, this.last, this.lastSz, this.askPx, this.askSz, this.bidPx, this.bidSz, this.open24h, this.high24h, this.low24h, this.volCcy24h, this.vol24h, this.ts, this.sodUtc0, this.sodUtc8, });

	factory sodUtc8MapModel.fromJson(Map<dynamic, dynamic> json) {
		return sodUtc8MapModel(
			instType : json['instType'].toString(),
			instId : json['instId'].toString(),
			last : json['last'].toString(),
			lastSz : json['lastSz'].toString(),
			askPx : json['askPx'].toString(),
			askSz : json['askSz'].toString(),
			bidPx : json['bidPx'].toString(),
			bidSz : json['bidSz'].toString(),
			open24h : json['open24h'].toString(),
			high24h : json['high24h'].toString(),
			low24h : json['low24h'].toString(),
			volCcy24h : json['volCcy24h'].toString(),
			vol24h : json['vol24h'].toString(),
			ts : json['ts'].toString(),
			sodUtc0 : json['sodUtc0'].toString(),
			sodUtc8 : (json['sodUtc8'] as List).map((i) => sodUtc8MapData.fromJson(i)).toList(),
		);
	}
}

class sodUtc8MapData{
	final String? instType;
	final String? instId;
	final String? last;
	final String? lastSz;
	final String? askPx;
	final String? askSz;
	final String? bidPx;
	final String? bidSz;
	final String? open24h;
	final String? high24h;
	final String? low24h;
	final String? volCcy24h;
	final String? vol24h;
	final String? ts;
	final String? sodUtc0;
	final String? sodUtc8;

	sodUtc8MapData({this.instType, this.instId, this.last, this.lastSz, this.askPx, this.askSz, this.bidPx, this.bidSz, this.open24h, this.high24h, this.low24h, this.volCcy24h, this.vol24h, this.ts, this.sodUtc0, this.sodUtc8, });

	factory sodUtc8MapData.fromJson(Map<dynamic, dynamic> json) {
		return sodUtc8MapData(
			instType : json['instType'].toString(),
			instId : json['instId'].toString(),
			last : json['last'].toString(),
			lastSz : json['lastSz'].toString(),
			askPx : json['askPx'].toString(),
			askSz : json['askSz'].toString(),
			bidPx : json['bidPx'].toString(),
			bidSz : json['bidSz'].toString(),
			open24h : json['open24h'].toString(),
			high24h : json['high24h'].toString(),
			low24h : json['low24h'].toString(),
			volCcy24h : json['volCcy24h'].toString(),
			vol24h : json['vol24h'].toString(),
			ts : json['ts'].toString(),
			sodUtc0 : json['sodUtc0'].toString(),
			sodUtc8 : json['sodUtc8'].toString(),
		);
	}
}

class neverRootResponseData{
	final String? instType;
	final String? instId;
	final String? last;
	final String? lastSz;
	final String? askPx;
	final String? askSz;
	final String? bidPx;
	final String? bidSz;
	final String? open24h;
	final String? high24h;
	final String? low24h;
	final String? volCcy24h;
	final String? vol24h;
	final String? ts;
	final String? sodUtc0;
	final String? sodUtc8;

	neverRootResponseData({this.instType, this.instId, this.last, this.lastSz, this.askPx, this.askSz, this.bidPx, this.bidSz, this.open24h, this.high24h, this.low24h, this.volCcy24h, this.vol24h, this.ts, this.sodUtc0, this.sodUtc8, });

	factory neverRootResponseData.fromJson(Map<dynamic, dynamic> json) {
		return neverRootResponseData(
			instType : json['instType'].toString(),
			instId : json['instId'].toString(),
			last : json['last'].toString(),
			lastSz : json['lastSz'].toString(),
			askPx : json['askPx'].toString(),
			askSz : json['askSz'].toString(),
			bidPx : json['bidPx'].toString(),
			bidSz : json['bidSz'].toString(),
			open24h : json['open24h'].toString(),
			high24h : json['high24h'].toString(),
			low24h : json['low24h'].toString(),
			volCcy24h : json['volCcy24h'].toString(),
			vol24h : json['vol24h'].toString(),
			ts : json['ts'].toString(),
			sodUtc0 : json['sodUtc0'].toString(),
			sodUtc8 : json['sodUtc8'].toString(),
		);
	}
}

