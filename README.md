# bhpEssentials

DegenToken is an ERC20 token contract deployed on the Avalanche network's Fuji testnet. It is designed to be a utility token for a hypothetical automotive parts marketplace, allowing users to earn, spend, and burn tokens based on their interactions within the platform.
## Description
I have used the mapping function, this function assigns 10 quantities to each part in my store. Its reduces one part as and whe the user inputs the corresponding part id.
Minting: The contract owner can mint new tokens and distribute them to specific accounts.
Redeeming: Users can redeem tokens for specific automotive parts listed in the contract's inventory. To redeem, users must have a sufficient balance and specify the part ID they wish to redeem.
Burning: Both the contract owner and users can burn tokens, reducing the total supply.
Transfer: Users can transfer tokens to other addresses.
## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., DegenToken.sol). Copy and paste the following code into the file:

```javascript
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
```


To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.9" (or another compatible version), and then click on the "Compile DegenToken.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken" contract from the dropdown menu, and then click on the "Deploy" button.

contract deployment:
```
npx hardhat run/scripts/deploy.js --network fuji
```

contract verification:
```
npx hardhat verify {address} --network fuji
```

## Inventory
The contract's inventory currently includes the following parts:

Brake Pads
Rotors
Brake Fluid
Calipers
Pistons

## Usage
Minting: To mint new tokens, call the mint function with the recipient's address and the amount to mint.

Redeeming: To redeem tokens, call the redeem function with the ID of the part you wish to redeem. Parts are numbered from 1 to 5, corresponding to brake pads, rotors, brake fluid, calipers, and pistons, respectively. Users must have at least 2500 tokens per part.

Burning: To burn tokens, call the burn function with the amount of tokens to burn.

Transferring: To transfer tokens, call the transfer function with the recipient's address and the amount of tokens to transfer.

## Authors

Joel Sebastian
j0els3bstian@gmail.com

## License

This project is licensed under the [MIT] License - see the LICENSE.md file for details
