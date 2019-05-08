const ipc = require("electron").ipcRenderer;
let container, links, nav;
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

let removeViews = () => {
    while (container.firstChild) {
        container.removeChild(container.firstChild);
    }
};

let routeTo = (newName) => {
    // remove any old template from DOM
    removeViews();
    // based on the nav item clicked, select the new route information
    let routeInfo = routes.filter((route) => {
        return route.name === newName;
    })[0];
    // if the route is navigated to first time, load its template into the route information for reuse
    if (!routeInfo.tpl) {
        let tpl = Array.from(links).filter((link) => {
            return link.getAttribute("href") === routeInfo.id + ".html";
        })[0];
        routeInfo.tpl = tpl.import.getElementById(routeInfo.id);
    }
    // add the new route template to the DOM
    container.appendChild(document.importNode(routeInfo.tpl.content, true));
};

// TODO: make router work for loading at any route, right now only works for default route
// TODO: make forward and back ability work with history api
window.onload = () => {
    // the route display element
    container = document.getElementById("app");
    // get node list of all link tags for view template
    links = document.querySelectorAll("link[rel='import']");
    // get node list of all nav buttons for view templace
    // TODO: replace with any form of navigation for app
    nav = document.querySelectorAll("button[route]");

    // create the generic nav handler used by all nav items
    let navHandler = (event) => {
        routeTo(event.target.getAttribute("route"));
    };

    // register event listeners for all nav items to load view
    Array.from(nav).forEach((navItem) => {
        navItem.addEventListener("click", navHandler);
    });
};

global.grbk = {
    msgs: [],
    ipcSend: (msgs, data, callback) => {
        if (!global.grbk.equals(msgs)) {
            global.grbk.msgs.push(msgs);
            global.grbk.addListener(msgs.rtnmsg, callback);
        }
        ipc.send(msgs.msg, data);
    },
    equals: (obj) => {
        return global.grbk.msgs.some((m, i) => {
            return m.msg === obj.msg && m.rtnmsg === obj.rtnmsg;
        });
    },
    addListener: (rtnmsg, callback) => {
        ipc.on(rtnmsg, (event, data) => {
            callback(event, data);
        });
    },
    navigate: (name) => routeTo(name)
};