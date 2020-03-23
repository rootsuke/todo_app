import Vue from 'vue';
import Base from './components/base.vue';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI)
Vue.config.productionTip = false;

new Vue({
  render: (h) => h(Base),
}).$mount('#app');
