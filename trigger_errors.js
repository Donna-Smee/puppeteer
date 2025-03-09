const puppeteer = require('puppeteer');

/*const websites = [
  { url: 'http://nodejs-app-1:3000/error', name: 'Website A' },
  { url: 'http://nodejs-app-2:4000/error', name: 'Website B' },
];*/


const websites = [
    { url: 'http://localhost:3000/error', name: 'first-web-app' },
    { url: 'http://localhost:4000/error', name: 'second-web-app' },
  ];


  
  async function triggerError(website) {
    const browser = await puppeteer.launch({ headless: process.env.PUPPETEER_HEADLESS !== 'false' });
    const page = await browser.newPage();
  
    console.log(`Triggering error on: ${website.name}`);
    await page.goto(website.url);
  
    console.log(`Triggered error (500) at ${website.name} - ${website.url}`);
  
    // Simulate random delays using setTimeout as a workaround
    const randomWaitTime = Math.floor(Math.random() * 5000) + 1000;  // Between 1s and 5s
    await new Promise(resolve => setTimeout(resolve, randomWaitTime)); // Use setTimeout wrapped in Promise
  
    await browser.close();
  }
  
  // Trigger errors every 5 seconds
  async function triggerErrors() {
    setInterval(async () => {
      const randomWebsite = websites[Math.floor(Math.random() * websites.length)];
      await triggerError(randomWebsite);
    }, 5000);  // trigger time
  }
  
  triggerErrors();
  