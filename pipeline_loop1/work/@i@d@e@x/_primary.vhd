library verilog;
use verilog.vl_types.all;
entity IDEX is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        instal          : in     vl_logic_vector(1 downto 0);
        PC4i2           : in     vl_logic_vector(31 downto 0);
        RD1i2           : in     vl_logic_vector(31 downto 0);
        RD2i2           : in     vl_logic_vector(31 downto 0);
        IMMi2           : in     vl_logic_vector(31 downto 0);
        ALUSrci2        : in     vl_logic;
        ALUOpi2         : in     vl_logic_vector(4 downto 0);
        NPCOpi2         : in     vl_logic_vector(1 downto 0);
        BSeli2          : in     vl_logic_vector(1 downto 0);
        MSeli2          : in     vl_logic_vector(2 downto 0);
        DMWri2          : in     vl_logic;
        WDSeli2         : in     vl_logic_vector(1 downto 0);
        RFWri2          : in     vl_logic;
        RDsti2          : in     vl_logic_vector(4 downto 0);
        MDIVi2          : in     vl_logic;
        MRi2            : in     vl_logic;
        PC4o2           : out    vl_logic_vector(31 downto 0);
        RD1o2           : out    vl_logic_vector(31 downto 0);
        RD2o2           : out    vl_logic_vector(31 downto 0);
        IMMo2           : out    vl_logic_vector(31 downto 0);
        ALUSrco2        : out    vl_logic;
        ALUOpo2         : out    vl_logic_vector(4 downto 0);
        NPCOpo2         : out    vl_logic_vector(1 downto 0);
        BSelo2          : out    vl_logic_vector(1 downto 0);
        MSelo2          : out    vl_logic_vector(2 downto 0);
        DMWro2          : out    vl_logic;
        WDSelo2         : out    vl_logic_vector(1 downto 0);
        RFWro2          : out    vl_logic;
        RDsto2          : out    vl_logic_vector(4 downto 0);
        MDIVo2          : out    vl_logic;
        MRo2            : out    vl_logic
    );
end IDEX;
