let viewContainer, importsList;
let Router = {
    routes: [],

    setup: (container, imports, routes) => {
        Router.setContainer(container);
        Router.setImportsList(imports);
        Router.routes = routes;
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
    }
}

export default Router;