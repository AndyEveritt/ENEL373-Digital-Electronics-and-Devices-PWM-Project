----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2018 15:33:42
-- Design Name: 
-- Module Name: 7_segment_counter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.numeric_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_counter is
    Port ( num : buffer STD_LOGIC_VECTOR (6 downto 0);
--           CA : out STD_LOGIC;
--           CB : out STD_LOGIC;
--           CC : out STD_LOGIC;
--           CD : out STD_LOGIC;
--           CE : out STD_LOGIC;
--           CF : out STD_LOGIC;
--           CG : out STD_LOGIC;
           segment7 : inout STD_LOGIC_VECTOR (7 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end segment_counter;

architecture Behavioral of segment_counter is

--signal segment7 : STD_LOGIC_VECTOR (6 downto 0);
signal CA : STD_LOGIC;
signal CB : STD_LOGIC;
signal CC : STD_LOGIC;
signal CD : STD_LOGIC;
signal CE : STD_LOGIC;
signal CF : STD_LOGIC;
signal CG : STD_LOGIC;

begin
    process(num)
    begin
        case num is
            when "0000" => segment7 <= "0000001";
            when "0001" => segment7 <= "1001111";
            when "0010" => segment7 <= "0010010";
            when "0011" => segment7 <= "0000110";
            when "0100" => segment7 <= "1001100";
            when "0101" => segment7 <= "0100100";
            when "0110" => segment7 <= "1100000";
            when "0111" => segment7 <= "0001111";
            when "1000" => segment7 <= "0000000";
            when "1001" => segment7 <= "0001100";
            when others => segment7 <= "1111111";
        end case;

    end process;

CA <= segment7(6);
CB <= segment7(5);
CC <= segment7(4);
CD <= segment7(3);
CE <= segment7(2);
CF <= segment7(1);
CG <= segment7(0);

AN <= "1111110";

end Behavioral;
