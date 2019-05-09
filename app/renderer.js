import {ipcRenderer as electronIpc} from 'electron';
import Router from './router/router.js';
let container, imports, nav;

let routes = [
    {
        name: "root",
        path: "",
    },
    {
        name: "login",
        path: "#login",
        id: "login-view",
        ctrl: "login.js"
    },
    {
        name: "dash",
        path: "#dash",
        id: "dash-view"
    }
];

// TODO: make router work for loading at any route, right now only works for default route
// TODO: make forward and back ability work with history api
window.onload = () => {
    // the route display element
    container = document.getElementById("app");
    // get node list of all link tags for view template
    imports = document.querySelectorAll("link[rel='import']");
    // pass the view contianer and the import nodes for view templates
    Router.setup(container, imports, routes);
    // get node list of all nav buttons for view templace
    // TODO: replace with any form of navigation for app
    nav = document.querySelectorAll("button[route]");

    // create the generic nav handler used by all nav items
    let navHandler = (event) => {
        Router.routeTo(event.target.getAttribute("route"));
    };

    // register event listeners for all nav items to load view
    Array.from(nav).forEach((navItem) => {
        navItem.addEventListener("click", navHandler);
    });
};

// TODO: try to see if esm allows for importing ipc in view controllers and remove global.grbk
global.grbk = {
    msgs: [],
    ipcSend: (msgs, data, callback) => {
        if (!global.grbk.equals(msgs)) {
            global.grbk.msgs.push(msgs);
            global.grbk.addListener(msgs.rtnmsg, callback);
        }
        electronIpc.send(msgs.msg, data);
    },
    equals: (obj) => {
        return global.grbk.msgs.some((m, i) => {
            return m.msg === obj.msg && m.rtnmsg === obj.rtnmsg;
        });
    },
    addListener: (rtnmsg, callback) => {
        electronIpc.on(rtnmsg, (event, data) => {
            callback(event, data);
        });
    },
    navigate: (name) => Router.routeTo(name)
};