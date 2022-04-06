pragma solidity =0.6.6;
pragma experimental ABIEncoderV2;

import "./Distributor.sol";

contract InitializedDistributor is Distributor {
    struct Shareholder {
        address recipient;
        uint shares;
    }

    constructor(
        address gremlin_,
        address claimable_,
        bytes[] memory data
    ) public Distributor(gremlin_, claimable_) {
        uint _totalShares = 0;
        for (uint i = 0; i < data.length; i++) {
            Shareholder memory shareholder = abi.decode(data[i], (Shareholder));
            recipients[shareholder.recipient].shares = shareholder.shares;
            _totalShares = _totalShares.add(shareholder.shares);
        }
        totalShares = _totalShares;
    }
}
