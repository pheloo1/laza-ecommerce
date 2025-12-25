exports.config = {
    // ====================
    // Runner Configuration
    // ====================
    runner: 'local',
    port: 4723,
    
    // ==================
    // Specify Test Files
    // ==================
    specs: [
        './specs/**/*.spec.js'
    ],
    
    // Patterns to exclude
    exclude: [
        // 'path/to/excluded/files'
    ],
    
    // ============
    // Capabilities
    // ============
    maxInstances: 1,
    capabilities: [{
        platformName: 'Android',
        'appium:deviceName': 'Android Emulator',
        'appium:platformVersion': '13.0',
        'appium:app': '../builds/apk/app-release.apk',
        'appium:automationName': 'UiAutomator2',
        'appium:appPackage': 'com.laza.ecommerce',
        'appium:appActivity': '.MainActivity',
        'appium:noReset': false,
        'appium:fullReset': true,
        'appium:newCommandTimeout': 240,
        'appium:autoGrantPermissions': true
    }],
    
    // ===================
    // Test Configurations
    // ===================
    logLevel: 'info',
    bail: 0,
    baseUrl: '',
    waitforTimeout: 10000,
    connectionRetryTimeout: 120000,
    connectionRetryCount: 3,
    
    services: [
        ['appium', {
            args: {
                address: 'localhost',
                port: 4723,
                relaxedSecurity: true
            },
            logPath: './logs/'
        }]
    ],
    
    framework: 'mocha',
    reporters: [
        ['spec', {
            showPreface: false
        }]
    ],
    
    // =====
    // Hooks
    // =====
    /**
     * Gets executed once before all workers get launched.
     */
    onPrepare: function (config, capabilities) {
        console.log('Starting Appium tests for Laza E-commerce App');
    },
    
    /**
     * Gets executed before a worker process is spawned.
     */
    onWorkerStart: function (cid, caps, specs, args, execArgv) {
        // console.log('Worker started');
    },
    
    /**
     * Gets executed before test execution begins.
     */
    before: async function (capabilities, specs) {
        // Set implicit wait
        await driver.setImplicitTimeout(5000);
    },
    
    /**
     * Gets executed after all tests are done.
     */
    after: async function (result, capabilities, specs) {
        // Clean up if needed
        if (result === 0) {
            console.log('All tests passed!');
        } else {
            console.log('Some tests failed.');
        }
    },
    
    /**
     * Gets executed after all workers have shut down.
     */
    onComplete: function(exitCode, config, capabilities, results) {
        console.log('Test execution completed');
    },
    
    // ========
    // Services
    // ========
    
    // Options for mocha
    mochaOpts: {
        ui: 'bdd',
        timeout: 90000,
        require: ['@babel/register']
    }
};
