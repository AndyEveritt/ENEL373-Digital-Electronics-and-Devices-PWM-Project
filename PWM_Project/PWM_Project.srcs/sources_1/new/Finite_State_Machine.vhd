----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andy Everitt and Greg Bates
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
           State : out std_logic_vector(1 downto 0)
           );
end Finite_State_Machine;

architecture Behavioral of Finite_State_Machine is

type state_type is (s0, s1, s2, s3); --Four states

signal current_state, next_state : state_type;

begin

-- Assign the next_state to current_state on a rising clk edge.
process (CLK)
begin
    if (rising_edge(CLK)) then
        current_state <= next_state;
    end if;
end process;

-- When but is HIGH cycle to the next state based on current_state.
-- "State" output also set here which is used by external components.
process (But)
begin
    if (rising_edge(CLK) and But = '1') then
        case current_state is
            when s0 =>
                State <= "01";
                next_state <= s1;
            
            when s1 =>
                State <= "10";
                next_state <= s2;
            
            when s2 =>
                State <= "11";
                next_state <= s3;
            
            when s3 =>
                State <= "00";
                next_state <= s0;
        end case;
    end if;
end process;

end Behavioral;
