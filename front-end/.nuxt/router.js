import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

const _4a8234eb = () => import('../pages/register.vue' /* webpackChunkName: "pages/register" */).then(m => m.default || m)
const _66326afe = () => import('../pages/myheader.vue' /* webpackChunkName: "pages/myheader" */).then(m => m.default || m)
const _1330135e = () => import('../pages/login.vue' /* webpackChunkName: "pages/login" */).then(m => m.default || m)
const _587cdb63 = () => import('../pages/document.vue' /* webpackChunkName: "pages/document" */).then(m => m.default || m)
const _7676e4b8 = () => import('../pages/application.vue' /* webpackChunkName: "pages/application" */).then(m => m.default || m)
const _74b9c764 = () => import('../pages/docform.vue' /* webpackChunkName: "pages/docform" */).then(m => m.default || m)
const _f80c9bf8 = () => import('../pages/market.vue' /* webpackChunkName: "pages/market" */).then(m => m.default || m)
const _111f06de = () => import('../pages/profile.vue' /* webpackChunkName: "pages/profile" */).then(m => m.default || m)
const _2cc0533a = () => import('../pages/index.vue' /* webpackChunkName: "pages/index" */).then(m => m.default || m)



if (process.client) {
  window.history.scrollRestoration = 'manual'
}
const scrollBehavior = function (to, from, savedPosition) {
  // if the returned position is falsy or an empty object,
  // will retain current scroll position.
  let position = false

  // if no children detected
  if (to.matched.length < 2) {
    // scroll to the top of the page
    position = { x: 0, y: 0 }
  } else if (to.matched.some((r) => r.components.default.options.scrollToTop)) {
    // if one of the children has scrollToTop option set to true
    position = { x: 0, y: 0 }
  }

  // savedPosition is only available for popstate navigations (back button)
  if (savedPosition) {
    position = savedPosition
  }

  return new Promise(resolve => {
    // wait for the out transition to complete (if necessary)
    window.$nuxt.$once('triggerScroll', () => {
      // coords will be used if no selector is provided,
      // or if the selector didn't match any element.
      if (to.hash) {
        let hash = to.hash
        // CSS.escape() is not supported with IE and Edge.
        if (typeof window.CSS !== 'undefined' && typeof window.CSS.escape !== 'undefined') {
          hash = '#' + window.CSS.escape(hash.substr(1))
        }
        try {
          if (document.querySelector(hash)) {
            // scroll to anchor by returning the selector
            position = { selector: hash }
          }
        } catch (e) {
          console.warn('Failed to save scroll position. Please add CSS.escape() polyfill (https://github.com/mathiasbynens/CSS.escape).')
        }
      }
      resolve(position)
    })
  })
}


export function createRouter () {
  return new Router({
    mode: 'history',
    base: '/',
    linkActiveClass: 'nuxt-link-active',
    linkExactActiveClass: 'nuxt-link-exact-active',
    scrollBehavior,
    routes: [
		{
			path: "/register",
			component: _4a8234eb,
			name: "register"
		},
		{
			path: "/myheader",
			component: _66326afe,
			name: "myheader"
		},
		{
			path: "/login",
			component: _1330135e,
			name: "login"
		},
		{
			path: "/document",
			component: _587cdb63,
			name: "document"
		},
		{
			path: "/application",
			component: _7676e4b8,
			name: "application"
		},
		{
			path: "/docform",
			component: _74b9c764,
			name: "docform"
		},
		{
			path: "/market",
			component: _f80c9bf8,
			name: "market"
		},
		{
			path: "/profile",
			component: _111f06de,
			name: "profile"
		},
		{
			path: "/",
			component: _2cc0533a,
			name: "index"
		}
    ],
    
    
    fallback: false
  })
}
