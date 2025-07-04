const { Builder, By, until } = require('selenium-webdriver');
const { expect } = require('chai');
const fs = require('fs');

describe('Saucedemo Login Tests', function () {
  this.timeout(30000);
  let driver;

  before(async () => {
    driver = await new Builder().forBrowser('chrome').build();
  });

  after(async () => {
    //await driver.quit();
  });

  it('should show error message with invalid credentials', async () => {
    await driver.get('https://www.saucedemo.com/');

    await driver.wait(until.elementLocated(By.id('user-name')), 5000);
    const usernameInput = await driver.findElement(By.id('user-name'));
    const passwordInput = await driver.findElement(By.id('password'));

    await usernameInput.sendKeys('invalid_user');
    await passwordInput.sendKeys('wrong_password');

    await driver.findElement(By.id('login-button')).click();

    const errorMessageLocator = By.css('[data-test="error"]');
    await driver.wait(until.elementLocated(errorMessageLocator), 5000);
    const errorMessage = await driver.findElement(errorMessageLocator).getText();

    if (errorMessage.includes('Username and password do not match') || errorMessage.includes('Epic sadface')) {
      const image = await driver.takeScreenshot();
      fs.writeFileSync('error_screenshot.png', image, 'base64');
      await driver.sleep(3000); 
    }

    expect(errorMessage).to.include('Username and password do not match');
  });

  it('should login successfully with valid credentials', async () => {
    await driver.get('https://www.saucedemo.com/');

    await driver.wait(until.elementLocated(By.id('user-name')), 5000);
    const usernameInput = await driver.findElement(By.id('user-name'));
    const passwordInput = await driver.findElement(By.id('password'));

    await usernameInput.sendKeys('standard_user');
    await passwordInput.sendKeys('secret_sauce');

    await driver.findElement(By.id('login-button')).click();

    await driver.wait(until.urlContains('inventory.html'), 5000);
    const currentUrl = await driver.getCurrentUrl();

    expect(currentUrl).to.include('inventory.html');
  });
});
