library verilog;
use verilog.vl_types.all;
entity NPC is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        instal          : in     vl_logic_vector(1 downto 0);
        PC              : in     vl_logic_vector(31 downto 0);
        NPCOp           : in     vl_logic_vector(1 downto 0);
        compare         : in     vl_logic;
        IMM             : in     vl_logic_vector(31 downto 0);
        RD1             : in     vl_logic_vector(31 downto 0);
        NPC             : out    vl_logic_vector(31 downto 0);
        IFflush         : out    vl_logic
    );
end NPC;
