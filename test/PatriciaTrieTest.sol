pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/PatriciaTrie.sol";

contract PatriciaTrieTest {
    PatriciaTrie instance;

    constructor() public {
        instance = PatriciaTrie(DeployedAddresses.PatriciaTrie());
    }

    function testVerifyNestedNodes() returns (bool) {
        bytes32 rootHash = 0xda2e968e25198a0a41e4dcdc6fcb03b9d49274b3d44cb35d921e4ebe3fb5c54c;

        bytes memory path = hex"61";
        bytes memory value = hex"857465737431";
        bytes memory nodes = hex"f83bf839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080";

        Assert.isTrue( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );

        path = hex"826162";
        value = hex"74";
        nodes = hex"f87ff839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080f8428080c58320616274cc842061626386857465737433a05d495bd9e35ab0dab60dec18b21acc860829508e7df1064fce1f0b8fa4c0e8b2808080808080808080808080";

        Assert.isTrue( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );

        path = hex"83616263";
        value = hex"857465737433";
        nodes = hex"f87ff839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080f8428080c58320616274cc842061626386857465737433a05d495bd9e35ab0dab60dec18b21acc860829508e7df1064fce1f0b8fa4c0e8b2808080808080808080808080";

        Assert.isTrue( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );

        path = hex"8461626564";
        value = hex"857465737435";
        nodes = hex"f8cbf839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080f8428080c58320616274cc842061626386857465737433a05d495bd9e35ab0dab60dec18b21acc860829508e7df1064fce1f0b8fa4c0e8b2808080808080808080808080e583161626a06b1a1127b4c489762c8259381ff9ecf51b7ef0c2879b89e72c993edc944f1ccce5808080ca8220648685746573743480ca822064868574657374358080808080808080808080";

        Assert.isTrue( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );

        path = hex"8461626364";
        value = hex"857465737434";
        nodes = hex"f8cbf839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080f8428080c58320616274cc842061626386857465737433a05d495bd9e35ab0dab60dec18b21acc860829508e7df1064fce1f0b8fa4c0e8b2808080808080808080808080e583161626a06b1a1127b4c489762c8259381ff9ecf51b7ef0c2879b89e72c993edc944f1ccce5808080ca8220648685746573743480ca822064868574657374358080808080808080808080";

        Assert.isTrue( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );
    }

    function failVerifyNestedNodes() returns (bool) {
        bytes32 rootHash = 0xda2e968e25198a0a41e4dcdc6fcb03b9d49274b3d44cb35d921e4ebe3fb5c54c;

        bytes memory path = hex"62";
        bytes memory value = hex"857465737431";
        bytes memory nodes = hex"f83bf839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080";

        Assert.isFalse( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );

        path = hex"826163";
        value = hex"75";
        nodes = hex"f87ff839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080f8428080c58320616274cc842061626386857465737433a05d495bd9e35ab0dab60dec18b21acc860829508e7df1064fce1f0b8fa4c0e8b2808080808080808080808080";

        Assert.isFalse( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );

        path = hex"83616263";
        value = hex"857465737434";
        nodes = hex"f87ff839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080f8428080c58320616274cc842061626386857465737433a05d495bd9e35ab0dab60dec18b21acc860829508e7df1064fce1f0b8fa4c0e8b2808080808080808080808080";

        Assert.isFalse( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );

        path = hex"8461626564";
        value = hex"857465737435";
        nodes = hex"f8cbf839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080f8428080c58320616274cc842061626386857465737433a05d495bd9e35ab0dab60dec18b21acc860829508e7df1064fce1f0b8fa4c0e8b2808080808080808080808080e583161626a06b1a1127b4c489762c8259381ff9ecf51b7ef0c2879b89e72c993edc944f1ccce5808080ca8220648685746573743480ca822064868574657374358080808080808080808085";

        Assert.isFalse( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );

        path = hex"8461626364";
        value = hex"857465737435";
        nodes = hex"f8cbf839808080808080c8318685746573743180a0207947cf85c03bd3d9f9ff5119267616318dcef0e12de2f8ca02ff2cdc720a978080808080808080f8428080c58320616274cc842061626386857465737433a05d495bd9e35ab0dab60dec18b21acc860829508e7df1064fce1f0b8fa4c0e8b2808080808080808080808080e583161626a06b1a1127b4c489762c8259381ff9ecf51b7ef0c2879b89e72c993edc944f1ccce5808080ca8220648685746573743480ca822064868574657374358080808080808080808080";

        Assert.isFalse( PatriciaTrie.verifyProof(value, nodes, path, rootHash), "PatriciaTrie verify failed" );
    }
}
