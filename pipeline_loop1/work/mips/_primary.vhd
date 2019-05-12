library verilog;
use verilog.vl_types.all;
entity mips is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        reg_sel         : in     vl_logic_vector(4 downto 0);
        reg_data        : in     vl_logic_vector(31 downto 0)
    );
end mips;
