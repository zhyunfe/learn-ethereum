pragma solidity ^0.4.17;
contract Adoption{
    //save the address of adopters
    address[16] public adopters;
    
    // adopt pet
    function adopt(uint petId) public returns (uint) {
        //make sure the id under the array length
        require(petId >=0 && petId <= 15);
        //save the address of adopters
        adopters[petId] = msg.sender;
        return petId;
    }
    
    function getAdopters(uint petId) public returns(address){
        return adopters[petId];
    }
}

