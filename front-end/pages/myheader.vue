<template>
<div class="header" style="text-align: right;" >
  <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
  <el-menu-item index="1">HomeMortgage</el-menu-item>
  <el-menu-item index="2">Document</el-menu-item>
  <el-menu-item index="3">Market</el-menu-item>
  <el-menu-item index="4">Application</el-menu-item>
  <el-button type="primary" icon="el-icon-setting" circle></el-button>
 
</el-menu>
  <br>
</div>
</template> 

<script>
import {Document, Application} from "../store/index.js"


export default {
  beforeCreate() {
    if (this.$store.state.web3.coinbase == null) {
      this.$store.dispatch("registerWeb3");
      this.$store.dispatch("getContractInstance");

        // if (store.state.applications == null) {
        //   var applications = [];
        //   let contract = store.state.contractInstance();
        //   contract.methods
        //     .GetDocs(store.state.web3.coinbase)
        //     .call()
        //     .then(function(result) {
        //       for (let i = 0; i < result.length; i++) {
        //         contract.methods
        //           .GetDoc(result[i])
        //           .call()
        //           .then(function(re) {
        //             applications.push(
        //               new Application(re[0], re[1], re[2], re[3], re[4])
        //             );
        //             store.commit("updateApps", applications);
        //           });
        //       }
        //     });
        // }

    }
  },

  data() {
    return {
      activeIndex: this.$store.state.activeIndex
    };
  },
  methods: {
    handleSelect(key, keyPath) {
      switch (key) {
        case "1":
          this.$router.push("/");
          this.$store.commit("changeActiveIndex", "1");
          break;
        case "2":
          this.$router.push("/Document");
          this.$store.commit("changeActiveIndex", "2");
          break;
        case "3":
          this.$router.push("/Market");
          this.$store.commit("changeActiveIndex", "3");
          break;
        case "4":
          this.$router.push("/Application");
          this.$store.commit("changeActiveIndex", "4");
          break;
        default:
          break;
      }
    }
  },
  computed: {
    web3() {
      console.log(this.$store.state.web3);
      return this.$store.state.web3;
    }
  }
};
</script>