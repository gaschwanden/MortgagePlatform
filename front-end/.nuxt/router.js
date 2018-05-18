import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

const _1c8f7804 = () => import('../pages/register.vue' /* webpackChunkName: "pages/register" */).then(m => m.default || m)
const _c217e4cc = () => import('../pages/myheader.vue' /* webpackChunkName: "pages/myheader" */).then(m => m.default || m)
const _5fab9c50 = () => import('../pages/login.vue' /* webpackChunkName: "pages/login" */).then(m => m.default || m)
const _324985aa = () => import('../pages/docform.vue' /* webpackChunkName: "pages/docform" */).then(m => m.default || m)
const _6bca1eff = () => import('../pages/application.vue' /* webpackChunkName: "pages/application" */).then(m => m.default || m)
const _3b023146 = () => import('../pages/market.vue' /* webpackChunkName: "pages/market" */).then(m => m.default || m)
const _6991f258 = () => import('../pages/profile.vue' /* webpackChunkName: "pages/profile" */).then(m => m.default || m)
const _06828ec1 = () => import('../pages/index.vue' /* webpackChunkName: "pages/index" */).then(m => m.default || m)



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
			component: _1c8f7804,
			name: "register"
		},
		{
			path: "/myheader",
			component: _c217e4cc,
			name: "myheader"
		},
		{
			path: "/login",
			component: _5fab9c50,
			name: "login"
		},
		{
			path: "/docform",
			component: _324985aa,
			name: "docform"
		},
		{
			path: "/application",
			component: _6bca1eff,
			name: "application"
		},
		{
			path: "/market",
			component: _3b023146,
			name: "market"
		},
		{
			path: "/profile",
			component: _6991f258,
			name: "profile"
		},
		{
			path: "/",
			component: _06828ec1,
			name: "index"
		}
    ],
    
    
    fallback: false
  })
}
