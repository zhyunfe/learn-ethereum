pragma solidity ^0.4.17;

import "truffle/Assert.sol";//引入断言
import "truffle/DeployedAddresses.sol";//用来获取被测试合约的地址
import "../contracts/Adoption.sol";//被测试合约

contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption());

  function testUserCanAdoptPet() public {
    uint returnedId = adoption.adopt(8);

    uint expected = 8;

    Assert.equal(returnedId, expected, "Adoption of pet ID 8 should be recorded");
  }


  function testGetAdopterAddressByPetId() public {
    address expected = this;
    address adopter = adoption.adopters(8);
    Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded");
  }


  function testGetAdopterAddressByPetIdInArray() public {
    address expected = this;
    address[16] memory adopters = adoption.getAdopters();
    Assert.equal(adopters[8],expected, "Owner of pet ID 8 should be recorded");
  }
}
