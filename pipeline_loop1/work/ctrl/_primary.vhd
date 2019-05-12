library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Instr           : in     vl_logic_vector(31 downto 0);
        ALUSrc          : out    vl_logic;
        EXTOp           : out    vl_logic_vector(1 downto 0);
        ALUOp           : out    vl_logic_vector(4 downto 0);
        NPCOp           : out    vl_logic_vector(1 downto 0);
        BSel            : out    vl_logic_vector(1 downto 0);
        MSel            : out    vl_logic_vector(2 downto 0);
        DMWr            : out    vl_logic;
        WDSel           : out    vl_logic_vector(1 downto 0);
        RFWr            : out    vl_logic;
        RDst            : out    vl_logic_vector(4 downto 0);
        MDIV            : out    vl_logic;
        MR              : out    vl_logic
    );
end ctrl;
