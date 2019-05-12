library verilog;
use verilog.vl_types.all;
entity fctrl is
    port(
        rst             : in     vl_logic;
        NPCOp           : in     vl_logic_vector(1 downto 0);
        Instr           : in     vl_logic_vector(31 downto 0);
        RDst            : in     vl_logic_vector(4 downto 0);
        RDst2           : in     vl_logic_vector(4 downto 0);
        RDst3           : in     vl_logic_vector(4 downto 0);
        RFWr            : in     vl_logic;
        RFWr2           : in     vl_logic;
        RFWr3           : in     vl_logic;
        MR              : in     vl_logic;
        MR2             : in     vl_logic;
        MR3             : in     vl_logic;
        DD1             : in     vl_logic_vector(31 downto 0);
        DD2             : in     vl_logic_vector(31 downto 0);
        ALUReslt        : in     vl_logic_vector(63 downto 0);
        ALUReslt2       : in     vl_logic_vector(63 downto 0);
        MemReslt        : in     vl_logic_vector(31 downto 0);
        fRD1            : out    vl_logic_vector(31 downto 0);
        fRD2            : out    vl_logic_vector(31 downto 0);
        instal          : out    vl_logic_vector(1 downto 0)
    );
end fctrl;
