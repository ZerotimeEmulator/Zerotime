import neko.net.Socket;

private enum State {
	Unauthorazied (key: String);
	World;
}

class Connection
{
	private var state: State;
	private var pc: PlayerCharacter;
	private var sock: Socket;
	
	public function new(sck: Socket) {
		var key: String = AuthManager.instance.generateKey();
		var xml: Xml;

		pc = null;
		sock = sck;
		state = Unauthorazied(key);
		xml = Xml.createElement("KEY");
		xml.set("s", key);

		send(xml);
	}

	private function send(xml: Xml) {
		sock.write(xml.toString() + String.fromCharCode(0));
	}

	public function onGetXml(xml: Xml) {
		switch (state) {
			case Unauthorazied(key):
				var xml: Xml = xml.firstElement();
				var login: String = xml.get("l");
				
				if (xml.nodeName != "LOGIN") {
					send(Xml.createElement("SERROR"));
					throw "Unexpected xml";
				} else if ((pc = AuthManager.instance.getPlayerCharacter(login, xml.get("p"), key)) == null) {
					var xml: Xml;

					xml = Xml.createElement("ERROR");
					xml.set("txt", "Ќесуществующее им€ персонажа или неверный пароль.");

					send(xml);
					throw "Authentication error";
				} else {
					var xml: Xml;

					xml = Xml.createElement("OK");
					xml.set("l", login);
					xml.set("ses", "10319674111165471995");

					send(xml);

					state = World;
				}
			case World:
				switch(xml.firstElement().nodeName) {
					case "GETME":
						send(pc.toXml());
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

								send(xml);
							}
						}
					default:
						neko.Lib.println(xml.toString());
				}
		}
	}
}

