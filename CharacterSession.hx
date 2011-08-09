
import db.struct.Character;
import db.CharacterDBO;
import db.struct.Item;
import SessionManager;

class CharacterSession {
    public var character(default,null) : Character;
    public var psw(getPsw,null) : String;
    public var connection(null,setConnection) : Connection;

    private var dbo : CharacterDBO;
    private var ses2 : String;

    public function getPsw() : String {
        return dbo.psw;
    }

    public function getSesId() : String {
        return "2346342312334564";
    }

    public function setConnection(conn : Connection) {
        if (connection != null)
            connection.close({var xml = Xml.createElement("ERROR");
                              xml.set("code", "3"); xml;});
        connection = conn;
        connection.onGetXml = onGetXml;
        ses2 = getSesId();
        return connection;
    }

	public function new(username: String) {
        dbo = new CharacterDBO(username);
        try {
            dbo.checkOut();
        } catch (e : Dynamic) {
            trace(e);
            throw(BadLogin);
        }
        character = dbo;
	}

    public function onGetXml(xml : Xml) {
        switch(xml.firstElement().nodeName) {
            case "GETME":
                connection.send(this.toXml());
            case "GOLOC":
                for (i in -1...2) {
                    for (j in -1...2) {
                        var xml: Xml;

                        xml = Xml.createElement("L");
                        xml.set("X", i + "");
                        xml.set("Y", j + "");
                        xml.set("name", "Fucking Locatioin");
                        xml.set("time", "0");
                        xml.set("t", "A");
                        xml.set("n", "1");
                        xml.set("m", "l1:5:5");

                        //neko.Lib.println(xml.toString());

                        connection.send(xml);
                    }
                }
            default:
                //neko.Lib.println(xml.toString());
        }
    }

	public function toXml() : Xml {
		var result = dbo.toXml();
        result.set("time", ""+(Date.now().getTime()/1000));
        //trace(result.toString());
        return result;
	}

}
