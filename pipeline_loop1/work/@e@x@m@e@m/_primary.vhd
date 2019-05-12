library verilog;
use verilog.vl_types.all;
entity EXMEM is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PC4i3           : in     vl_logic_vector(31 downto 0);
        ALUReslti3      : in     vl_logic_vector(63 downto 0);
        RD2i3           : in     vl_logic_vector(31 downto 0);
        BSeli3          : in     vl_logic_vector(1 downto 0);
        MSeli3          : in     vl_logic_vector(2 downto 0);
        DMWri3          : in     vl_logic;
        WDSeli3         : in     vl_logic_vector(1 downto 0);
        RFWri3          : in     vl_logic;
        RDsti3          : in     vl_logic_vector(4 downto 0);
        MDIVi3          : in     vl_logic;
        MRi3            : in     vl_logic;
        PC4o3           : out    vl_logic_vector(31 downto 0);
        ALUReslto3      : out    vl_logic_vector(63 downto 0);
        RD2o3           : out    vl_logic_vector(31 downto 0);
        BSelo3          : out    vl_logic_vector(1 downto 0);
        MSelo3          : out    vl_logic_vector(2 downto 0);
        DMWro3          : out    vl_logic;
        WDSelo3         : out    vl_logic_vector(1 downto 0);
        RFWro3          : out    vl_logic;
        RDsto3          : out    vl_logic_vector(4 downto 0);
        MDIVo3          : out    vl_logic;
        MRo3            : out    vl_logic
    );
end EXMEM;
