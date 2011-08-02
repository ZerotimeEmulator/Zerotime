class PlayerCharacter {
	public var login: String;
	public var ses2: String;
	public var dl: Int;
	public var time: Int;
	public var loc_time: Int;
	public var nextlevel: Int;
	public var predlevel: Int;
	public var exp: Int;
	public var level: Int;
	public var cup_0: Int;
	public var cup_1: Int;
	public var cup_2: Int;
	public var str: Int;
	public var dex: Int;
	public var int: Int;
	public var pow: Int;
	public var acc: Int;
	public var intel: Int;
	public var maxHP: Int;
	public var HP: Int;
	public var psy: Int;
	public var maxPsy: Int;
	public var X: Int;
	public var dp_ef: Int;
	public var Y: Int;
	public var Z: Int;
	public var ROOM: Int;
	public var id1: Float;
	public var id2: Float;
	public var i1: Int;
	public var man: Int;
	public var hint: Int;
	public var tdt: Int;

	public function new(username: String) {
		login = username;
		dl = time = loc_time = Math.floor(Date.now().getTime() / 1000);
		nextlevel = 4000; predlevel = 900; exp = 1928;
		level = 2;
		str = 6; dex = 5; int = 6; pow = 9; acc = 1; intel = 0;
		maxHP = HP = 40; psy = maxPsy = 0;
		X = Y = Z = ROOM = 0;
		id1 = 56155668582.2; id2 = 56155668682.2;
		i1 = 9;
		man = 1;
		hint = 32788;
 		tdt = 4;
		dp_ef = 0;
		cup_0 = 0; cup_1 = 1; cup_2 = 2;
		ses2 = "03196741111654719951";
	}

	public function toXml() : Xml {
		var result: Xml = Xml.createElement("MYPARAM");

		for (field in Reflect.fields(this)) {
			result.set(field, Reflect.field(this, field) + "");
		}

		return result;
	}
}

