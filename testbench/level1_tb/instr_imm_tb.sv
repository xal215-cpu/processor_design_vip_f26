module instr_imm_tb;

    `include "tb_utils.svh"

    logic [31:0] instr;
    logic [31:0] imm;

    instr_imm dut (
        .instr(instr),
        .imm(imm)
    );

    initial begin

        // I-type: ADDI with immediate = 5
        instr = 32'h00500013;
        #1;
        `CHECK_EQ(imm, 32'd5, "ADDI immediate = 5");

        // I-type: ADDI with immediate = -1
        instr = 32'hFFF00013;
        #1;
        `CHECK_EQ(imm, 32'hFFFF_FFFF, "ADDI immediate = -1");

        // I-type shift: SLLI with shift amount = 3
        instr = 32'h00301013;
        #1;
        `CHECK_EQ(imm, 32'd3, "SLLI shift amount = 3");

        // I-type: LOAD with immediate = 12
        instr = 32'h00C00003;
        #1;
        `CHECK_EQ(imm, 32'd12, "LOAD immediate = 12");

        // I-type: JALR with immediate = -4
        instr = 32'hFFC00067;
        #1;
        `CHECK_EQ(imm, 32'hFFFF_FFFC, "JALR immediate = -4");

        // S-type: STORE with immediate = 12
        instr = 32'h00000623;
        #1;
        `CHECK_EQ(imm, 32'd12, "STORE immediate = 12");

        // S-type: STORE with immediate = -1
        instr = 32'hFE000FA3;
        #1;
        `CHECK_EQ(imm, 32'hFFFF_FFFF, "STORE immediate = -1");

        // B-type: BRANCH with immediate = 8
        instr = 32'h00000463;
        #1;
        `CHECK_EQ(imm, 32'd8, "BRANCH immediate = 8");

        // B-type: BRANCH with immediate = -4
        instr = 32'hFE000EE3;
        #1;
        `CHECK_EQ(imm, 32'hFFFF_FFFC, "BRANCH immediate = -4");

        // U-type: LUI
        instr = 32'h12345037;
        #1;
        `CHECK_EQ(imm, 32'h12345000, "LUI immediate");

        // U-type: AUIPC
        instr = 32'hABCDE017;
        #1;
        `CHECK_EQ(imm, 32'hABCDE000, "AUIPC immediate");

        // J-type: JAL with immediate = 16
        instr = 32'h0100006F;
        #1;
        `CHECK_EQ(imm, 32'd16, "JAL immediate = 16");

        // J-type: JAL with immediate = -2
        instr = 32'hFFFFF06F;
        #1;
        `CHECK_EQ(imm, 32'hFFFF_FFFE, "JAL immediate = -2");

        // Unsupported opcode
        instr = 32'h00000000;
        #1;
        `CHECK_EQ(imm, 32'd0, "Unknown opcode returns 0");

        `TB_FINISH;
    end

endmodule
