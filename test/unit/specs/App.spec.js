import App from '@/App';

describe('App.vue', () => {
  it('should correct text value', () => {
    expect(App.data().title)
      .to.equal('Vuetify.js');
  });
});
