<template>
    <div>
    <Myheader></Myheader>
    <br>
<el-row> 
    <el-button type="primary" icon="el-icon-circle-plus" circle v-on:click="plusClick" style="float:right"></el-button>
  <el-col :span="8" v-for="(doc) in documents" :key="doc.id" :offset="2">
    <el-card>
      <div style="padding: 14px;" >
        <div class="title">
          <span style="display:inline-block">{{doc.name}} </span>
          <span v-if="doc.verified"><el-button  type="success" style="float: right" icon="el-icon-success">Verified</el-button></span> 
          <span v-else><el-button type="warning" icon="el-icon-warning" style="float:right">Unverified</el-button></span>

        </div>
        <div class="bottom">
          <img :src="doc.sourceUrl" class="image">
        </div>
          <el-tag v-if="doc.type == 0"> ID</el-tag>
          <el-tag v-else-if="doc.type == 1"> Financial</el-tag>
          <el-tag v-else> Property</el-tag>
      </div>
    </el-card>
  </el-col>
</el-row>

    </div>

</template>

<style>
.title {
  line-height: 12px;
  margin-bottom: 40px;
}

.bottom {
  margin-top: 18px;
  line-height: 12px;
  margin-bottom:10px;
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
    this.$store.commit("changeActiveIndex", "2");
    this.$store.dispatch("updateDocs");
  },

  data() {
    return {
      currentDate: new Date(),
    };
  },
    computed: {
    documents() {
      // console.log(this.$store.state.documents)
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
    },
    plusClick() {
      this.$router.push("/docform");
    }
  },
  components: {
    Myheader
  }
};
</script>