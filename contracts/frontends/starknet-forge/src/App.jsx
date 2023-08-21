import { useState, useEffect } from "react";
import { connect, disconnect } from "get-starknet";
import { Provider, Account, Contract, json } from "starknet";
import { abi } from "./abi/abi.json";
import "./App.css";

const provider = new Provider({ rpc: { nodeUrl: "http://127.0.0.1:5050" } });

const privateKey =
  "0x300001800000000300000180000000000030000000000003006001800006600";
const accountAddress =
  "0x3ee9e18edc71a6df30ac3aca2e0b02a198fbce19b7480a63a0d71cbd76652e0";
const contractAddress =
  "0x013750dda19f432c5e7403e5628a9b6975a27140f712185fbbd2766c1852fe9d";

const account = new Account(provider, accountAddress, privateKey);

const { abi_ } = await provider.getClassAt(contractAddress);



function App() {
  const [count, setCount] = useState(0);

  const myContract = new Contract(abi, contractAddress, provider);

  const get = async () => {
    // let val = await myContract.call('get_balance', []).then(res => res)
   let val  = await myContract.
    console.log(val.toString());
  };

  const write = async (number) => {
    await myContract.set;
  };

  useEffect(() => {
    get();
  }, []);

  return (
    <>
      <button
        onClick={() => {
          connect();
        }}
      >
        Connect
      </button>
    </>
  );
}

export default App;