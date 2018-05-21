<template>
    <div>
    <Myheader></Myheader>
    <el-form :model="ruleForm2" :rules="rules" status-icon ref="ruleForm2" label-width="120px" class="demo-ruleForm">
  <el-form-item label="Name" prop="name">
    <el-input v-model="ruleForm2.name" auto-complete="off"></el-input>
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
        type: ""
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
      rules: {
        name: [
          { required: true, message: "Name is required", trigger: "change" }
        ],
        type: [{ required: true, message: "Type is required", trigger: "blur" }]
      }
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          let router = this.$router;
          this.$store.state
            .contractInstance()
            .methods.UserRegister(
              this.ruleForm2.name,
              this.ruleForm2.type
            )
            .send({ from: this.$store.state.web3.coinbase })
            .on("receipt", function(receipt) {
              console.log(receipt);
              router.push("/profile");
            })
            .on("error", function(error) {
              // Do something to alert the user their transaction has failed
              console.log("Register failed");
            });
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