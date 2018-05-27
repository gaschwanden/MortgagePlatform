<template>
<div class="header" style="text-align: right;" >
  <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
  <el-menu-item index="1">HomeMortgage</el-menu-item>
  <el-menu-item index="2">Document</el-menu-item>
  <el-menu-item index="3">Market</el-menu-item>
  <el-menu-item index="4">Application</el-menu-item>
  <el-button type="primary" icon="el-icon-circle-plus" circle v-on:click="newDoc"></el-button>
  <el-button type="primary" icon="el-icon-setting" circle></el-button>
 
</el-menu>
  <br>
</div>
</template> 

<script>
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
    newDoc() {
      this.$router.push("/docform");
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