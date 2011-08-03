class SessionManager
{
	private static var singleton : SessionManager = null;

	public static var instance(getInstance, null) : SessionManager;

    private var characters : Hash<CharacterSession>;

	private function new() {
        characters = new Hash();
	}

	public static function getInstance() : SessionManager {
 		if (singleton == null)
   			singleton = new SessionManager();
  		return singleton;
 	}

	public function generateKey() : String {
		return "sqiqioorurwhoihvufedfkbydkhqcncw";
	}

	public function getPlayerCharacter(login: String, encodePassword: String, key: String) : CharacterSession {
		if (login == null)
			return null;
		if (characters.exists(login))
            return characters.get(login);
        var char = new CharacterSession(login);
        //if (encrypt(char.psw, key) == encodePassword)
        {
            characters.set(login, char);
            return char;
        }
	}
}

