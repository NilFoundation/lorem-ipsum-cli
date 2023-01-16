pragma solidity >=0.8.4;

import "../contracts/types.sol";
import "../contracts/basic_marshalling.sol";
import "../contracts/commitments/batched_lpc_verifier.sol";
import "./gate0.sol";
import "./gate1.sol";
import "./gate2.sol";
import "./gate3.sol";
import "./gate4.sol";
import "./gate5.sol";
import "./gate6.sol";
import "./gate7.sol";
import "./gate8.sol";
import "./gate9.sol";
import "./gate10.sol";
import "./gate11.sol";
import "./gate12.sol";

contract gate_argument_split_gen {
    uint256 constant WITNESSES_N = 15;
    uint256 constant SELECTOR_N = 20;
    uint256 constant PUBLIC_INPUT_N =5;
    uint256 constant GATES_N = 13;
    uint256 constant CONSTANTS_N = 5;

    function evaluate_gates_be(
        bytes calldata blob,
        types.gate_argument_local_vars memory gate_params,
        types.arithmetization_params memory ar_params,
        int256[][] memory columns_rotations
    ) external view returns (uint256 gates_evaluation) {

        gate_params.witness_evaluations = new uint256[][](WITNESSES_N);
        gate_params.offset = batched_lpc_verifier.skip_to_z(blob,  gate_params.eval_proof_witness_offset);
        for (uint256 i = 0; i < WITNESSES_N; i++) {
            gate_params.witness_evaluations[i] = new uint256[](columns_rotations[i].length);
            for (uint256 j = 0; j < columns_rotations[i].length; j++) {
                gate_params.witness_evaluations[i][j] = basic_marshalling.get_i_j_uint256_from_vector_of_vectors(blob, gate_params.offset, i, j);
            }
        }

        gate_params.selector_evaluations = new uint256[](GATES_N);
        gate_params.offset = batched_lpc_verifier.skip_to_z(blob,  gate_params.eval_proof_selector_offset);
        for (uint256 i = 0; i < GATES_N; i++) {
           gate_params.selector_evaluations[i] = basic_marshalling.get_i_j_uint256_from_vector_of_vectors(
                blob, 
                gate_params.offset, 
                i + ar_params.permutation_columns + ar_params.permutation_columns + ar_params.constant_columns, 
                0
            );
        }

        gate_params.constant_evaluations = new uint256[][](CONSTANTS_N);
        gate_params.offset = batched_lpc_verifier.skip_to_z(blob,  gate_params.eval_proof_constant_offset);
        for (uint256 i = 0; i < CONSTANTS_N; i++) {
            gate_params.constant_evaluations[i] = new uint256[](columns_rotations[i].length);
            for (uint256 j = 0; j < columns_rotations[i].length; j++) {
                gate_params.constant_evaluations[i][j] = basic_marshalling.get_i_j_uint256_from_vector_of_vectors(
                    blob, 
                    gate_params.offset, 
                    i + ar_params.permutation_columns + ar_params.permutation_columns, 
                    j
                );
            }
        }

        gate_params.theta_acc = 1;
        gate_params.gates_evaluation = 0;
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate0.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate1.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate2.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate3.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate4.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate5.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate6.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate7.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate8.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate9.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate10.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate11.evaluate_gate_be(gate_params, columns_rotations);
        (gate_params.gates_evaluation, gate_params.theta_acc) = gate12.evaluate_gate_be(gate_params, columns_rotations);
        gates_evaluation = gate_params.gates_evaluation;}}
