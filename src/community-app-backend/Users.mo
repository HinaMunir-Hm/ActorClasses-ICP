import Array "mo:base/Array";
import Principal "mo:base/Principal";
actor class User(name: Text, email: Text, dob: Text, profilePic: Blob){
    stable var userName: Text = name;
    stable var userEmail: Text = email;
    stable var userDob: Text = dob;
    stable var userProfilePic: Blob = profilePic;
    stable var communities: [Principal] = [];

    public func getUserInfo(): async (Text, Text, Text) {
        return (userName, userEmail, userDob);//, userProfilePic);
    };

    public func joinCommunity(communityId: Principal): async () {
        communities := Array.append(communities, [communityId]);
    };

    public func getCommunities(): async [Principal] {
        communities;
    };
}