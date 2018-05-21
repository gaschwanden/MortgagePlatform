<template>
    <div>
    <Myheader></Myheader>
    <br>
<el-row>
  <el-col :span="8" v-for="(o, index) in 2" :key="o" :offset="index > 0 ? 2 : 0">
    <el-card :body-style="{ padding: '0px' }">
      <img src="" class="image">
      <div style="padding: 14px;">
        <span>borrower</span>
        <div class="bottom clearfix">
          <time class="time">{{ currentDate }}</time>
        </div>
      </div>
    </el-card>
  </el-col>
</el-row>

    </div>

</template>

<style>
.time {
  font-size: 13px;
  color: #999;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}

.image {
  width: 100%;
  display: block;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both;
}
</style>

<script>
import Myheader from "./myheader.vue";

export default {
  beforeCreate() {
    if (this.$store.state.logged) {
      this.$store.commit("changeActiveIndex", "2");
      let contract = this.$store.state.contractInstance();
      contract.methods
        .GetDocs(this.$store.state.web3.coinbase)
        .call()
        .then(function(result) {
          for (let i = 0; i < result.length; i++) {
            contract.methods
              .GetDoc(result[i])
              .call()
              .then(function(re) {
                console.log(re);
              });
          }
        });
    } else {
      this.$router.push("/login");
    }
  },

  data() {
    return {
      currentDate: new Date()
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          alert("submit!");
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  },
  components: {
    Myheader
  }
};
</script>