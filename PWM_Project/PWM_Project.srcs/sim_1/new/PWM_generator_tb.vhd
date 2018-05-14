----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2018 18:54:29
-- Design Name: 
-- Module Name: PWM_generator_tb - Behavioral
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

entity PWM_generator_tb is
--  Port ( );
end PWM_generator_tb;

architecture Behavioral of PWM_generator_tb is
    component PWM_generator
        Generic (N : integer := 16);
        Port ( RESET : in STD_LOGIC;
               clk, clk1000hz : in STD_LOGIC;
               BTNC, BTNU : in STD_LOGIC;
               SW : in STD_LOGIC_VECTOR(15 downto 0) := X"8000"; -- Switches
               LED : out STD_LOGIC_VECTOR (15 downto 0); -- LEDs above switches
               LED16_R, LED16_G, LED16_B : out STD_LOGIC; -- RGB LEDs
               out_state : in STD_LOGIC_VECTOR (1 downto 0);
               count_out : out STD_LOGIC_VECTOR (N-1 downto 0);
               output : out STD_LOGIC
               );
    end component;
    
    signal RESET : STD_LOGIC := '0';
    signal count16bitout : STD_LOGIC_VECTOR(15 downto 0);
    signal PWM_out : STD_LOGIC;
    signal LED16_R : STD_LOGIC;
    signal LED16_G : STD_LOGIC;
    signal LED16_B : STD_LOGIC;
    signal LED17_R : STD_LOGIC;
    signal BTNC : STD_LOGIC;
    signal BTNU_d : STD_LOGIC;
    signal SW : STD_LOGIC_VECTOR(15 downto 0);
    signal LED : STD_LOGIC_VECTOR(15 downto 0);
    signal CLK : STD_LOGIC;
    signal PWM_state : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant ClockPeriod : TIME := 50 ns;
    
begin

UUT: PWM_generator
    port map (RESET => RESET, clk => CLK, clk1000hz => CLK, BTNC => BTNC, BTNU => BTNU_d, out_state => PWM_state, count_out => count16bitout, output => PWM_out);
--    port map (RESET => RESET, clk => CLK, clk1000hz => CLK, BTNC => BTNC, BTNU => BTNU_d, SW => SW, LED => LED, LED16_R => LED16_R, LED16_G => LED16_G, LED16_B => LED16_B, out_state => PWM_state, count_out => count16bitout, output => PWM_out);
    
    process
        begin
        CLK <= '1';
        wait for 10 ns;
        CLK <= '0';
        wait for 10 ns;
        if (RESET = '1') then
            wait for 10 ns;
            RESET <= '0';
        end if;
        
    end process;
    
end Behavioral;
