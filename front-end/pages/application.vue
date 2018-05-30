<template>
    <div>
    <Myheader></Myheader>
    <br>
<el-row> 
      <el-button type="primary" icon="el-icon-circle-plus" circle v-on:click="plusClick" style="float:right"></el-button>
  <el-col :span="8" v-for="(app) in applications" :key="app.docs[0]" :offset="2">
    <el-card :body-style="{ padding: '0px' }">
      <div style="padding: 14px;" >
        <span>{{app.totalAmount}}</span> 
        <div class="bottom clearfix">
          <img :src="s" class="image">
        </div>
        <span>{{app.duration}}</span>        
      </div>
    </el-card>
  </el-col>
</el-row>

    </div>

</template>

<style>

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
import {Application} from "../store/index.js"


export default {
  beforeCreate() {
    this.$store.commit("changeActiveIndex", "4");
  },

  data() {
    return {
      currentDate: new Date(),
    };
  },
    computed: {
    applications() {
      return this.$store.state.applications
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
    },
    plusClick() {
      this.$router.push("/applyform");
    }
  },
  components: {
    Myheader
  }
};
</script>