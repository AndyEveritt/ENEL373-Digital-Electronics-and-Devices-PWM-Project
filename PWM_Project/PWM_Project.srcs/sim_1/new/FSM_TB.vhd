----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2018 11:50:37
-- Design Name: 
-- Module Name: FSM_TB - Behavioral
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

entity FSM_TB is
--  Port ( );
end FSM_TB;

architecture Behavioral of FSM_TB is

component Finite_State_Machine is
    Port ( CLK : in STD_LOGIC;
           But : in STD_LOGIC;
           State : out STD_LOGIC_VECTOR(1 downto 0)
           );
end Finite_State_Machine;
    
type state_type is (s0, s1, s2, s3); --Four states

signal CLK : STD_LOGIC := '0';
signal But : STD_LOGIC;
signal State : STD_LOGIC_VECTOR(1 downto 0);

begin

UUT : Finite_State_Machine
    port map(CLK => CLK, But => But, State => State);

process(CLK)
begin

    CLK <= not CLK after 1ms;
    
end process;

process(But)
begin
    But <= not But after 10ms;
    
end process;
    
end Behavioral;
