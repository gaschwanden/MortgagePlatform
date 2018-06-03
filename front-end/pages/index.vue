<template>
    <div >
    <Myheader></Myheader>
    <div class="login">
      

      <el-form :model="ruleForm2" status-icon ref="ruleForm2" label-width="120px" class="demo-ruleForm">
        <el-form-item >
        <h1>Welcome to HomeMortgage</h1>
        <h3>A decentralized mortgage market for real-estate crowdfunding.</h3>
      </el-form-item>

      <el-form-item label="Name" prop="name">
        <el-input v-model.number="ruleForm2.name"></el-input>
      </el-form-item>
      <el-form-item label="Address" prop="address">
        <el-input v-model.number="ruleForm2.address"></el-input>
      </el-form-item>
        <el-form-item label="Type" prop="Type">
          <el-select v-model="ruleForm2.type" placeholder="Select">
        <el-option
          v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value">
        </el-option>
      </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm2')">Login</el-button>
        <el-button @click="resetForm('ruleForm2')">Reset</el-button>
      </el-form-item>
      <el-form-item>
        <h4 style="color: #409EFF;">Please login first to use our service.</h4>
      </el-form-item>
      
    </el-form>
    </div>

    </div>

</template>

<style>
.login {
  width:50%;
  margin-left: auto;
  margin-right: auto;
}

</style>

<script>
import Myheader from "./myheader.vue";

export default {
  data() {
    return {
      ruleForm2: {
        name : "",
        address: "",
        type:"",
      },
      options: [
        {
          value: "0",
          label: "Borrower"
        },
        {
          value: "1",
          label: "Verifier"
        },
        {
          value: "2",
          label: "Investor"
        }
      ],
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$store.state.logged = true;
          this.$store.state.userType = type;
          this.$router.push("/document");
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