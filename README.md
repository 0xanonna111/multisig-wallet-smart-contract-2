# Multi-Signature (MultiSig) Wallet

A robust, minimal MultiSig wallet designed for collective asset management. This contract ensures that no single individual can move funds, providing a critical layer of security for DAO treasuries or shared project funds.

## Features
- **M-of-N Authorization**: Set a threshold of required signatures (e.g., 2-of-3 or 3-of-5).
- **Transaction Queue**: Proposals are stored on-chain until the threshold is met.
- **Revocable Approvals**: Owners can change their mind and revoke an approval before execution.
- **Native Asset Support**: Handles Ether (or native chain currency) transfers.

## How It Works
1. **Submit**: An owner submits a transaction proposal.
2. **Approve**: Other owners call `approveTransaction` to sign the proposal.
3. **Execute**: Once the `numConfirmations` equals the `threshold`, any owner can call `executeTransaction`.



## Development
- Compile: `forge build`
- Test: `forge test`
