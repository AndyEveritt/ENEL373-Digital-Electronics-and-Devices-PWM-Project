----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2018 16:56:33
-- Design Name: 
-- Module Name: debounce - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
  Port ( reset : in STD_LOGIC;
         clk : in STD_LOGIC;
         but : in STD_LOGIC;
         but_debounce : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is

signal Q1, Q2, Q3 : std_logic;

begin
--  Provides a one-shot pulse from a non-clock input, with reset

process(clk)
begin
   if (rising_edge(clk)) then
      if (reset = '1') then
         Q1 <= '0';
         Q2 <= '0';
         Q3 <= '0';
      else
         Q1 <= but;
         Q2 <= Q1;
         Q3 <= Q2;
      end if;
   end if;
end process;

but_debounce <= Q1 and Q2 and (not Q3);

end Behavioral;
