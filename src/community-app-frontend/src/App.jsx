import { useState } from 'react';
import { community_app_backend } from 'declarations/community-app-backend';
import { AuthClient } from "@dfinity/auth-client";
import { HttpAgent, Actor } from "@dfinity/agent";
const actor=community_app_backend;
function App() {
  const [greeting, setGreeting] = useState('');
  const [principal, setPrincipal]=useState(null);
  async function handleSubmit(event) {
    try{
    event.preventDefault();
    const name = event.target.elements.name.value;
    // Create a dummy Uint8Array with some sample data
    const dummyUint8Array = new Uint8Array([72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100]);

    console.log(dummyUint8Array);
    let principal_ = (await Actor.agentOf(actor).getPrincipal()).toString();
    console.log(principal_)
    setPrincipal(principal_)
    actor.createUser(name, "hina1munir@gmail.com","20-10-1989",dummyUint8Array).then((greeting) => {
      console.log(greeting)
      setGreeting(greeting);
    });
    return false;}catch(ex){
      console.log("in submit", ex)
    }
  }

  const getCanister=async()=>{
    try{
    actor.getUser().then((canister)=>{
      console.log(canister)
    })}catch(ex){
      console.log("in get", ex)
    }
  }

  return (
    <main>
      <img src="/logo2.svg" alt="DFINITY logo" />
      <br />
      <br />
      <form action="#" onSubmit={handleSubmit}>
        <label htmlFor="name">Enter your name: &nbsp;</label>
        <input id="name" alt="Name" type="text" />
        <button type="submit">Click Me!</button>
      </form>
      {/* <section id="greeting">{greeting}</section> */}
      <button type="getInfo" onClick={getCanister}>Get Info</button>
    </main>
  );
}

export default App;
