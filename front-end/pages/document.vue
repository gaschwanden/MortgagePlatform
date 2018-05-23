<template>
    <div>
    <Myheader></Myheader>
    <br>
<el-row>
  <el-col :span="8" v-for="(doc, index) in documents" :key="doc.name" :offset="index > 0 ? 2 : 0">
    <el-card :body-style="{ padding: '0px' }">
      <img src="" class="image">
      <div style="padding: 14px;">
        <span>{{doc.name}}</span>
        <div class="bottom clearfix">
          <time class="time">{{ doc.sourceUrl }}</time>
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
import {Document} from "../store/index.js"


export default {
  beforeCreate() {
    var documents = [];
    let store = this.$store;
    if (store.state.logged) {
      store.commit("changeActiveIndex", "2");
      let contract = store.state.contractInstance();
      contract.methods
        .GetDocs(store.state.web3.coinbase)
        .call()
        .then(function(result) {
          for (let i = 0; i < result.length; i++) {
            contract.methods
              .GetDoc(result[i])
              .call()
              .then(function(re) {
                documents.push(new Document(re[0], re[1], re[2], re[3], re[4]));
                store.commit("updateDocs", documents);
              });
          }
        });
    } else {
      this.$router.push("/login");
    }
  },

  data() {
    return {
      currentDate: new Date(),
    };
  },
    computed: {
    documents() {
    //   console.log(this.$store.state.documents);
      return this.$store.state.documents
    }
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