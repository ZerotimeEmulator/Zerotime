import neko.Lib;
import neko.net.Socket;
import neko.net.ThreadServer;
import haxe.io.Bytes;

class Main extends ThreadServer<Connection, Xml>
{
	override function clientConnected(sock: Socket) : Connection {
		var conn: Connection = new Connection(sock);

		return conn;
	}

	override function readClientMessage(conn: Connection, buf: Bytes, pos: Int, len: Int)
	{
		var xml: Xml;
		var complete = false;
		var cpos = pos;

		while (cpos < (pos+len) && !complete)
		{
			complete = (buf.get(cpos) == 0);
			cpos++;
		}

		if (!complete)
			return null;

		neko.Lib.println(buf.readString(pos, cpos-pos));
		xml = Xml.parse(buf.readString(pos, cpos - pos));

		return { msg: xml, bytes: cpos - pos };
	}

	override function clientMessage(conn: Connection, xml: Xml)
	{
   		conn.onGetXml(xml);
	}

	public static function main()
	{
		var server:Main = new Main();

		server.run("127.0.0.1", 5190);

	}
}

