// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Faucet is Ownable {

    ERC20 public token;

    struct Airdrop {
        address claimer;
        uint256 lastTimeClaimed;
    }

    event tokenAirdropped(address indexed claimer, uint256 claimTime);
    mapping ( address => Airdrop ) private tokensDroped;


    constructor(ERC20 _token) {
        require(address(_token) != address(0), "Token address can't be address zero");
        token = _token;
    }

    function depositToken(uint256 amount_) public {
        require(token.transferFrom(msg.sender, address(this), amount_), "Transaction Failed!");
    }

    function claimTokens() public {
        require( currentTime() > tokensDroped[msg.sender].lastTimeClaimed + 86400, 'User claimed less than 24hrs ago');
        
        Airdrop memory _airdrop = Airdrop({
            claimer: msg.sender, 
            lastTimeClaimed: currentTime()
        });

        tokensDroped[msg.sender] = _airdrop;

        require(token.transfer(msg.sender, 50 ether), "Token Transfer Failed!");
        emit tokenAirdropped(msg.sender, _airdrop.lastTimeClaimed);
    }

    function currentTime() private view returns (uint256) {
        return block.timestamp;
    }
}