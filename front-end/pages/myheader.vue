<template>
<div class="header" style="text-align: right;" >
  <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
  <el-menu-item index="1">HomeMortgage</el-menu-item>
  <el-menu-item index="2">Document</el-menu-item>
  <el-menu-item index="3">Market</el-menu-item>
  <el-menu-item index="4">Application</el-menu-item>
  <el-dropdown>
  <span class="el-dropdown-link">
    <el-button type="primary" icon="el-icon-setting" circle></el-button>
  </span>
  <el-dropdown-menu slot="dropdown">
    <el-dropdown-item><el-button @click="logout()">logout</el-button></el-dropdown-item>
  </el-dropdown-menu>
</el-dropdown>
  
 
</el-menu>
  <br>
</div>
</template> 

<style>
.content-center {
  width:60%;
  margin-left: auto;
  margin-right: auto;
}

</style>
<script>
import {Document, Application} from "../store/index.js"


export default {
  beforeCreate() {
    if (this.$store.state.web3.coinbase == null) {
      this.$store.dispatch("registerWeb3");
      this.$store.dispatch("getContractInstance");
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
    },
    logout () {
      this.$store.logged = false;
      this.$router.push("/");
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