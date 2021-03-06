// For authoring Nightwatch tests, see
// http://nightwatchjs.org/guide#usage

module.exports = {
  'default e2e tests': function test(browser) {
    // automatically uses dev Server port from /config.index.js
    // default: http://localhost:8080
    // see nightwatch.conf.js
    const devServer = browser.globals.devServerURL;

    browser
      .url(devServer)
      .waitForElementVisible('#app', 5000)
      .assert.containsText('.toolbar__title', 'Vuetify.js')
      .assert.elementPresent('.layout.column.align-center')
      .assert.containsText('blockquote', 'First, solve the problem. Then, write the code.')
      .assert.elementCount('img', 1)
      .end();
  },
};
