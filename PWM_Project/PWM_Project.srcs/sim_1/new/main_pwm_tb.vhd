----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2018 10:15:52
-- Design Name: 
-- Module Name: main_pwm_tb - Behavioral
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

entity main_pwm_tb is
--  Port ( );
end main_pwm_tb;

architecture Behavioral of main_pwm_tb is
    component main_pwm
        port (
            CLK100MHZ, BTNC : in STD_LOGIC;
            SW : in STD_LOGIC_VECTOR(15 downto 0);
            LED : out STD_LOGIC_VECTOR (15 downto 0)
            );
    end component;
    
    signal SW : STD_LOGIC_VECTOR(15 downto 0);
    signal LED : STD_LOGIC_VECTOR(15 downto 0);
    signal BTNC : STD_LOGIC;
    signal Clock : STD_LOGIC;
    constant ClockPeriod : TIME := 50 ns;

begin
    UUT: main_PWM
        port map (SW => SW, LED => LED, CLK100MHZ => Clock, BTNC => BTNC);
        
    process
        begin
        Clock <= '1';
        wait for 1 ns;
        Clock <= '0';
        wait for 1 ns;
    end process;

end Behavioral;
