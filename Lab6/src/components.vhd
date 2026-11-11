-------------------------------------------------------------------------------
-- Dr. Kaputa
-- components package
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package components is

  component calculator is
    port (
      clk           : in  std_logic; 
      reset         : in  std_logic;
      execute       : in  std_logic;
      switch        : in  std_logic_vector(7 downto 0);
      op            : in  std_logic_vector(1 downto 0);
      led           : out std_logic_vector(2 downto 0);
      bcd_0         : out std_logic_vector(6 downto 0);
      bcd_1         : out std_logic_vector(6 downto 0);
      bcd_2         : out std_logic_vector(6 downto 0)
    );
  end component;

  component double_dabble is
    port (
      binary_in       : in std_logic_vector(11 downto 0);
      ones            : out std_logic_vector(3 downto 0);
      tens            : out std_logic_vector(3 downto 0);
      hundreds        : out std_logic_vector(3 downto 0);
      thousands       : out std_logic_vector(3 downto 0)
    );  
  end component;  

  component alu is
    port (
      reset         : in  std_logic;
      a             : in  std_logic_vector(7 downto 0); 
      b             : in  std_logic_vector(7 downto 0);
      op            : in  std_logic_vector(1 downto 0); -- 00: add, 01: sub, 10: mult, 11: div
      result        : out std_logic_vector(7 downto 0)
    );  
  end component; 

  component memory is 
    generic (addr_width : integer := 2;
            data_width : integer := 4);
    port (
      clk               : in std_logic;
      we                : in std_logic;
      addr              : in std_logic_vector(addr_width - 1 downto 0);
      din               : in std_logic_vector(data_width - 1 downto 0);
      dout              : out std_logic_vector(data_width - 1 downto 0)
    );
  end component;

  component rising_edge_synchronizer is 
    port (
      clk               : in std_logic;
      reset             : in std_logic;
      input             : in std_logic;
      edge              : out std_logic
    );
  end component;
  
  component synchronizer_8bit is 
    port (
      clk               : in std_logic;
      reset             : in std_logic;
      async_in          : in std_logic_vector(7 downto 0);
      sync_out          : out std_logic_vector(7 downto 0)
    );
  end component;
  
  component seven_seg is
    port (
      bcd             : in std_logic_vector(3 downto 0);
      seven_seg_out   : out std_logic_vector(6 downto 0)
    );  
  end component;  
end components;