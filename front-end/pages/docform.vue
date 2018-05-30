<template>
    <div>
    <Myheader></Myheader>

    <el-form :model="ruleForm2" status-icon ref="ruleForm2" label-width="120px" class="demo-ruleForm">

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
      <el-upload
        class="upload-demo"
        action="https://jsonplaceholder.typicode.com/posts/"
        :on-preview="handlePreview"
        :on-remove="handleRemove"
        :before-remove="beforeRemove"
        multiple
        :limit="3"
        :on-exceed="handleExceed"
        :file-list="fileList">
  <el-button size="medium" type="primary">Upload</el-button>
  <div slot="tip" class="el-upload__tip">Only jpg/png file, no more than 500kb</div>
</el-upload>
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
        source: ""
      },
      options: [
        {
          value: "0",
          label: "Id"
        },
        {
          value: "1",
          label: "Financial"
        },
        {
          value: "2",
          label: "Property"
        }
      ],
      fileList: []
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          let router = this.$router;
          this.$store.state
            .contractInstance()
            .methods.DocRegister(
              this.ruleForm2.name,
              this.ruleForm2.type,
              "asdas.jpg"
            )
            .send({ from: this.$store.state.web3.coinbase })
            .on("receipt", function(receipt) {
              console.log(receipt);
              this.$router.push("/document");
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
    },
    handleRemove(file, fileList) {
      console.log(file, fileList);
    },
    handlePreview(file) {
      console.log(file);
    },
    handleExceed(files, fileList) {
      this.$message.warning(
        `当前限制选择 3 个文件，本次选择了 ${
          files.length
        } 个文件，共选择了 ${files.length + fileList.length} 个文件`
      );
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`确定移除 ${file.name}？`);
    }
  },
  components: {
    Myheader
  }
};
</script>