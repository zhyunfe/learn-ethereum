pragma solidity ^0.4.19;
/**
僵尸工场
 */
contract ZombieFactory {
    // 定义DNA的由一个十六位数字
    uint dnaDigits = 16;
    // 为了保证唯一性，我们先造一个数据，是10^16，后面通过取模计算让他变成16位数字哦
    uint dnaModulus = 10 ** dnaDigits;
    /**
     * 定义一个事件，用来创建僵尸时被监听到
     * zombieId uint 僵尸的索引位置
     * name string 僵尸的名字
     * dna 僵尸的dna
     */
    event NewZombie(uint zombieId, string name, uint dna);
    // 我们定义一个僵尸的结构体，相当于PHP里的类对象
    struct Zombie {
        // 定义名字
        string name;
        // 定义DNA
        uint dna;
    }
    // 我们定义一个动态数组zombies，用来存放僵尸结构体 这个数组是公共的 创建后Solidity会自动创建getter方法
    Zombie[] public zombies;

    /**
     * 创建僵尸，这是一个私有方法
     * _name string 僵尸的名字
     * _dna uint 僵尸的DNA
     */
    function _createZombie(string _name, uint _dna) private {
        // 将一个新的僵尸结构体放入数组，并且将返回的数组长度 - 1 得到该僵尸在数组中的索引位置
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // 当创建了一个僵尸后触发事件
        NewZombie(id, _name, _dna);
    }
    /**
     * 私有方法
     * 这个函数不访问应用里的数据，所以使用view
     * 如果不访问应用的状态，使用pure
     * 生成随机DNA的方法
     * _str 传入的任意字符串
     * return 返回一个uint的DNA
     */
    function _generateRandDna(string _str) private view returns (uint) {
        // 通过keccak256散列函数生成一个256位的16进制数字，然后转换为uint类型
        uint rand = uint(keccak256(_str));
        // 通过随机值 取模 得到一个16位的DNA 返回
        return rand % dnaModulus;
    }
    /**
     * 公共 函数
     * 创建一个僵尸
     */
    function createRandomZombie(string _name) public {
        // 先生成DNA
        uint randDna = _generateRandDna(_name);
        // 创建僵尸，并触发事件
        _createZombie(_name, randDna);
    }
}