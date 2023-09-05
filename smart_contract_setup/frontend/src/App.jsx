import React from 'react'

import { Provider, Account, Contract, CallData } from "starknet"
import { abi } from './assets/abi.json'
import axios from 'axios';

const privateKey = "0x68bc4597a9b2bc3c4fe5b6f2c923a987";
const accountAddress = "0x48b9a863fa24f16661af3af10f15f69ee7b9ff84ea52ac37a20a76d75e4d056";
const contractAddress = "0x893076b54ab271693e49654eae790e4dd5a851568b89a66cf14136254b2f86";



const App = () => {

  const provider = new Provider({ rpc: { nodeUrl: "http://0.0.0.0:5050/rpc" } })
  const account = new Account(provider, accountAddress, privateKey)
  const contract = new Contract(abi, contractAddress, provider)

  async function callContract() {
    // const new_contract = new Contract(abi, contractAddress, provider)
    const res = await contract.get_balance()
    console.log(res.toString())

  }

  async function writeToContract() {
    contract.connect(account)
    const myCall = contract.populate("increase_balance", [20]);
    const res = await contract.increase_balance(myCall.calldata);
    console.log("Invoke result: ", res)
    const txh = await provider.waitForTransaction(res.transaction_hash);
    console.log("TX Hash: ", txh)
    callContract()
  }

  return (
    <div className='d-flex'>
      <button className="btn" onClick={callContract}>Get Balance</button>
      <button className="btn" onClick={writeToContract}>Update Balance</button>
    </div>
  )
}

export default App

