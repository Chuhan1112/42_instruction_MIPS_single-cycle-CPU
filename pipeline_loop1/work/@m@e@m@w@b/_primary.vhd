library verilog;
use verilog.vl_types.all;
entity MEMWB is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PC4i4           : in     vl_logic_vector(31 downto 0);
        MemReslti4      : in     vl_logic_vector(31 downto 0);
        ALUReslti4      : in     vl_logic_vector(63 downto 0);
        WDSeli4         : in     vl_logic_vector(1 downto 0);
        RFWri4          : in     vl_logic;
        RDsti4          : in     vl_logic_vector(4 downto 0);
        MDIVi4          : in     vl_logic;
        MRi4            : in     vl_logic;
        PC4o4           : out    vl_logic_vector(31 downto 0);
        MemReslto4      : out    vl_logic_vector(31 downto 0);
        ALUReslto4      : out    vl_logic_vector(63 downto 0);
        WDSelo4         : out    vl_logic_vector(1 downto 0);
        RFWro4          : out    vl_logic;
        RDsto4          : out    vl_logic_vector(4 downto 0);
        MDIVo4          : out    vl_logic;
        MRo4            : out    vl_logic
    );
end MEMWB;
