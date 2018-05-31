<template>
    <div>
    <Myheader></Myheader>
    <br>
<el-row> 
      <el-button type="primary" icon="el-icon-circle-plus" circle v-on:click="plusClick" style="float:right"></el-button>
  <el-col :span="8" v-for="(app) in applications" :key="app.docs[0]" :offset="2">
    <el-card>
    <div slot="header" class="clearfix">
      <div style="display:inline">
        <div style="display:inline-block">Borrower: {{app.applicant}}</div>
        <div style="margin-top:10px; display:inline-block" v-bind="currentDate.setTime(app.createdTime)">Time created: {{currentDate.toLocaleString()}}</div>
      </div>
    <span class="status">
      <el-button  v-if="app.status == 0" type="primary">
        Funding
      </el-button >
      <el-button  v-else-if="type === 1" type="info">
        Failed
      </el-button >
      <el-button  v-else-if="type === 2" type="success">
        Repayment in progress
      </el-button >
      <el-button  v-else-if="type === 3" type="success">
        Redeemed
      </el-button >
      <el-button  v-else type="danger">
        Repossessed
      </el-button >
    </span>
  </div>
      <div class="content">
        <div class="content-el">Total Amount: {{app.totalAmount}} eth</div>
        <el-progress class="content-el" :percentage="app.curAmount/app.totalAmount"></el-progress>
        <div class="content-el">Raised Amount: {{app.curAmount}} eth</div>
        <div v-if="app.startTime == 0"></div> 
        <div v-else >Time started: {{currentDate.toLocaleString()}}</div>
        <div class="bottom clearfix">
          <img :src="s" class="image">
        </div>
        <div class="content-el">Duration: {{app.duration}} days</div>
        <div class="content-el">Interets: {{app.interests}}%</div>

      </div>
    </el-card>
  </el-col>
</el-row>

    </div>

</template>

<style>
.status {
  float: right;
}
.content-el {
  margin-bottom: 10px;
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
import {Application} from "../store/index.js"


export default {
  beforeCreate() {
    this.$store.commit("changeActiveIndex", "4");
    this.$store.dispatch("updateMyApps");
  },

  data() {
    return {
      currentDate: new Date(),
    };
  },
    computed: {
    applications() {
      return this.$store.state.myApplications
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