package db.struct;

class SCharacter implements ICharacter {
	public var login: String;
	public var ses2: String;
	public var dl: Int;
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
    public var ODratio: Int;
	public var dp_eff: Int;
	public var Y: Int;
	public var Z: Int;
	public var ROOM: Int;
	public var id1: Float;
	public var id2: Float;
	public var i1: Int;
	public var man: Int;
	public var hint: Int;
	public var tdt: Int;
	public var items: Array<SItem>;
    public function new() {}
}
