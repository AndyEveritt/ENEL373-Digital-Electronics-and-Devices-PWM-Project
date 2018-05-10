----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2018 12:37:44
-- Design Name: 
-- Module Name: Finite_State_Machine - Behavioral
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

entity Finite_State_Machine is
    Port ( CLK, RESET : in std_logic;
           But : in std_logic;
           --Top_But : in std_logic; In case toggling between states is different
           State : out std_logic_vector(1 downto 0)
           );
end Finite_State_Machine;

architecture Behavioral of Finite_State_Machine is

type state_type is (s0, s1, s2, s3); --Four states

signal current_state, next_state : state_type;

begin

process (CLK)
begin
    if (rising_edge(CLK)) then
        current_state <= next_state;
    end if;
end process;

process (But)
begin
    if (rising_edge(CLK)) then
        case current_state is
            when s0 =>
                State <= "00";
                next_state <= s0;
            if (But = '1') then
                State <= "01";
                next_state <= s1;
            end if;
            
            when s1 =>
                State <= "01";
                next_state <= s1;
            if (But = '1') then
                State <= "11";
                next_state <= s2;
            end if;
            
            when s2 =>
                State <= "11";
                next_state <= s2;
            if (But = '1') then
                State <= "10";
                next_state <= s3;
            end if;
            
            when s3 =>
                State <= "10";
                next_state <= s3;
            if (But = '1') then
                State <= "00";
                next_state <= s0;
            end if;
        end case;
    end if;
end process;

end Behavioral;
