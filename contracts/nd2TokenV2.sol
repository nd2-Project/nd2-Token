// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

import "./utils/Context.sol";
import "./access/AccessControl.sol";
import "./token/BEP20/BEP20Capped.sol";
import "./token/BEP20/BEP20Burnable.sol";
import "./token/BEP20/BEP20Pausable.sol";

/**
 * @dev The nd2 Token Contract.
 */
contract nd2Token is Context, AccessControl, BEP20Capped, BEP20Burnable, BEP20Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    constructor()
        public 
        BEP20("nd2 Token", "ND2")    // In line defined parameters
        BEP20Capped(21e24)           // Max. 21 million of nd2 Token
        {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

        _setupRole(MINTER_ROLE, _msgSender());
        _setupRole(PAUSER_ROLE, _msgSender());
    }

    function mint(address account, uint256 amount) public virtual {
        require(hasRole(MINTER_ROLE, _msgSender()), "ND2-BEP20: must have minter role to mint");
        _mint(account, amount);
    }

    /**
    * @dev functions for pause/unpause all token transfers. Minting included.
    * NOTE: The caller must have the `PAUSER_ROLE`.
    */

    function pause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "ND2-BEP20: must have pauser role to pause");
        _pause();
    }

    function unpause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "ND2-BEP20: must have pauser role to unpause");
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(BEP20, BEP20Capped, BEP20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
    }
}
