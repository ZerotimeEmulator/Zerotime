
import db.struct.ICharacter;
import db.CharacterDBO;
import db.struct.SItem;

class CharacterSession implements ICharacter {
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
	public var tdt: Int; //TODO: getters and setters
    public var items : Array<SItem>;

    public var psw : String;

    public var dbo : CharacterDBO;
    public var connection(null,setConnection) : Connection;

    public function setConnection(conn : Connection) {
        if (connection != null)
            connection.close();
        connection = conn;
        connection.onGetXml = onGetXml;
        return connection;
    }

	public function new(username: String) {
        dbo = new CharacterDBO(username);
        psw = dbo.checkOut();
	}

    public function onGetXml(xml : Xml) {
        switch(xml.firstElement().nodeName) {
            case "GETME":
                connection.send(this.toXml());
            case "GOLOC":
                for (i in -1 ... 2) {
                    for (j in -1 ...2) {
                        var xml: Xml;

                        xml = Xml.createElement("L");
                        xml.set("X", i + "");
                        xml.set("Y", j + "");
                        xml.set("name", "Fucking Locatioin");
                        xml.set("time", "0");
                        xml.set("t", "A");
                        xml.set("n", "1");
                        xml.set("m", "l1:5:5");

                        neko.Lib.println(xml.toString());

                        connection.send(xml);
                    }
                }
            default:
                neko.Lib.println(xml.toString());
        }
    }

	public function toXml() : Xml {
		var result = dbo.toXml();
        result.set("time", ""+(Date.now().getTime()/1000));
        trace(result.toString());
        return result;
	}

}
