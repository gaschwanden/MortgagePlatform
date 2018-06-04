# PropertyExchange

This project aimes to create a 3rd party verified mortgage system on the blockchain.

# PropertyExchange

Implenting a P2P mortgage platform that is 3rd party verified.
doc:https://docs.google.com/document/d/1-dWKRRIkA_mI7Zhx1zC5iJqj4U61s3nk2uYykAqClnU/edit?usp=sharing

## Todo
1. Timeline
2. SetUp Test Environment
3. Stack Design (Objects / Contracts and their interactions / Dataflow)
4. List of Smart Contracts
5. Implementations

## External Links:
https://github.com/juanfranblanco/vscode-solidity/ (environment for VisualStudio solidity) <br />
https://ethereum.github.io/browser-solidity (Test environment for .sol) <br />
https://github.com/llSourcell/ethereum_demo (DAPP example with homepage / server) <br />
https://davidburela.wordpress.com/ (David Burela blog) <br />





# Usage
1. Download Ganache http://truffleframework.com/ganache/
2. install metamask
3. Open Ganache and set a custom RPC in metamask HTTP://127.0.0.1:7545
4. Import an account from Ganache
5. Open remix http://remix.ethereum.org/ and import all contracts in contracts folder
6. Set Environment to injected web3 in remix
7. Deploy HomeMortgage contract
8. Copy the address of the contract to util/mortgageContract.js and then replace the address
9. cd front-end
10. npm run dev
11. open http://localhost:3000/
12. login first and have to login again after refresh
