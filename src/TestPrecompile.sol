// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract TestPrecompile {
    function derive() public view returns (bytes memory) {
        bytes memory output;

        bytes memory args = hex"010000000c636169742d736974682d69640000002b4c49545f48445f4b45595f49445f4b3235365f584d443a5348412d3235365f535357555f524f5f4e554c5f0000000a020fae233d73b0d32dbbf10f0b942d869b45dd2856f7fcd9626f2d6e32ff2b0943033ce30488ede264ef6b358337b0ecfa556debfb2d04a9124609dc0b5feba816cb02e9d5169aef5e11bb12a6d74dd14a516975afb53be2771503d1797b1bcc5c05d203c5b60f0f896f154cd1a2a66213f6a60670a8753885dc498188ded2e795ffd35b022213cdaaad5188b94e9f381300facebf783775d3a39cf1940d14de09867b8f22034b0967f3f536549d4ed18424f615556cb0addd262b3a2beadb67a62459b44c9903fb7e452b1402623f0961e3c227de2e4a080102556f824debd0dc097127b77b8002a96816b6e92fddbc34ab5ce7b340c68701db544f3929f77e1563a34fb7d91c91035b52660671d8b6997b4088a0777d2c89132eab47146a4d692c4a82513893d3910234b3e7701907ff53cb3e48116319c1949709101dc6d9b55c54cfa2813e109a59";

        assembly {
            if iszero(
                // 0x10 for the precompile address
                // add(args, 32) for ???
                // 0x18E for the size of the input (398 bytes)
                // output for the output
                // 0x21 for the size of the output flag (33 byte)
                staticcall(not(0), 0x10, add(args, 32), 0x18E, output, 0x21)
            ) {
                revert(0, 0)
            }
        }

        return output;
    }

    function derive2() public view returns (bytes memory) {
        address precompile = 0x0000000000000000000000000000000000000100;

        bytes memory args = hex"010000000c636169742d736974682d69640000002b4c49545f48445f4b45595f49445f4b3235365f584d443a5348412d3235365f535357555f524f5f4e554c5f0000000a020fae233d73b0d32dbbf10f0b942d869b45dd2856f7fcd9626f2d6e32ff2b0943033ce30488ede264ef6b358337b0ecfa556debfb2d04a9124609dc0b5feba816cb02e9d5169aef5e11bb12a6d74dd14a516975afb53be2771503d1797b1bcc5c05d203c5b60f0f896f154cd1a2a66213f6a60670a8753885dc498188ded2e795ffd35b022213cdaaad5188b94e9f381300facebf783775d3a39cf1940d14de09867b8f22034b0967f3f536549d4ed18424f615556cb0addd262b3a2beadb67a62459b44c9903fb7e452b1402623f0961e3c227de2e4a080102556f824debd0dc097127b77b8002a96816b6e92fddbc34ab5ce7b340c68701db544f3929f77e1563a34fb7d91c91035b52660671d8b6997b4088a0777d2c89132eab47146a4d692c4a82513893d3910234b3e7701907ff53cb3e48116319c1949709101dc6d9b55c54cfa2813e109a59";

        (bool success, bytes memory data) = precompile.staticcall(args);

        if (success) {
            return data;
        } else {
            return hex"1234";
        }
    }
}
