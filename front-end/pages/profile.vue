<template>
  <div class='metamask-info'>
    <Myheader></Myheader>
   <p>Account: {{ web3.coinbase }}</p>
   <p>Balance: {{ web3.balance }}</p>
 </div>
</template> 

<script>
import Myheader from "./myheader.vue";

export default {
  beforeCreate() {},
  data() {
    return {};
  },
  methods: {},
  computed: {
    web3() {
      console.log(this.$store.state.web3);
      return this.$store.state.web3;
    }
  },
  components: {
    Myheader
  }
};
</script>