pragma circom 2.0.0;

include "./node_modules/keccak256-circom/circuits/keccak.circom";

template OwnershipVerifier(addressSize, pSize) {
    signal input address[addressSize];
    signal input p[pSize];
    signal concat[addressSize + pSize];
    signal output out[32*8];

    var j = 0;
    for ( var i = 0; i < addressSize; i++ ) {
        concat[j] <== address[i];
        j++;
    }

    for ( var i = 0; i < pSize; i++ ) {
        concat[j] <== p[i];
        j++;
    }

    component hash = Keccak(addressSize + pSize, 32*8);
    for ( var i = 0; i < addressSize + pSize; i++ ) {
        hash.in[i] <== concat[i];
    }

    for ( var i = 0; i < 32*8; i++ ) {
        out[i] <== hash.out[i];
    }
}

component main = OwnershipVerifier(20*8, 8);