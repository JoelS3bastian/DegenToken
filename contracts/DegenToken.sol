// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    
    string public bhpEssentials; 

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        bhpEssentials="parts in my inventory are : 1.brakepads  2.rotors  3.brakefluid  4.calipers  5.pistons";
    }

    function mint(address bhp_account, uint256 bhpvalue) public onlyOwner {
        _mint(bhp_account, bhpvalue);
    }
    function redeem(uint256 part_id) public {
        assert(part_id >= 1 && part_id <= 5 && balanceOf(msg.sender) >= 2500); 
        _burn(msg.sender, 2500*part_id);
 
    }
     function burn(uint256 bhpvalue)public override{
        _burn(msg.sender, bhpvalue);
    }

    function transfer(address recepient,uint256 bhpvalue)public override returns(bool){
        _transfer(msg.sender, recepient, bhpvalue);
        return true;
    }
}
