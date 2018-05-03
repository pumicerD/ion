## Copyright (c) 2016-2018 Clearmatics Technologies Ltd
## SPDX-License-Identifier: LGPL-3.0+

#!/usr/bin/env python
"""
API

Provides a set of endpoints from which users can derive the key information regarding proofs
which is required when withdrawing funds from IonLock
"""

from flask import Flask, request, jsonify

from ion.merkle import merkle_tree, merkle_path


app = Flask(__name__)

@app.route('/')

@app.route('/api/leaves', methods=['GET'])
def api_leaves():
    """Return all the leaves for the merkle tree"""
    byte_leaves = app.lithium.leaves
    hex_leaves = [x.encode('hex') for x in byte_leaves]
    dict = {u'leaves': hex_leaves}
    return jsonify(dict)

@app.route('/api/checkpoints', methods=['GET'])
def api_checkpoint():
    """Returns the checkpoints"""
    byte_checkpoints = app.lithium.checkpoints

    index_map = [column[0] for column in byte_checkpoints]
    blockid = [column[1] for column in byte_checkpoints]

    hex_blockid = [format(x, 'x') for x in blockid]

    dict = {u'index': index_map, u'blockId': hex_blockid}
    return jsonify(dict)

@app.route('/api/blockid', methods=['POST'])
def api_blockid():
    """If passed a valid leaf returns corresponding ionlink blockId"""
    if request.method == 'POST':
        leaf = request.args.get('leaf')

    byte_leaves = app.lithium.leaves
    byte_checkpoints = app.lithium.checkpoints


    hex_leaves = [x.encode('hex') for x in byte_leaves]
    idx = hex_leaves.index(leaf)
    output = None
    for value in byte_checkpoints:
        if idx >= value[0]:
            pass
        else:
            output = value[1]
            break

    dict = {u'blockId': str(output)}
    return jsonify(dict)

@app.route('/api/proof', methods=['POST'])
def api_proof():
    """If passed a valid leaf returns merkle proof"""
    if request.method == 'POST':
        leaf = request.args.get('leaf')

    tree, _ = merkle_tree(app.lithium.leaves)
    hex_leaf = leaf.decode('hex')

    path = merkle_path(hex_leaf, tree)
    string_path = [str(x) for x in path]
    dict = {u'proof': string_path}
    return jsonify(dict)