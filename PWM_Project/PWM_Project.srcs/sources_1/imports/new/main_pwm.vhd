----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andy Everitt
-- 
-- Create Date: 07.03.2018 15:06:13
-- Design Name: 
-- Module Name: main_pwm - Structural
-- Project Name: PWM Milestone 1
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
library EXAMPLES;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity main_pwm is
  Port (
       CLK100MHZ : in STD_LOGIC; -- 100 MHz hardware clock
       BTNC, BTNR : in STD_LOGIC; -- Buttons
       SW : in STD_LOGIC_VECTOR(15 downto 0) := X"8000"; -- Switches
       LED : out STD_LOGIC_VECTOR (15 downto 0); -- LEDs above switches
       LED16_R, LED17_R : out STD_LOGIC; -- Red part of RGB LEDs
       JA : out STD_LOGIC_VECTOR (2 downto 1) -- Pmod output
--       CA : out STD_LOGIC;
--       CB : out STD_LOGIC;
--       CC : out STD_LOGIC;
--       CD : out STD_LOGIC;
--       CE : out STD_LOGIC;
--       CF : out STD_LOGIC;
--       CG : out STD_LOGIC;
--       AN : out STD_LOGIC_VECTOR(7 downto 0)
        );
end main_pwm;

architecture struct of main_pwm is
    component clock_divider
        generic (OUTPUT_FREQUENCY : INTEGER := 1);
        port (
            in_clock, enable : in STD_LOGIC;
            out_clock : out STD_LOGIC
            );
    end component;
    
    component counter_16_bit
        port (
            counter_in, RESET : in STD_LOGIC;
            counter_start : in STD_LOGIC_VECTOR(15 downto 0);
            counter_out : out STD_LOGIC_VECTOR(15 downto 0);
            pulse_out : out STD_LOGIC
            );
    end component;
    
--    component segment_counter
--        port (
--            num : in STD_LOGIC_VECTOR(3 downto 0);
--            CA : out STD_LOGIC;
--            CB : out STD_LOGIC;
--            CC : out STD_LOGIC;
--            CD : out STD_LOGIC;
--            CE : out STD_LOGIC;
--            CF : out STD_LOGIC;
--            CG : out STD_LOGIC;
----            AN_in : in STD_LOGIC_VECTOR(7 downto 0);
--            AN : out STD_LOGIC_VECTOR(7 downto 0)
--            );
--    end component;
    
    signal CLK5HZ : STD_LOGIC;
    signal CLK1000HZ : STD_LOGIC;
    signal RESET : STD_LOGIC := '0';
    
    -- Default counter value
    signal count16bit : STD_LOGIC_VECTOR(15 downto 0) := X"8000";
    signal count16bitout : STD_LOGIC_VECTOR(15 downto 0);
    signal count16bitpulse : STD_LOGIC;

begin
-- Clock signals
Clock5Hz: clock_divider
    generic map (OUTPUT_FREQUENCY => 5)
    port map (in_clock => CLK100MHZ, enable => '1', out_clock => CLK5HZ);
Clock1000Hz: clock_divider
    generic map (OUTPUT_FREQUENCY => 1000)
    port map (in_clock => CLK100MHZ, enable => '1', out_clock => CLK1000HZ);

-- 16 bit down counter
Counter16: counter_16_bit
    port map (counter_in => CLK1000HZ, RESET => RESET, counter_start => count16bit, counter_out => count16bitout, pulse_out => count16bitpulse);

LED16_R <= CLK5HZ;

-- Flash LED(1) when counter reaches 0
process(count16bitpulse)
begin
    LED17_R <= count16bitpulse;
    JA(2) <= count16bitpulse;
    JA(1) <= '0';
end process;

-- update counter start based on switch input
count_register : process(BTNC)
begin
    if (rising_edge(CLK100MHZ) and BTNC = '1') then
        count16bit <= SW;
        LED <= count16bit;
    end if;
end process;

-- reset counter using currently loaded count16bit
reset_btn : process(BTNR)
begin
    if (rising_edge(CLK100MHZ)) then
        RESET <= BTNR;
    end if;
end process;

end struct;
