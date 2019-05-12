library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        rst             : in     vl_logic;
        A               : in     vl_logic_vector(31 downto 0);
        A2              : in     vl_logic_vector(31 downto 0);
        IMM             : in     vl_logic_vector(31 downto 0);
        ALUSrc          : in     vl_logic;
        ALUOp           : in     vl_logic_vector(4 downto 0);
        C               : out    vl_logic_vector(63 downto 0);
        Compare         : out    vl_logic
    );
end alu;
