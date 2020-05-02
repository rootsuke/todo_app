import Vue from 'vue';
import Base from './components/base.vue';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import './assets/fontawesome/css/fontawesome.css';
import './assets/fontawesome/css/regular.css';
import './assets/fontawesome/css/solid.css';

Vue.use(ElementUI)
Vue.config.productionTip = false;

new Vue({
  render: (h) => h(Base),
}).$mount('#app');
