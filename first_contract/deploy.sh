#!/bin/bash
starkli deploy 0x00e285e83ff7ce5bc7c70db3c7cfad8ddcd78acb75ae85aac2927d928fd68e8d 0x03ee9e18edc71a6df30ac3aca2e0b02a198fbce19b7480a63a0d71cbd76652e0 0x033c627a3e5213790e246a917770ce23d7e562baa5b4d2917c23b1be6d91961c 0x01d98d835e43b032254ffbef0f150c5606fa9c5c9310b1fae370ab956a7919f5 --rpc http://0.0.0.0:5050 --account ~/.starkli-wallets/deployer/account0_account.json --keystore ~/.starkli-wallets/deployer/account0_keystore.json

starkli call 0x03e60f0249582eaa6dfb05eea35fa14c0c8b27cf78d3f180d2da4952032aae9d voter_can_vote 0x03ee9e18edc71a6df30ac3aca2e0b02a198fbce19b7480a63a0d71cbd76652e0 --rpc http://0.0.0.0:5050

starkli invoke 0x03e60f0249582eaa6dfb05eea35fa14c0c8b27cf78d3f180d2da4952032aae9d vote 1 --rpc http://0.0.0.0:5050 --account ~/.starkli-wallets/deployer/account0_account.json --keystore ~/.starkli-wallets/deployer/account0_keystore.json

starkli transaction 0x01eee3ae3d05f742522a84b79b1736fe0354438fa58f7282b737e927352f60a8 --rpc http://0.0.0.0:5050

starkli call 0x03e60f0249582eaa6dfb05eea35fa14c0c8b27cf78d3f180d2da4952032aae9d get_vote_status --rpc http://0.0.0.0:5050