library verilog;
use verilog.vl_types.all;
entity RegWrData is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ALURslt         : in     vl_logic_vector(63 downto 0);
        MemRslt         : in     vl_logic_vector(31 downto 0);
        PC              : in     vl_logic_vector(31 downto 0);
        WDSel           : in     vl_logic_vector(1 downto 0);
        RWD             : out    vl_logic_vector(63 downto 0);
        RDstp           : in     vl_logic_vector(4 downto 0);
        RDst            : out    vl_logic_vector(4 downto 0);
        RFWrp           : in     vl_logic;
        RFWr            : out    vl_logic;
        MDIVp           : in     vl_logic;
        MDIV            : out    vl_logic
    );
end RegWrData;
