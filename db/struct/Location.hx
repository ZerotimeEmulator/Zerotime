package db.struct;

class Location {
	public var name:           String,
	public var X:              Int,
	public var Y:              Int,
	public var time:           Int,
	public var t:              String,
	public var n:              Int,
	public var bot:            Bool,
	public var road:           Bool,
	public var o:              Int,
	public var z:              Int,
	public var repair:         Bool,
	public var bigland:        Array<Decoration>,
	public var house:          Array<House>,
	public var road_quality:   Int
    public function new() {
        bigland = new Array();
        house = new Array();
    }
}

typedef Decpration = { name: String, X: Int, Y: Int };
typedef House = {> Decoration, Z: Int, repair: Bool, maxl: Int };
