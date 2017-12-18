import Vue from 'vue';
import Hello from '@/components/Hello';

describe('Hello.vue', () => {
  it('should correct text value', () => {
    expect(Hello.data().msg)
      .to.equal('Welcome to Your Vue.js App');
  });
  it('should render correct contents', () => {
    const Constructor = Vue.extend(Hello);
    const vm = new Constructor().$mount();
    expect(vm.$el.querySelector('.hello h1').textContent)
      .to.equal('Welcome to Your Vue.js App');
  });
});
