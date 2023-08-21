# Learn to build & deploy Starknet contract in one go!

Guide to developing Contracts on chain with Cairo.

![Katana](https://media.livesoftwaredeveloper.com/photologue/photos/Screenshot_from_2023-08-14_00-28-23.png)   

## Prerequisites

1. Linux like environment - Debian system or [WSL](https://www.omgubuntu.co.uk/how-to-install-wsl2-on-windows-10) on windows
2. Rust - [Setup](https://doc.rust-lang.org/book/ch01-01-installation.html) - Might or not be required (Better to have it)
3. Cairo - [Setup](https://book.cairo-lang.org/ch01-01-installation.html) - Language to be used in writing the smart contract(s)
4. Scarb - [Setup](https://docs.swmansion.com/scarb/download) - Cairo package manager like [Cargo](https://doc.rust-lang.org/cargo/) for Rust
5. Katana - [Setup](https://book.starknet.io/chapter_3/katana.html) - Local Development Node
6. Starkli - [Setup](https://book.starknet.io/chapter_1/environment_setup.html) - CLI tool to help in deploying the contract and to interact with it.
7. Starknet Foundry - [setup](https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html) - For easy smart contract development

## Resources

1. Cairo book - [Read](https://book.cairo-lang.org/title-page.html)
2. Starknet book - [Read](https://book.starknet.io/index.html)
3. Starknet Foundry - [Read](https://foundry-rs.github.io/starknet-foundry/getting-started/first-steps.html)

> This  will guide you throught the local development and deployment of Starknet contracts.

If you are on windows you need to set up [wsl](https://www.omgubuntu.co.uk/how-to-install-wsl2-on-windows-10).

> To view wsl files on windows, type `\\wsl$` on `Windows File Explorer bar`

## How to create accounts (katana)

Once Katana is installed start the local starknet node;

```sh
katana --accounts 3 --seed 0 --gas-price 250
```

It will start a local starknet node with 3 deployed accounts;

```sh
$ katana --accounts 3 --seed 0 --gas-price 250



██╗  ██╗ █████╗ ████████╗ █████╗ ███╗   ██╗ █████╗ 
██║ ██╔╝██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║██╔══██╗
█████╔╝ ███████║   ██║   ███████║██╔██╗ ██║███████║
██╔═██╗ ██╔══██║   ██║   ██╔══██║██║╚██╗██║██╔══██║
██║  ██╗██║  ██║   ██║   ██║  ██║██║ ╚████║██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝
                                                      

        
PREFUNDED ACCOUNTS
==================

| Account address |  0x3ee9e18edc71a6df30ac3aca2e0b02a198fbce19b7480a63a0d71cbd76652e0 
| Private key     |  0x300001800000000300000180000000000030000000000003006001800006600
| Public key      |  0x1b7b37a580d91bc3ad4f9933ed61f3a395e0e51c9dd5553323b8ca3942bb44e

| Account address |  0x33c627a3e5213790e246a917770ce23d7e562baa5b4d2917c23b1be6d91961c 
| Private key     |  0x333803103001800039980190300d206608b0070db0012135bd1fb5f6282170b
| Public key      |  0x4486e2308ef3513531042acb8ead377b887af16bd4cdd8149812dfef1ba924d

| Account address |  0x1d98d835e43b032254ffbef0f150c5606fa9c5c9310b1fae370ab956a7919f5 
| Private key     |  0x7ca856005bee0329def368d34a6711b2d95b09ef9740ebf2c7c7e3b16c1ca9c
| Public key      |  0x7006c42b1cfc8bd45710646a0bb3534b182e83c313c7bc88ecf33b53ba4bcbc
    

ACCOUNTS SEED
=============
0

```

We will use these 3 accounts to deploy and interact with the smart contract.

This will also provide the `JSON-RPC` server to use for local dev as:

```curl
http://0.0.0.0:5050
```

>>Important! Don't stop the created server by Katana. Everything relies on it.
>>
>>Start a new terminal shell to continue with the other commands.

## Preparing Accounts for Smart Contract Deployment

We will create a signer and an account desciptor for one of the 3 wallets.

### Creating a Keystore from account 1's private key
Use the command below:

```sh
starkli signer keystore from-key ~/.starkli-wallets/deployer/account1_keystore.json
```

Result
```sh
Created new encrypted keystore file: /home/dalmas/.starkli-wallets/deployer/account1_keystore.json
Public key: 0x04486e2308ef3513531042acb8ead377b887af16bd4cdd8149812dfef1ba924d
```

To Preview
```sh
cat ~/.starkli-wallets/deployer/account1_keystore.json
```

Result: 
```json
{"crypto":{"cipher":"aes-128-ctr","cipherparams":{"iv":"1e4c13c7e7a5ad5f24d49ab08a0dde59"},"ciphertext":"0b09cca82505487f6a992a76b13fcdced3b982315a832306579ce4a79a4cc70e","kdf":"scrypt","kdfparams":{"dklen":32,"n":8192,"p":1,"r":8,"salt":"65eef381e21f488e8889b3000cf659e0a2ea5e9fa79ef3ec93909d5b0d48b7c7"},"mac":"5aa2a6ae31ae46f73d142617826172564d280914b466769343e901b3fe98ae58"},"id":"e5159eee-4346-4b31-93ae-acdd018cd5ce","version":3}
```

The Private Key we added can be found in the Katana JSON-RPC server started at stage one; You can pick any wallet (we've used the first one)

### Creating an Account Descriptor;

The account descriptor is a json file, and you can get the public key and wallet address above;

1. Create a file that will hold the signer
```sh
touch ~/.starkli-wallets/deployer/account1_account.json
```

2. Edit the file and paste in the json object into it.
```sh
nano ~/.starkli-wallets/deployer/account1_account.json
```

Paste this into the file.
```sh
{
  "version": 1,
  "variant": {
        "type": "open_zeppelin",
        "version": 1,
        "public_key": "<ACCOUNT_PUBLIC_KEY>"
  },
    "deployment": {
        "status": "deployed",
        "class_hash": "<SMART_WALLET_CLASS_HASH>",
        "address": "<ACCOUNT_ADDRESS>"
  }
}
```

> Update the `<ACCOUNT_PUBLIC_KEY>` with the public key of the account you chose from `Katana`
> 
> Update the `<ACCOUNT_ADDRESS>` with the address of the account you chose from `Katana`
> 
> Update the `<SMART_WALLET_CLASS_HASH>` with the `hash` generated by running the command below

```sh
starkli class-hash-at <ACCOUNT_ADDRESS> --rpc http://0.0.0.0:5050
```

Result
```sh
0x04d07e40e93398ed3c76981e72dd1fd22557a78ce36c0515f679e27f0bb5bc5f
```

Notice how we've used Katana's RPC End Point `http://0.0.0.0:5050`.

We've generated the class hash, so now we will replace `<SMART_WALLET_CLASS_HASH>` with it.

Finally, to view the contents of the file use

```sh
cat ~/.starkli-wallets/deployer/account1_account.json
```
Result:
```js
{
  "version": 1,
  "variant": {
        "type": "open_zeppelin",
        "version": 1,
        "public_key": "0x4486e2308ef3513531042acb8ead377b887af16bd4cdd8149812dfef1ba924d"
  },
    "deployment": {
        "status": "deployed",
        "class_hash": "0x04d07e40e93398ed3c76981e72dd1fd22557a78ce36c0515f679e27f0bb5bc5f",
        "address": "0x33c627a3e5213790e246a917770ce23d7e562baa5b4d2917c23b1be6d91961c"
  }
}
```

To inspect the public key;

```sh
starkli signer keystore inspect ~/.starkli-wallets/deployer/account1_keystore.json
```

You will be asked to enter password then the result will be as below.

Result:
```sh
Public key: 0x04486e2308ef3513531042acb8ead377b887af16bd4cdd8149812dfef1ba924d
```

### Navigate to **ubuntu/root/.starkli-wallets/deployer** to see your accounts.

```sh
ls ~/.starkli-wallets/deployer
```

Result:
```sh
account0_account.json   account1_keystore.json  account.json
account0_keystore.json  account3_account.json   keystore.json
account1_account.json   account3_keystore.json
```

>> You might notice more than one account, stick to `account1_account.json & account1_keystore.json`

### Export(Add as Environment variables) account location and keystore location

After doing the above, you need to export your account and keystore to set them as environment variables to avoid writing loong paths to your smart wallet account and keystore

```sh
export STARKNET_ACCOUNT=~/.starkli-wallets/deployer/account1_account.json
export STARKNET_KEYSTORE=~/.starkli-wallets/deployer/account1_keystore.json
```

# Deploying to local development Node [Katana]

This section will show you on how to deploy your first smart contract to the `local dev node[Katana]`

We will be using an example from [Foundry](https://foundry-rs.github.io/starknet-foundry/index.html) that gives us the **`HelloStarknet Contract`**

Clone the online repo for a smart contract by following the docs [here](https://foundry-rs.github.io/starknet-foundry/getting-started/first-steps.html) or use the git command below.

```sh
git clone https://github.com/foundry-rs/starknet_forge_template.git
```

After cloning the example contract, navigate to ` starknet_forge_template`

```sh
cd starknet_forge_template/
```

Then, Build the project by running 

```sh
scarb build
```
Once you have ran the above command, you will notice you have your **target** folder

### Start starkli [If it is not auto started]

To confirm whether its up run:
```sh
starkli --version
```

If `starkli command not found`, try the command below:
```sh
. /home/dalmas/.starkli/env
```

### Declare your contract

With declaring the smark contract, we are preparing it for deployment. Use the command below:

```sh
starkli declare target/dev/starknet_forge_template_HelloStarknet.sierra.json --compiler-version=2.0.1 --account $STARKNET_ACCOUNT --keystore $STARKNET_KEYSTORE --rpc http://0.0.0.0:5050
```

After declaring, you will get the following output

```sh
Enter keystore password: 

Declaring Cairo 1 class: 0x04970172fe2dfe1208dd07a52d0cea1663b481211c0963052c43e185c35ec4ee

Compiling Sierra class to CASM with compiler version 2.0.1...

CASM class hash: 0x03eb55a3f9f7485408838b08067c3b0f5d72523c525f568b04627464f5464749

Contract declaration transaction: 0x03b747b5448c7259764491a5242a92e1926b6865fe6bad4b6a357583d7a27c0d

Class hash declared:
0x04970172fe2dfe1208dd07a52d0cea1663b481211c0963052c43e185c35ec4ee
```

>> Take Note of the `Class hash declared`

### Deploy the contract

Deploy the declared contract to the local node.

```sh
starkli deploy <DECLARE_CLASS_HASH> --account $STARKNET_ACCOUNT --keystore $STARKNET_KEYSTORE --rpc http://0.0.0.0:5050
```

You might notice the above command does not have `--compiler-version=2.0.1` because we are deploying to the local node(Katana) and not an online node like **goerli**

#### Example

```sh
starkli deploy 0x04970172fe2dfe1208dd07a52d0cea1663b481211c0963052c43e185c35ec4ee --account $STARKNET_ACCOUNT --keystore $STARKNET_KEYSTORE --rpc http://0.0.0.0:5050
```

Successful Result

```bash
Enter keystore password: 

Deploying class 0x04970172fe2dfe1208dd07a52d0cea1663b481211c0963052c43e185c35ec4ee with salt 0x02006f8d9865b5b4e83c579023c7366658918f354ffcc11bd0e81cb9ec1991b9...

The contract will be deployed at address 0x01b364a76a9656ec1c06cd4dc3a915cc086577e8e2e56d886569eab5f381873d

Contract deployment transaction: 0x043f366e5bdf04e50546382f2184b9e90d79ccb98cbe998d54e33048c9df9288

Contract deployed:
0x01b364a76a9656ec1c06cd4dc3a915cc086577e8e2e56d886569eab5f381873d
```

>> N/B: The success result might be different from what you get. Don't clear the output from terminal or save the output before clearing your terminal.

The deployed contract, has two methods:

```js
increase_balance // Writing/Setting method
get_balance // Reading/Getting method
```

#### How to make contract view call
```sh
starkli call <CONTRACT_ADDRESS> <METHOD> --rpc http://0.0.0.0:5050
```

>> *`<CONTRACT_ADDRESS>`* is the address that is in the deployment result under **`The contract will be deployed at address`**
>>
>> *`<METHOD>`* is one of the methods in the written contract that is `HelloStarknet` Contract.

##### Example

```sh
starkli call 0x01b364a76a9656ec1c06cd4dc3a915cc086577e8e2e56d886569eab5f381873d get_balance --rpc http://0.0.0.0:5050
```

Result:
```js
[
    "0x0000000000000000000000000000000000000000000000000000000000000000"
]
```

### Writing to the contract

To edit the contract state, you use the command below:
```sh
starkli invoke <CONTRACT_ADDRESS> <METHOD> [ARGS] --rpc http://0.0.0.0:5050 --account <PATH_TO_SMART_WALLET_ACCOUNT_JSON> --keystore <PATH_TO_SMART_WALLET_KEYSTORE_FOR_A_GIVEN_ACCOUNT>
```

##### Example

```sh
starkli invoke 0x01b364a76a9656ec1c06cd4dc3a915cc086577e8e2e56d886569eab5f381873d increase_balance --rpc http://0.0.0.0:5050 --account $STARKNET_ACCOUNT --keystore $STARKNET_KEYSTORE
```

Result:
```txt
Invoke transaction: 0x030c3aab451718e29ddcd61119e1cb11d9241360bb4c23c104a209c226755ee9
```

## Get Transaction Status/Information

Call the command below to get transaction information:'
```sh
starkli transaction-receipt <TRANSACTION_ID> --rpc http://0.0.0.0:5050
```

##### Example 

```sh
starkli transaction-receipt 0x030c3aab451718e29ddcd61119e1cb11d9241360bb4c23c104a209c226755ee9 --rpc http://0.0.0.0:5050
```

Result 
```js
{
  "type": "INVOKE",
  "transaction_hash": "0x30c3aab451718e29ddcd61119e1cb11d9241360bb4c23c104a209c226755ee9",
  "actual_fee": "0x24a4dc",
  "status": "ACCEPTED_ON_L2",
  "block_hash": "0x2c728cc838be1894f3e3cab93aa3a0401ea9a50f022eb0a2f07bf9bdf732b5a",
  "block_number": 3,
  "messages_sent": [],
  "events": [
    {
      "from_address": "0x49d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7",
      "keys": [
        "0x99cd8bde557814842a3121e8ddfd433a539b8c9f14bf31ebf108d12e6196e9"
      ],
      "data": [
        "0x1d98d835e43b032254ffbef0f150c5606fa9c5c9310b1fae370ab956a7919f5",
        "0x69420",
        "0x24a4dc",
        "0x0"
      ]
    }
  ]
}
```

# Katana keeps the JSON-RPC Node

Listening to all the incoming calls and recording/showing the transactions
![Katana](https://media.livesoftwaredeveloper.com/photologue/photos/Screenshot_from_2023-08-14_00-28-39.png) 

## Tips & Hints
### 1. Creating Write methods

When creating write methods, you might be forced to only take in `integers` or `custom structs` but no all data types ie
`felt252's` or `strings` are not so nice to use in the method args, they may result to errors like below:

```ts
fn write_method(self: ContractState, user_id: felt252, name: felt252){
    self.users.write(user_id, name);
}
```

Such function with `felts` as data types might result into error when calling it.

# Made with ❤️

🚀 Dalmas Ogembo - CEO Live Software Developer Ltd, Fullstack Software Developer >> [Portifolio](https://livesoftwaredeveloper.com/authors/1/lsd) | [Github](https://github.com/dalmasonto) | [Twitter](https://twitter.com/dalmasonto) | [LinkedIn](https://linkedin.com/in/dalmas-ogembo) | [Telegram](https://t.me/dalmasonto)

🚀 Cynthia Kamau >> [Github](https://github.com/CyndieKamau) | [Twitter](https://twitter.com/CyndieKamau) | [LinkedIn](https://www.linkedin.com/in/cynthiakamau/) | [Telegram](Cyndie_Kamau)


Title: Smart Contract Development With Starknet & Cairo Language

Description: Starknet is a layer 2 chain to Ethereum which provides the power of zk-STARKs technology for scalability, privacy, and security. This article is going to articulate the steps to creating your own smart contract that leverages the power of Cairo language with Starknet to make a wonderful product.

image url: https://media.livesoftwaredeveloper.com/photologue/photos/Screenshot_from_2023-08-14_00-28-39.png
image alt: Katana Local Development Node Running

keywords: blockchain, starknet chain, starknet blockchain, cairo starknet, cairo language, json-rpc, katana, smart contracts, blockchain contracts, tokens, assets, blockchain tokens, blockchain assets, developing a smart contract