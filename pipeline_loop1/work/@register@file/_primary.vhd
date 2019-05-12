library verilog;
use verilog.vl_types.all;
entity RegisterFile is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Instr           : in     vl_logic_vector(31 downto 0);
        WDst            : in     vl_logic_vector(4 downto 0);
        WData           : in     vl_logic_vector(63 downto 0);
        MDIV            : in     vl_logic;
        RFWr            : in     vl_logic;
        RD1             : out    vl_logic_vector(31 downto 0);
        RD2             : out    vl_logic_vector(31 downto 0)
    );
end RegisterFile;
