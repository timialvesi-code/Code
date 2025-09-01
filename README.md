# Code
This repository contains a **Clarity smart contract** that implements a simple,
transparent, and fair **auction system** designed for awarding a contract in a
Web3 setting. It is written to be **Clarinet-ready**, so you can clone, check,
and test it locally without modification.

🎯 Purpose

The contract ensures that:
- Only **valid bids** within a defined block-height window are accepted.  
- The **highest bidder** at the end of the auction wins.  
- The auction process is **trustless**, fully transparent, and verifiable on-chain.  

This template can be extended to real-world use cases such as:
- Contract awards  
- NFT or tokenized asset bidding  
- DAO governance for resource allocation  

 🛠 Features

- **Initialization:** Owner sets title, minimum bid, start block, and end block.  
- **Bidding:** Anyone can place a bid higher than the current leader.  
- **Leaderboard:** At any time, you can query the current highest bid and bidder.  
- **Finalization:** After the auction ends, the contract returns the winner and their amount.  

