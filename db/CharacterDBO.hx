package db;

import neko.db.Connection;

import db.struct.Character;

class CharacterDBO extends Character {	

    private var _old_values : Character;
    public var psw(default,null) : String;

    public function new(l : String) {
        super();
        login = l;
        _old_values = new Character();
    }

	public function checkOut() : Void {
        var cnx = DBConnectionPool.instance.getConnection();
        var rset = cnx.request("SELECT * FROM Characters WHERE login = "+cnx.quote(login));
        if (rset.length != 1)
            throw("OMFG login is not primary key");
        var row;
        var field;
        var i = 0;
        psw = "";
        for (row in rset) {
            for (field in Reflect.fields(row))
            {
                if (field.substr(0, 2) == "sk")
                {
                    var i = Std.parseInt(field.substr(2));
                    sk[i] = _old_values.sk[i] = Std.parseInt(Reflect.field(row, field));
                } else if (field == "ne" || field == "ne2") {
                    var s : String = Reflect.field(row, field);
                    if (s == null)
                        trace("WTF??");
                    trace(s);
                    var a : Array<String> = s.split(",");
                    var i;
                    for (i in 0...a.length)
                        if (field == "ne")
                            ne[i] = _old_values.ne[i] = Std.parseInt(a[i]);
                        else if (field == "ne2")
                            ne2[i] = _old_values.ne2[i] = Std.parseFloat(a[i]);
                } else {
                    Reflect.setField(this, field, Reflect.field(row, field));
                    Reflect.setField(_old_values, field, Reflect.field(row, field));
                }
            }
            psw = row.psw;
        }
        //TODO: Inventory
        DBConnectionPool.instance.delConnection(cnx);
		return;
	}
	public function update() : Void {
		return checkOut();
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
	public function commit(?cnx : Connection) : Void {
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
		return;
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
            if (field == "sk") {
                var i;
                for (i in 0...sk.length)
                    result.set("sk"+i, ""+sk[i]);
            }
            else if (field == "ne")
                result.set("ne", ne.join(","));
            else if (field == "ne2")
                result.set("ne2", ne2.join(","));
            else
			    result.set(field, Reflect.field(_old_values, field) + "");
		}

		return result;
    }
}
