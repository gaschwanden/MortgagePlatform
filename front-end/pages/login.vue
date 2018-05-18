<template>
    <div >
    <Myheader></Myheader>
    <el-form :model="ruleForm2" status-icon ref="ruleForm2" label-width="120px" class="demo-ruleForm">
  <el-form-item label="Address" prop="address">
    <el-input v-model.number="ruleForm2.age"></el-input>
  </el-form-item>
  <el-form-item>
    <el-button type="primary" @click="submitForm('ruleForm2')">Submit</el-button>
    <el-button @click="resetForm('ruleForm2')">Reset</el-button>
  </el-form-item>
</el-form>
    </div>

</template>

<script>
import Myheader from "./myheader.vue";

export default {
  data() {
    return {
      ruleForm2: {
        name: "",
        type: "",
        address: ""
      },
      options: [
        {
          value: "Borrower",
          label: "Borrower"
        },
        {
          value: "Verifier",
          label: "Verifier"
        },
        {
          value: "Investor",
          label: "Investor"
        }
      ]
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