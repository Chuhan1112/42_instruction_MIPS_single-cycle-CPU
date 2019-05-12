library verilog;
use verilog.vl_types.all;
entity IFID is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IFflush         : in     vl_logic;
        install         : in     vl_logic_vector(1 downto 0);
        instri1         : in     vl_logic_vector(31 downto 0);
        PC4i1           : in     vl_logic_vector(31 downto 0);
        instro1         : out    vl_logic_vector(31 downto 0);
        PC4o1           : out    vl_logic_vector(31 downto 0)
    );
end IFID;
