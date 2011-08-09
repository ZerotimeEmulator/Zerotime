package db;

import neko.db.Connection;

interface IDataBaseObject {
	function		checkOut() : Void;
	function		update() : Void;
	function		revert(?param : String) : Void;
	function		commit(?cnx : Connection) : Void;
	function		hasChanges(?param : String) : Bool;
	function		isUpToDate() : Bool;
}
