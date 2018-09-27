var Migrations = artifacts.require("./Migrations.sol");
var ZombieFeeding = artifacts.require("./ZombieFeeding.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(ZombieFeeding);
};
