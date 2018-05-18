<template>
    <div>
    <Myheader></Myheader>
    <br>
    <el-form :model="ruleForm2" status-icon ref="ruleForm2" label-width="120px" class="demo-ruleForm">
  <el-form-item label="Property" prop="Property">
      <el-select v-model="value" placeholder="Select Property">
    <el-option
      v-for="item in options"
      :key="item.value"
      :label="item.label"
      :value="item.value">
    </el-option>
  </el-select>
  </el-form-item>
    <el-form-item label="Duration(days)" prop="duration">
    <el-input v-model="ruleForm2.name" auto-complete="off"></el-input>
  </el-form-item>
  <el-form-item label="Interests per day" prop="interests">
    <el-input v-model="ruleForm2.name" auto-complete="off"></el-input>
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
          value: "Id",
          label: "Id"
        },
        {
          value: "Financial",
          label: "Financial"
        },
        {
          value: "Property",
          label: "Property"
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