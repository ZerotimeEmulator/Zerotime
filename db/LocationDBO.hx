package db;

import neko.db.Connection;

import db.struct.Location;

class LocationDBO extends Location, implements IDataBaseObject {	

    private var _old_values : Location;

    public function new(x : Int, y : Int) {
        super();
        X = x; Y = y;
        _old_values = new Location();
    }

	public function checkOut() : Void {
        var cnx = DBConnectionPool.instance.getConnection();
        var rset = cnx.request("SELECT * FROM Locations WHERE X = "+X+"AND Y = "+Y);
        if (rset.length != 1)
            throw("OMFG (X, Y) is not a primary key");
        var row;
        var field;
        for (row in rset) {
            for (field in Reflect.fields(row))
            {
                Reflect.setField(this, field, Reflect.field(row, field));
                Reflect.setField(_old_values, field, Reflect.field(row, field));
            }
        }
        //TODO: bigland, houses.
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
            cnx.request("UPDATE Locations SET "+field+" = "+cnx.quote(value_str)+" WHERE X = "+X+"AND Y = "+Y);
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
		var result: Xml = Xml.createElement("L");

		for (field in Reflect.fields(_old_values)) {
			result.set(field, Reflect.field(_old_values, field) + "");
		}

		return result;
    }
}
