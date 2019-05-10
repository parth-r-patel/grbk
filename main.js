import {app, BrowserWindow, ipcMain as ipc} from 'electron';
import fetch from 'electron-fetch';
import * as path from 'path';
import * as url from 'url';

const env = process.env.NODE_ENV;

// Keep a global reference of the window object, if you don"t, the window will
// be closed automatically when the JavaScript object is garbage collected.
let win, apicall;

const scheme = "app";

function createWindow () {
  // Base path used to resolve modules
  // const base = app.getAppPath();

  // Create the browser window.
  win = new BrowserWindow({
    width: 2500, 
    height: 1000, 
    transparent: false,
    frame: true,
    show: false
  });

  // and load the index.html of the app.
  win.loadURL(url.format({
    pathname: path.join(__dirname, "app", "pages","index.html"),
    protocol: "file",
    slashes: true
  }));

  // Open the DevTools.
  win.webContents.openDevTools();

  // Emitted when the window is closed.
  win.on("closed", () => {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    win = null;
  });

  win.on("ready-to-show", () => {
    win.show();
  });
}

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on("ready", createWindow);

// Quit when all windows are closed.
app.on("window-all-closed", () => {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== "darwin") {
    app.quit()
  }
});

app.on("activate", () => {
  // On macOS it"s common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (win === null) {
    createWindow()
  }
});

let tbarequest = {
  hostname: "thebluealliance.com",
  path: "/api/v3/event/2018dal/teams/keys",
  protocol: "https:"
}

// In this file you can include the rest of your app"s specific main process
// code. You can also put them in separate files and require them here.
ipc.on("login-submit", (event, data) => {
  fetch("https://www.thebluealliance.com/api/v3/event/2018dal/teams/keys", {
    headers: {
      "X-TBA-Auth-Key": "juxp3YbEQdm2Hvn0sb0t0Et4zkAhlYEBjvsXmPhwHLSpssRJjibOREuU0gbuQUku"
    }
  }).then(res => res.json())
    .then(body => {
      let result = {
        "success": true,
        "body": body
      };
      event.sender.send("login-attempt", result);
    }).catch(err => {
      let result = {"success": false};
      event.sender.send("login-attempt", result);
    });
    
});