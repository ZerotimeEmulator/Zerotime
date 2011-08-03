import neko.net.Socket;

class Connection
{
	private var key: String;
	private var sock: Socket;
	
	public function new(sck: Socket) {
		var xml: Xml;
		key = SessionManager.instance.generateKey();

		sock = sck;
		xml = Xml.createElement("KEY");
		xml.set("s", key);

		send(xml);
	}

	public function send(xml: Xml) {
		sock.write(xml.toString() + String.fromCharCode(0));
	}

	dynamic public function onGetXml(xml: Xml) {
        xml = xml.firstElement();
        var login: String = xml.get("l");
        var pc : CharacterSession;
        
        if (xml.nodeName != "LOGIN") {
            send(Xml.createElement("SERROR"));
            throw "Unexpected xml";
        } else if ((pc = SessionManager.instance.getPlayerCharacter(login, xml.get("p"), key)) == null) {
            var xml: Xml;

            xml = Xml.createElement("ERROR");
            xml.set("txt", "Ќесуществующее им€ персонажа или неверный пароль.");

            send(xml);
            throw "Authentication error";
        } else {
            var xml: Xml;

            pc.connection = this;

            xml = Xml.createElement("OK");
            xml.set("l", login);
            xml.set("ses", "10319674111165471995");

            send(xml);
        }
    }

    public function close() {
        Main.server.stopClient(sock);
    }
}

