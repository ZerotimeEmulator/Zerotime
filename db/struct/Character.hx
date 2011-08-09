package db.struct;

class Character {
	public var login: String;
	public var level: Int;
    public var pro: Int;
    public var propwr: Float;
	public var man: Int;
    public var clan: String;
    public var img: String;
    public var god: Int;

	public var HP: Int;
	public var psy: Int;
	public var maxHP: Int;
	public var maxPsy: Int;
    public var brokenslots: String;
    public var sp_head: Float;
    public var sp_left: Float;
    public var sp_right: Float;
    public var sp_foot: Float;
    
    public var ODratio: Int;
    public var poisoning: Int;
    public var paralyzed: Int;
    public var dazzling: Int;
    public var panic: Int;
    public var hallucination: Int;
    public var contusion: Int;
    public var zombie: Int;
    public var virus: Int;
    public var nark: Int;
    public var gluk: Int;
	public var dp_eff: Int;

	public var exp: Int;
    public var nextlevel: Int;
	public var predlevel: Int;
    public var empty_up: Int;
    public var empty_perk: Int;

    public var dl: Float;
	public var loc_time: Float;
	public var tdt: Int;
	
    public var cup_0: Int;
	public var cup_1: Int;
	public var cup_2: Int;
    public var cup_3: Int;
    public var silv: Int;

	public var str: Int;
	public var dex: Int;
    public var int: Int;
	public var pow: Int;
	public var acc: Int;
	public var intel: Int;
    public var ne: Array<Int>;

    public var sk: Array<Float>;
    public var ne2: Array<Float>;

    public var r_p: Float;
    public var dpsy: String;

	public var X: Int;
	public var Y: Int;
	public var Z: Int;
	public var ROOM: Int;

	public var id1: Float;
	public var id2: Float;
	public var i1: Int;

    public var battleid: Int;
    public var group: Int;
    public var first: Int;

	public var hint: Int;
    public var name: String;
    public var city: String;
    public var about: String;
    public var clr: Int;
    public var note: String;
    public var chatblock: Int;
    public var list: String;
    public var plist: String;

    public var clon: String;
    public var t1: Int;
    public var inrobot: Int;
    public var acc_flags: Int;

	public var items: Array<Item>;

    public function new() {
        sk = new Array();
        items = new Array();
        ne = new Array();
        ne2 = new Array();
    }
}
