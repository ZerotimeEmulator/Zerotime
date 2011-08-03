package db;

import neko.db.Connection;
import neko.db.Sqlite;

class DBConnectionPool
{
	private static var singleton : DBConnectionPool = null;
	public static var instance(getInstance, null) : DBConnectionPool;
	
	private static inline var dbfile : String = "GameDB";
	private var connectionPool : List<Connection>;

	private function new() {
		connectionPool = new List();
		connectionPool.push(Sqlite.open(dbfile));
	}

	public static function getInstance() : DBConnectionPool {
 		if (singleton == null)
   			singleton = new DBConnectionPool();
  		return singleton;
 	}
	
	public function getConnection() : Connection {
		if (!connectionPool.isEmpty())
			return connectionPool.pop();
		else
			return Sqlite.open(dbfile);
	}
	
	public function delConnection(c : Connection) : Void {
		connectionPool.push(c);
	}
}
