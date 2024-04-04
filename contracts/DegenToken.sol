// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    mapping(uint256 => uint256) public numbers;
    string public bhpEssentials; 

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        bhpEssentials="parts in my inventory are : 1.brakepads  2.rotors  3.brakefluid  4.calipers  5.pistons";
        for(uint i=1;i<=5;i++)
        {
            numbers[i]=10;
        }
    }

    function mint(address bhp_account, uint256 bhpvalue) public onlyOwner {
        _mint(bhp_account, bhpvalue);
    }
    function redeem(uint256 part_id) public {
        assert(part_id >= 1 && part_id <= 5 && balanceOf(msg.sender) >= 2500);
        require(numbers[part_id]>0,"no items left"); 
        _burn(msg.sender, 2500*part_id);
        numbers[part_id]-=1;
    }
     function burn(uint256 bhpvalue)public override{
        _burn(msg.sender, bhpvalue);
    }

    function transfer(address recepient,uint256 bhpvalue)public override returns(bool){
        _transfer(msg.sender, recepient, bhpvalue);
        return true;
    }
}
