class Location {
	public var name: String; // location name
	public var X: Int; // X coord
	public var Y: Int; // Y coord
	public var time: Int; // time
	public var t: Int; // type
	public var n: Int; // ??? music
	public var bot: Int; // dome
	public var road: Int; // road
	public var o: Int; // radiation
	public var z: Int; // waste
	public var repair: Int; // repair
	public var road_quality: Int; // road quality
	public var bigland: Array<{ X: Int, Y: Int, type: String }>; // decorations array

	public function new(X: Int, Y: Int) {
									xml.set("X", i + "");
								xml.set("Y", j + "");
								xml.set("name", "Fucking Locatioin");
								xml.set("time", "0");
								xml.set("t", "A");
								xml.set("n", "1");
								xml.set("m", "l1:5:5");
	
	}

	public function toXml() : Xml {
		var result: Xml = Xml.createElement("L");

		for (field in Reflect.fields(this)) {
			switch (field) {
				case "bigland":
					var m: String = "";
					for (decor in bigland)
						m += (if (m != "") "," else "") + decor.type + ":" + decor.X + ":" + decor.Y;
					result.set("m", m);
				default:
					result.set(field, Reflect.field(this, field) + "");
			}
		}

		return result;
	}
}
