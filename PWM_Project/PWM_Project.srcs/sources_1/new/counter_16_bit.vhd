----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2018 15:47:21
-- Design Name: 
-- Module Name: counter_4_bit - Behavioral
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
--use IEEE.numeric_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_16_bit is
  port (
    counter_in, RESET : in STD_LOGIC;
    counter_start : in STD_LOGIC_VECTOR(15 downto 0);
    counter_out : out STD_LOGIC_VECTOR(15 downto 0);
    pulse_out : out STD_LOGIC
  );
end counter_16_bit;

architecture Behavioral of counter_16_bit is
    signal count : STD_LOGIC_VECTOR(15 downto 0) := X"8000";
--    signal start : STD_LOGIC_VECTOR(15 downto 0) := counter_start;
--    signal test : STD_LOGIC_VECTOR(15 downto 0);

    begin
--    process (counter_start) is
--        begin
--        test <= counter_start;
--    end process;
    
    process (RESET, counter_in) is
        begin
        if (rising_edge(counter_in)) then
            if (RESET = '1' or count = X"0000") then
                pulse_out <= '1';
                count <= counter_start;
            else
                count <= count - X"1";
                pulse_out <= '0';
            end if;
        end if;
    end process;
    counter_out <= count;
end Behavioral;
