let viewContainer, importsList;
let Router = {
    routes: [],
    navHandler: null,

    /** 
     * Sets up the Router object with the necessary features for a basic router
     * 
     * @param {object} container the node object that holds the router's html tag for views
     * @param {array} imports array of all the link tag elements that will be used to import the rout view templates
     * @param {array} routes array of the routes used by the router, defaults empty
     * @param {function} handler event handler function used to trigger routeTo for nav elements
     */
    setup: (container, imports, routes, handler) => {
        Router.setContainer(container);
        Router.setImportsList(imports);
        Router.routes = routes;
        Router.navHandler = handler;
    },
    addRoute: (route) => {
        Router.routes.push(route);
    },
    removeAllViews: () => {
        while (viewContainer.firstChild) {
            viewContainer.removeChild(viewContainer.firstChild);
        }
    },
    getContainer: () => {
        return viewContainer;
    },
    setContainer: (container) => {
        viewContainer = container;
    },
    getImportsList: () => {
        return importsList;
    },
    setImportsList: (imports) => {
        importsList = imports;
    },
    routeTo: (newName) => {
        // remove any old template from DOM
        Router.removeAllViews();
        // based on the nav item clicked, select the new route information
        let routeInfo = Router.routes.filter((route) => {
            return route.name === newName;
        })[0];
        // if the route is navigated to first time, load its template into the route information for reuse
        if (!routeInfo.tpl) {
            let tpl = Array.from(importsList).filter((link) => {
                return link.getAttribute("href") === routeInfo.id + ".html";
            })[0];
            routeInfo.tpl = tpl.import.getElementById(routeInfo.id);
        }
        // add the new route template to the DOM
        viewContainer.appendChild(document.importNode(routeInfo.tpl.content, true));
    },
    setNavHandler: (handler) => {
        Router.navHandler = handler;
    },
    registerNavHandler: (...nodes) => {
        for(let node of nodes) {
            node.addEventListener("click", Router.navHandler);
        }
    }
}

export default Router;