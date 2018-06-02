<template>
    <div>
    <Myheader></Myheader>
    <br>
<el-row> 
      <el-button type="primary" icon="el-icon-circle-plus" circle v-on:click="plusClick" style="float:right"></el-button>
  <el-col :span="8" v-for="(app) in applications" :key="app.id" :offset="2">
    <el-card>
    <div slot="header" class="clearfix">
      <div style="display:inline">
        <div style="display:inline-block">Borrower: {{app.applicant}}</div>
        <div style="margin-top:10px; display:inline-block" v-if="currentDate.setTime(app.createdTime)">Time created: {{currentDate.toLocaleString()}}</div>
      </div>
    <span class="status">
      <el-button  v-if="app.status == 0" type="primary">
        Funding
      </el-button >
      <el-button  v-else-if="app.status == 1" type="info">
        Failed
      </el-button >
      <el-button  v-else-if="app.status == 2" type="success">
        Repaying
      </el-button >
      <el-button  v-else-if="app.status == 3" type="success">
        Redeemed
      </el-button >
      <el-button  v-else type="danger">
        Repossessed
      </el-button >
    </span>
  </div>
      <div class="content">
        <div class="content-el">Funding Duration: {{app.fundingDuration/24/60/60}} days</div>
        <div class="content-el">Repay Duration: {{app.repayDuration/24/60/60}} days</div>
        <div class="content-el">Interets: {{app.interests}}%</div>
        <div class="content-el">Total Amount: {{app.totalAmount/1000000000000000000}} eth</div>
        <el-progress  :text-inside="true" :stroke-width="16" class="content-el" :percentage="(app.curAmount/app.totalAmount).toFixed(2)*100"></el-progress>
        <div class="content-el">Raised Amount: {{app.curAmount/1000000000000000000}} eth</div>
        <div v-if="app.startTime == 0"></div> 
        <div v-else class="content-el"><span v-if="currentDate.setTime(app.startTime)"></span>Repay started: {{currentDate.toLocaleString()}}
          <div class="content-el"><span v-if="(startTime = app.startTime) && (duration = app.repayDuration)"></span>Time left: {{day}} days {{hour}} hours {{minute}} minutes {{second}} seconds</div>
          <el-progress status="exception" :text-inside="true" :stroke-width="16" class="content-el" :percentage="((app.repayedAmount)/(app.totalAmount)*100).toFixed(2)"></el-progress>
          <div class="content-el">Repayed Amount: {{app.repayedAmount/1000000000000000000}} eth</div>
        </div>
      </div>
      <el-popover v-if="app.status == 2"
        placement="right"
        width="220"
        v-model="visibility[app.id]">
        <p>How much you want to pay?</p>
        <div style="text-align: right;">
          <el-input v-model="input" placeholder="eth" size="mini" style="margin-bottom:10px"></el-input>
          <el-button type="success" size="mini" v-on:click="repay(app.id)">Ok</el-button>
        </div>
        <el-button slot="reference" type="success">Repay</el-button>
      </el-popover>
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
      startTime : 0,
      duration : 0,
    };
  },
    computed: {
    applications() {
      return this.$store.state.myApplications
    },
    visibility() {
      let visibility = [];
      for (var i =0; i < this.applications.length; i++) {
        visibility.push(false);
      }
      return visibility;
    },
    day () {
      return Math.floor(((this.duration - (new Date().valueOf() - this.startTime))/1000) / (60 * 60 * 24))
    },
    hour () {
      return Math.floor((((this.duration - (new Date().valueOf() - this.startTime))/1000)) / (60 * 60)) - (this.day * 24)
    },
    minute () {
      return Math.floor((((this.duration - (new Date().valueOf() - this.startTime))/1000)) / 60) - (this.day * 24 * 60) - (this.hour * 60)
    },
    second () {
      return Math.floor((((this.duration - (new Date().valueOf() - this.startTime))/1000))) - (this.day * 24 * 60 * 60) - (this.hour * 60 * 60) - (this.minute * 60)
    }
  },
  methods: {
    plusClick() {
      this.$router.push("/applyform");
    },
    repay(id) {
      this.visible2 = false;
      let date = new Date();
      this.$store.state
        .contractInstance()
        .methods.Invest(id, date.valueOf())
        .send({ from: this.$store.state.web3.coinbase, value: this.$store.state.web3.web3Instance().utils.toWei(this.input) })
        .on("receipt", function(receipt) {
          console.log(receipt);
        })
        .on("error", function(error) {
          // Do something to alert the user their transaction has failed
          console.log("Register failed", error);
        });
    },
  },
  components: {
    Myheader
  }
};
</script>