package db.struct;

interface ICharacter {
	var login: String;
	var ses2: String;
	var dl: Int;
	var loc_time: Int;
	var nextlevel: Int;
	var predlevel: Int;
	var exp: Int;
	var level: Int;
	var cup_0: Int;
	var cup_1: Int;
	var cup_2: Int;
	var str: Int;
	var dex: Int;
	var int: Int;
	var pow: Int;
	var acc: Int;
	var intel: Int;
	var maxHP: Int;
	var HP: Int;
	var psy: Int;
	var maxPsy: Int;
	var X: Int;
    var ODratio: Int;
	var dp_eff: Int;
	var Y: Int;
	var Z: Int;
	var ROOM: Int;
	var id1: Float;
	var id2: Float;
	var i1: Int;
	var man: Int;
	var hint: Int;
	var tdt: Int;
	var items: Array<SItem>;
}
