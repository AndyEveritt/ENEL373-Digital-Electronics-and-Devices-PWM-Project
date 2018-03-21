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
--use IEEE.numeric_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_counter is
    Port ( 
    num : in STD_LOGIC_VECTOR(3 downto 0);
    CA : out STD_LOGIC;
    CB : out STD_LOGIC;
    CC : out STD_LOGIC;
    CD : out STD_LOGIC;
    CE : out STD_LOGIC;
    CF : out STD_LOGIC;
    CG : out STD_LOGIC;
--    AN_in : in STD_LOGIC_VECTOR(7 downto 0);
    AN : out STD_LOGIC_VECTOR(7 downto 0)
    );
end segment_counter;

architecture Behavioral of segment_counter is

signal segment7 : STD_LOGIC_VECTOR (6 downto 0);
--signal CA : STD_LOGIC;
--signal CB : STD_LOGIC;
--signal CC : STD_LOGIC;
--signal CD : STD_LOGIC;
--signal CE : STD_LOGIC;
--signal CF : STD_LOGIC;
--signal CG : STD_LOGIC;

begin
    process(num)
    begin
        case num is
            when X"0" => segment7 <= "0000001";
            when X"1" => segment7 <= "1001111";
            when X"2" => segment7 <= "0010010";
            when X"3" => segment7 <= "0000110";
            when X"4" => segment7 <= "1001100";
            when X"5" => segment7 <= "0100100";
            when X"6" => segment7 <= "1100000";
            when X"7" => segment7 <= "0001111";
            when X"8" => segment7 <= "0000000";
            when X"9" => segment7 <= "0001100";
            when X"A" => segment7 <= "0001000";
            when X"B" => segment7 <= "0000000";
            when X"C" => segment7 <= "0110001";
            when X"D" => segment7 <= "0000001";
            when X"E" => segment7 <= "0110000";
            when X"F" => segment7 <= "0111000";
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

AN <= "11111110";

end Behavioral;