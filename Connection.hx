import neko.net.Socket;

import SessionManager;

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

	dynamic public function onGetXml(xml: Xml) : Void {
        xml = xml.firstElement();
        var login: String = xml.get("l");
        var pc : CharacterSession;
        
        switch (xml.nodeName) {
            case "LOGIN":
                var sxml : Xml;
                try {
                    pc = SessionManager.instance.getPlayerCharacter(login, xml.get("p"), key);
                } catch (e : AuthError) {
                    sxml = Xml.createElement("ERROR");
                    sxml.set("code", switch (e) {
                                        case BadLogin: "1";
                                        case BadPassword: "2";
                                        case AlreadyIn: "3";
                                        case Blocked(txt): { sxml.set("txt", txt); "4"; }
                                        case OldVersion: "5";
                                        case NoElectronKey: "6";
                                        case BadElectronKey: "7";
                                        case SecondWindow: "8";
                                        case ServerDown: "9";
                                        case ServerBusy: "10"; });
                    send(sxml);
                    return;
                }
                pc.connection = this;
                sxml = Xml.createElement("OK");
                sxml.set("l", login);
                sxml.set("ses", pc.getSesId());
                send(sxml);
            case "CHAT":
            default: close(Xml.createElement("SERROR"));
        } {

        }
    }

    public function close(xml) {
        try {
            send(xml);
        } catch (e : Dynamic) {}
        Main.server.stopClient(sock);
    }
}

