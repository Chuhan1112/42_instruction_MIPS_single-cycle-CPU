library verilog;
use verilog.vl_types.all;
entity dm_4k is
    port(
        C               : in     vl_logic_vector(63 downto 0);
        din             : in     vl_logic_vector(31 downto 0);
        be              : in     vl_logic_vector(1 downto 0);
        DMWr            : in     vl_logic;
        rst             : in     vl_logic;
        dout            : out    vl_logic_vector(31 downto 0)
    );
end dm_4k;
