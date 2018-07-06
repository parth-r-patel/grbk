{
  let btnLogin = document.getElementById("loginButton");
  let txtUsername = document.getElementById("username");
  let txtPassword = document.getElementById("password");
  let loading = document.getElementById("loading");

  btnLogin.addEventListener("click", () => {
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
    console.log(data);
  };
}
