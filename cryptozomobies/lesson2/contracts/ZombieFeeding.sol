pragma solidity ^0.4.19;

// 引入父类文件
import "./ZombieFactory.sol";
// 引用接口
contract KittyInterface {
    // 要使用接口的方法    
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 stringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes);
}
// 饲养僵尸的合约
contract ZombieFeeding is ZombieFactory {
    // Kitty接口的合约地址
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // 初始化kitty合约
    KittyInterface kittyContract = KittyInterface(ckAddress);
    // 饲养 
    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
        // 要求饲养的僵尸是自己的
        require(msg.sender == zombieToOwner[_zombieId]);
        // 将僵尸存储在storage中
        Zombie storage myZombie = zombies[_zombieId];
        // 获取到被饲养的DNA
        _targetDna = _targetDna % dnaModulus;
        // 生成新的DNA  
        uint newDna = (myZombie.dna + _targetDna) / 2;
        // 如果是猫的话，DNA + 99
        if (keccak256(_species) == keccak256("kitty")) {
            newDna = newDna - newDna % 100 + 99;
        }
        // 养成一个新的僵尸
        _createZombie("NoName", newDna);
    }
    // 外部接口
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

}
