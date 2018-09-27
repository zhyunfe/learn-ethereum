App = {

    web3Provider: null,
    run: function() {
        var Web3 = require('web3');
        App.web3Provider = new Web3(Web3.givenProvider);
        console.log(App.web3Provider);
    }
}

$(function() {
    $(window).load(function() {
        App.run();
    })
});