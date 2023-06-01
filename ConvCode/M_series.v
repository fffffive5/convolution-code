module M_series
    (
        input wire      clk,
        input wire      rst_n,
        output wire     Q
    );
    parameter       len = 15;  // parameter range from 2 to 16
    reg[(len-1):0] Q_r;

    assign Q = Q_r[(len-1)];

    always @(posedge clk or negedge rst_n) begin

        if (rst_n == 0) begin  // negedge reset
            Q_r <= ~(0);
        end

        else begin
            Q_r <= Q_r<<1;  // shift reg
            case(len)
                2 : Q_r[0] <= Q_r[1]^Q_r[0];
                3 : Q_r[0] <= Q_r[2]^Q_r[1];
                4 : Q_r[0] <= Q_r[3]^Q_r[2];
                5 : Q_r[0] <= Q_r[4]^Q_r[2];
                6 : Q_r[0] <= Q_r[5]^Q_r[4];
                7 : Q_r[0] <= Q_r[6]^Q_r[3];
                8 : Q_r[0] <= Q_r[7]^Q_r[5]^Q_r[4]^Q_r[3];
                9 : Q_r[0] <= Q_r[8]^Q_r[4];
                10: Q_r[0] <= Q_r[9]^Q_r[6];
                11: Q_r[0] <= Q_r[10]^Q_r[8];
                12: Q_r[0] <= Q_r[11]^Q_r[10]^Q_r[7]^Q_r[5];
                13: Q_r[0] <= Q_r[12]^Q_r[11]^Q_r[9]^Q_r[8];
                14: Q_r[0] <= Q_r[13]^Q_r[12]^Q_r[7]^Q_r[3];
                15: Q_r[0] <= Q_r[14]^Q_r[13];
                16: Q_r[0] <= Q_r[15]^Q_r[14]^Q_r[12]^Q_r[3];
                default: Q_r[0] <= Q_r[0];
            endcase
        end

    end

endmodule