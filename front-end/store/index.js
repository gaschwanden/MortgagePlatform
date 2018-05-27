import Vue from 'vue'
import Vuex from 'vuex'
import getWeb3 from '../util/getWeb3'
import pollWeb3 from '../util/pollWeb3'
import getContract from '../util/getContract'

Vue.use(Vuex)

export class Document {
  constructor(id, name, timestamp, type, sourceUrl, verified) {
    this.id = id;
    this.name = name;
    this.timestamp = timestamp;
    this.type = type;
    this.sourceUrl = sourceUrl;
    this.verified = verified;
  }
}

let state = {
  web3: {
    coinbase: null,
    balance: 0
  },
  web3Instance: null,
  contractInstance: null,
  activeIndex : "1",
  logged : false,
  documents : null
}


const store = () => new Vuex.Store({
  strict: true,
  state,
  mutations: {
    registerWeb3Instance(state, payload) {
      console.log('registerWeb3instance Mutation being executed', payload)
      let result = payload
      state.web3.coinbase = result.coinbase
      state.web3.balance = parseInt(result.balance, 10)
      //state.web3Instance = result.web3
      //pollWeb3()
    },
    pollWeb3Instance(state, payload) {
      console.log('pollWeb3Instance mutation being executed', payload)
      state.web3.coinbase = payload.coinbase
      state.web3.balance = parseInt(payload.balance, 10)
    },
    registerContractInstance(state, payload) {
      console.log('Casino contract instance: ', payload)
      state.contractInstance =  () => payload;
      state.logged = true;
    },
    changeActiveIndex(state,payload) {
      state.activeIndex = payload;
    },
    updateDocs(state, payload) {
      let documents = [];
      for(let i =0; i < payload.length; i++) {
        documents.push(new Document(payload[i].id, payload[i].name, payload[i].timestamp, payload[i].type, payload[i].sourceUrl,
          payload[i].verified));
      }
      console.log(documents);
      state.documents = documents;
    },
  },
  actions: {
    registerWeb3({ commit }) {
      console.log('registerWeb3 Action being executed')
      getWeb3.then(result => {
        console.log('committing result to registerWeb3Instance mutation')
        commit('registerWeb3Instance', result)
      }).catch(e => {
        console.log('error in action registerWeb3', e)
      })
    },
    pollWeb3({ commit }, payload) {
      console.log('pollWeb3 action being executed')
      commit('pollWeb3Instance', payload)
    },
    getContractInstance({ commit }) {
      getContract.then(result => {
        commit('registerContractInstance', result)
      }).catch(e => console.log(e))
    }
  }
})


export default store;