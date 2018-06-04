<template>
    <div>
    <Myheader></Myheader>
    <div class="content-center">
    <el-form :model="ruleForm2" status-icon ref="ruleForm2" label-width="120px" class="demo-ruleForm">
      <el-form-item >
        <h3>Upload your document.</h3>
      </el-form-item>

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
        action=""
        :on-preview="handlePreview"
        :on-remove="handleRemove"
        :before-remove="beforeRemove"
        :on-success="handleSuccess"
        :before-upload="beforeAvatarUpload"
        multiple
        :limit="1"
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
    </div>

</template>

<script>
import Myheader from "./myheader.vue";
import firebase from "../util/getFirebase.js";

export default {
  beforeCreate() {
    if (!this.$store.state.logged) {
      this.$router.push("/");
      return;
    }
  },

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
          let date = new Date();
          let store = this.$store;
          let name = this.ruleForm2.name;
          let type = this.ruleForm2.type;
          let storageRef = firebase.storage().ref();
          let child = storageRef.child('doc/' + date.toString() + ".jpg");
          if (this. fileList.length == 0) {
            alert("Have to provide an image of the document");
            return;
          }
          let task = child.put(this.fileList[0]);
          task.on('state_changed', 
            function progress(snapshot) {
              let percentage = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
              console.log(percentage);
            },
            function error(err) {
              console.log("err", err);
            },
            function complete() {
              task.snapshot.ref.getDownloadURL().then(function(downloadURL) {
                console.log("url", downloadURL);
                store.state.contractInstance()
                .methods.DocRegister(
                  name,
                  date.valueOf(),
                  type,
                  downloadURL
                )
                .send({ from: store.state.web3.coinbase })
                .on("receipt", function(receipt) {
                  console.log(receipt);
                  router.push("/document");
                })
                .on("error", function(error) {
                  // Do something to alert the user their transaction has failed
                  console.log("Register failed", error);
                });
              })
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
        `Only 1 file allowed, ${files.length + fileList.length} provided`
      );
      console.log(fileList);
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`Are you sure to delete ${file.name}？`);
    },
    handleSuccess(res, file) {
      this.fileList.push(file.raw);
      console.log(file.raw);
    },
    beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg' || 'image/png';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if (!isJPG) {
          this.$message.error('Only jpg and png allowed');
        }
        if (!isLt2M) {
          this.$message.error('File size go beyond 2MB!');
        }
        return isJPG && isLt2M;
      }
  },
  components: {
    Myheader
  }
};
</script>