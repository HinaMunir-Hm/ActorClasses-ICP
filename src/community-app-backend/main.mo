import Users "Users";
import Trie "mo:base/Trie";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";

actor Main{
  let n=10;
  // divide initial balance amongst self and canisters
  let cycleShare = Cycles.balance() / (n + 1);

  type User= Users.User;
  stable var userCanisters: Trie.Trie<Principal, User> = Trie.empty();
   // Create a trie key from a superhero identifier.
  private func key(x : Principal) : Trie.Key<Principal> {
    return { hash = Principal.hash x; key = x };
  };

  public shared (msg) func createUser(name: Text, email: Text, dob: Text, profilePic: Blob):async ?User{
      Cycles.add(cycleShare);
    let userCanister:User = await Users.User(name,email,dob,profilePic);
    // userCanisters :=  Trie.replace(userCanisters, key(userId), Principal.equal , ?userCanister);
    // let canisterprincipal = Principal.fromActor(userCanister);
    let (newUsers, _) = Trie.replace(userCanisters, key(msg.caller), Principal.equal, ?userCanister);
    userCanisters := newUsers;
    
    return ?userCanister;
    // return msg.caller;
  };

  public shared (msg) func getUser(): async (Text, Text, Text){
    let maybeUser = Trie.get(userCanisters, key(msg.caller), Principal.equal);
    Debug.print("user checked");
    switch maybeUser {
       case (null) {
          // Handle the case where the user is not found
          Debug.print("User not found.");
          return ("","","");
          // return null;
      };
      case (?userCanisterPrincipal) {
          // Now you can use the `user` safely
        // let userInfo = await Users.User.get(userCanisterPrincipal);
        Debug.print("check canister");
        let user_info = await userCanisterPrincipal.getUserInfo();
        return user_info;
          // Do something with userInfo
      };
     
    }
  }
}