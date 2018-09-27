App = {
    // 属性  web3Provider
    web3Provider: null,
    // 合约 
    contracts: {},
    // 初始应用
    init: function() {
        App.reporter('初始化应用...');
        return App.initWeb3();
    },
    // 初始化web3
    initWeb3: function() {
        App.reporter('正在初始化web3 ...');
        if (typeof web3 !== 'undefined') {
            App.web3Provider = web3.currentProvider;
        } else {
            App.web3Provider = new Web3.providers.HttpProvider('http://127.0.0.1:9999');
        }
        web3 = new Web3(App.web3Provider);
        App.reporter('初始化web3完成...');
        return App.initContract();
        // return App.initZombie();
    },
    initZombie: function() {
        // Here's how we would access our contract:
        var abi = [{
            "constant": true,
            "inputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "name": "zombies",
            "outputs": [
              {
                "name": "name",
                "type": "string"
              },
              {
                "name": "dna",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": false,
                "name": "zombieId",
                "type": "uint256"
              },
              {
                "indexed": false,
                "name": "name",
                "type": "string"
              },
              {
                "indexed": false,
                "name": "dna",
                "type": "uint256"
              }
            ],
            "name": "NewZombie",
            "type": "event"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "_name",
                "type": "string"
              }
            ],
            "name": "createRandomZombie",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          }
        ];
        var ZombieFactoryContract = web3.eth.contract(abi)
        var contractAddress = '0xef07134ed823ceb8f54189d7c334f2619b10c3a7'
        var ZombieFactory = ZombieFactoryContract.at(contractAddress)
        $(".create").click(function(e) {
        var name = $("#zombie").val()
        // Call our contract's `createRandomZombie` function:
        ZombieFactory.createRandomZombie(name)
        })

        // Listen for the `NewZombie` event, and update the UI
        var event = ZombieFactory.NewZombie(function(error, result) {
        if (error) return
        console.log(result);
        // generateZombie(result.zombieId, result.name, result.dna)
        })

    },
    // 初始化合约
    initContract: function() {
        App.reporter('获取合约数据Json...');
        // 获取合约数据
        $.getJSON('ZombieFactory.json', function(data) {
            console.log(data);
            var ZombieFactoryArtifact = data;
            App.contracts.ZombieFactory = TruffleContract(ZombieFactoryArtifact);
            App.contracts.ZombieFactory.setProvider(App.web3Provider);
        })
        return App.bindEvents();
    },

    bindEvents: function() {
        $(document).on('click', '.create', App.handleCreate);
    },

    handleCreate: function (event) {
        event.preventDefault();
        console.log(event);
        App.reporter('创建僵尸...');
        var zombieFactoryInstance;
        var name = $('#zombie').val();
        $('#name').text(name);
        App.reporter('获取僵尸名称');
        web3.eth.getAccounts(function(error, account) {
            if (error) {
                console.log(error);
            }

            var account = account[0];
            App.reporter('获取账户');
            $('#account').text(account);
            App.reporter('部署合约');
            App.contracts.ZombieFactory.deployed().then(function(instance) {
                App.reporter('部署合约成功，获取实例ABI');
                zombieFactoryInstance = instance;
                console.log(instance);
                $('#address').text(instance.address);
                App.reporter('创建僵尸...');
                zombieFactoryInstance.createRandomZombie(name);
                zombieFactoryInstance.NewZombie(function(error, result) {
                    console.log(result);
                    App.reporter('ID:' + result.args['zombieId']);
                    App.reporter('NAME:' + result.args['name']);
                    App.reporter('DNA:' + result.args['dna']);
                    $('#title').text(result.args['name']);
                    $('#dna').text(result.args['dna']);
                    $('#id').text(result.args['zombieId']);
                });
              
            })
            
        })

    },
    reporter: function(msg) {
        $('.reporter').append('<div>' + msg + '</div>');
    },
    console: function(msg) {
        $('#footer').append('div' + msg + '</div>');
    }
}
$(function() {
    $(window).load(function() {
        App.init();
    });
});