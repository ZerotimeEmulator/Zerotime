class AuthManager
{
	private static var singleton : AuthManager = null;

	public static var instance(getInstance, null) : AuthManager;

	private function new() {
	}

	public static function getInstance() : AuthManager {
 		if (singleton == null)
   			singleton = new AuthManager();
  		return singleton;
 	}

	public function generateKey() : String {
		return "sqiqioorurwhoihvufedfkbydkhqcncw";
	}

	public function getPlayerCharacter(login: String, encodePassword: String, key: String) : PlayerCharacter {
		if (login == null)
			return null;
		else
			return (new PlayerCharacter(login));
	}
}

