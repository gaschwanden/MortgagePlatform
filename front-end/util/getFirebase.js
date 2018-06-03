import firebase from "firebase";

var config = {
apiKey: "AIzaSyAK5DKAK0Q8298J3ObNvM2Cfian-DbilPU",
authDomain: "homemortgage-144ef.firebaseapp.com",
databaseURL: "https://homemortgage-144ef.firebaseio.com",
projectId: "homemortgage-144ef",
storageBucket: "homemortgage-144ef.appspot.com",
messagingSenderId: "956187590810"
};

export default !firebase.apps.length ? firebase.initializeApp(config) : firebase.app();
