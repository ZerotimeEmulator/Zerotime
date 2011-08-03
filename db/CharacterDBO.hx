package db;

import neko.db.Connection;

import db.struct.ICharacter;
import db.struct.SCharacter;

class CharacterDBO extends SCharacter, implements IDataBaseObject {	

    private var _old_values : SCharacter;

    public function new(l : String) {
        super();
        login = l;
        _old_values = new SCharacter();
    }

	public function checkOut() : String {
        var cnx = DBConnectionPool.instance.getConnection();
        var rset = cnx.request("SELECT * FROM Characters WHERE login = "+cnx.quote(login));
        if (rset.length != 1)
            throw("OMFG login is not primary key");
        var row;
        var field;
        var i = 0;
        var psw = "";
        for (row in rset) {
            for (field in Reflect.fields(row))
            {
                Reflect.setField(this, field, Reflect.field(row, field));
                Reflect.setField(_old_values, field, Reflect.field(row, field));
            }
            psw = row.psw;
        }
        //TODO: Inventory
        DBConnectionPool.instance.delConnection(cnx);
		return psw;
	}
	public function update() : Bool {
		return checkOut() != null;
    }
	public function revert(?param : String) : Void {
		if (param != null)
            Reflect.setField(this, param, Reflect.field(_old_values, param));
        else {
            var field;
            for (field in Reflect.fields(_old_values))
                Reflect.setField(this, field, Reflect.field(_old_values, field));
        }
	}
	public function commit(?cnx : Connection) : Bool {
        var newConn : Bool = false;

        if (cnx == null) {
            newConn = true;
            cnx = DBConnectionPool.instance.getConnection();
            cnx.startTransaction();
        }
        var field;
        var value;
        var value_str;
        for (field in Reflect.fields(_old_values))
        {
            value = Reflect.field(this, field);
            if (value == null) value_str = "";
            else value_str = "" + value;
            cnx.request("UPDATE Characters SET "+field+" = "+cnx.quote(value_str)+" WHERE login = "+cnx.quote(this.login));
            Reflect.setField(_old_values, field, Reflect.field(this, field));
        }
        if (newConn) {
            cnx.commit();
            DBConnectionPool.instance.delConnection(cnx);
        }
		return true;
	}
	public function hasChanges(?param : String) : Bool {
        if (param != null)
            return Reflect.field(this, param) != Reflect.field(_old_values, param);
        else {
            var field;
            for (field in Reflect.fields(_old_values))
                if (Reflect.field(this, field) != Reflect.field(_old_values, field))
                    return true;
            return false;
        }
	}
	public function isUpToDate() : Bool {
        //TODO or decline
		return true;
	}
    public function toXml() : Xml {
		var result: Xml = Xml.createElement("MYPARAM");

		for (field in Reflect.fields(_old_values)) {
			result.set(field, Reflect.field(_old_values, field) + "");
		}

		return result;
    }
}
