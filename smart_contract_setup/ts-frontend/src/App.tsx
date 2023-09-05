import { abi } from './assets/abi.json'
import { Account, Contract, Provider } from './packages';

const privateKey = "0x300001800000000300000180000000000030000000000003006001800006600";
const accountAddress = "0x3ee9e18edc71a6df30ac3aca2e0b02a198fbce19b7480a63a0d71cbd76652e0";
const contractAddress = "0x01e4c97f8707517cc198ff5e7ccf201086bf6f88f278e3c4bd7bcc13561fc607";



const App = () => {

  const provider = new Provider({ rpc: { nodeUrl: "http://0.0.0.0:5050" }})
  const account = new Account(provider, accountAddress, privateKey)
  const contract = new Contract(abi, contractAddress, account)
  console.log(contract)
  async function callContract() {

    // const res = await contract.get_balance()
    // console.log(res)
    const res = await contract.call('get_balance')
    console.log(res)

  }

  async function writeToContract() {
    contract.connect(account)
    // const res = await contract.increase_balance(4)
    const res = await contract.invoke('increase_balance', [4])
    console.log(res)

  }

  return (
    <div className='d-flex'>
      <button className="btn" onClick={callContract}>Get Balance</button>
      <button className="btn" onClick={writeToContract}>Update Balance</button>
    </div>
  )
}

export default App