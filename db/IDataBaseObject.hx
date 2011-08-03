package db;

import neko.db.Connection;

interface IDataBaseObject {
	function		checkOut() : String;
	function		update() : Bool;
	function		revert(?param : String) : Void;
	function		commit(?cnx : Connection) : Bool;
	function		hasChanges(?param : String) : Bool;
	function		isUpToDate() : Bool;
}
