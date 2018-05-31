<template>
    <div>
    <Myheader></Myheader>
    <br>
    <el-form :model="ruleForm2" status-icon ref="ruleForm2" label-width="180px" class="demo-ruleForm">
  <el-form-item label="Property" prop="Property">
      <el-select v-model="ruleForm2.property" placeholder="Select Property">
    <el-option
      v-for="item in options"
      :key="item.value"
      :label="item.label"
      :value="item.value">
    </el-option>
  </el-select>
  </el-form-item>
    <el-form-item label="Total amount(eth)" prop="totalAmount">
    <el-input v-model="ruleForm2.totalAmount" auto-complete="off"></el-input>
  </el-form-item>
    <el-form-item label="Duration(days)" prop="duration">
    <el-input v-model="ruleForm2.duration" auto-complete="off"></el-input>
  </el-form-item>
  <el-form-item label="Interests per month(%)" prop="interests">
    <el-input v-model="ruleForm2.interests" auto-complete="off"></el-input>
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
        totalAmount: "",
        duration: "",
        interests: "",
        property: "",
      },
    };
  },

computed: {
    options() {
      let documents = this.$store.state.documents;
      if (documents != null) {
        let options = [];
        for (let i=0; i<documents.length; i++) {
            if (documents[i].type == 2) {
                options.push({value:documents[i].id, label:documents[i].name})
            }
        }
        return options;
      } 
      else {
          return null;
      }
    },
},

  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          let router = this.$router;
          let date = new Date();
          this.$store.state
            .contractInstance()
            .methods.Apply(
              [this.ruleForm2.property],
              this.ruleForm2.totalAmount,
              date.valueOf(),
              this.ruleForm2.duration,
              this.ruleForm2.interests,
            )
            .send({ from: this.$store.state.web3.coinbase })
            .on("receipt", function(receipt) {
              console.log(receipt);
            })
            .on("error", function(error) {
              // Do something to alert the user their transaction has failed
              console.log("Register failed", error);
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