{
  let btnLogin = document.getElementById("loginButton");
  let txtUsername = document.getElementById("username");
  let txtPassword = document.getElementById("password");
  
  btnLogin.addEventListener("click", () => {
    let loading = document.getElementById("loading");
    loading.style = "display: block;";
    let user = {
      username: txtUsername.value,
      password: txtPassword.value
    };
    let msgs = {
      msg: "login-submit",
      rtnmsg: "login-attempt"
    };
    global.grbk.ipcSend(msgs, user, loginHandler);
  });

  let loginHandler = (event, data) => {
    if(data.success) {
      global.grbk.navigate("dash");
      console.log(data.body);
    }
    else{
      console.log("failed");
    }
  };
}
