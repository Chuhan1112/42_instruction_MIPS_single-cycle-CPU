library verilog;
use verilog.vl_types.all;
entity EXT is
    port(
        rst             : in     vl_logic;
        Instr           : in     vl_logic_vector(31 downto 0);
        EXTOp           : in     vl_logic_vector(1 downto 0);
        Imm             : out    vl_logic_vector(31 downto 0)
    );
end EXT;
