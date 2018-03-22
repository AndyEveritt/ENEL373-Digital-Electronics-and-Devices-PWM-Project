----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.03.2018 18:33:16
-- Design Name: 
-- Module Name: counter_16_bit_tb - Behavioral
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

entity counter_16_bit_tb is
--  Port ( );
end counter_16_bit_tb;

architecture Behavioral of counter_16_bit_tb is
    component counter_16_bit
        port (
            counter_in, RESET : in STD_LOGIC;
            counter_start : in STD_LOGIC_VECTOR(15 downto 0);
            counter_out : out STD_LOGIC_VECTOR(15 downto 0);
            LED17_R : out STD_LOGIC
            );
    end component;
    
    signal RESET : STD_LOGIC := '0';
    signal counter_start : STD_LOGIC_VECTOR(15 downto 0) := X"8000";
    signal counter_out : STD_LOGIC_VECTOR(15 downto 0);
    signal LED17_R : STD_LOGIC;
    signal Clock : STD_LOGIC;
    constant ClockPeriod : TIME := 50 ns;

begin
UUT: counter_16_bit
    port map (counter_in => Clock, counter_start => counter_start, counter_out => counter_out, RESET => RESET, LED17_R => LED17_R);
    
    process
        begin
        Clock <= '1';
        wait for 10 ns;
        Clock <= '0';
        wait for 10 ns;
        if (RESET = '1') then
            wait for 10 ns;
            RESET <= '0';
        end if;
        
    end process;

end Behavioral;
