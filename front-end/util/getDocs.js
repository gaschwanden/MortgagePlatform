import Web3 from 'web3'
import {address, ABI} from './mortgageContract'

let getDocs = new Promise(function (resolve, reject) {
  let web3 = new Web3(window.web3.currentProvider)
  let casinoContract = new web3.eth.Contract(ABI, address)
  console.log(casinoContract)
  resolve(casinoContract)
})

export default getDocs
