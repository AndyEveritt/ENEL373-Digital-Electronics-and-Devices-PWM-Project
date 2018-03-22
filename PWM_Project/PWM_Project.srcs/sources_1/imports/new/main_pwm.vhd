----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2018 15:06:13
-- Design Name: 
-- Module Name: Clock_Divider - Behavioral
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
       CLK100MHZ, BTNC : in STD_LOGIC;
       SW : in STD_LOGIC_VECTOR(15 downto 0) := X"8000";
       LED : out STD_LOGIC_VECTOR (15 downto 0);
       LED16_R : out STD_LOGIC;
       LED17_R : out STD_LOGIC
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
    
--    component counter_4_bit
--        port (
--            counter_in, RESET : in STD_LOGIC;
--            counter_start : in STD_LOGIC_VECTOR(3 downto 0);
--            counter_out : out STD_LOGIC_VECTOR(3 downto 0);
--            pulse_out : out STD_LOGIC
--            );
--    end component;
    
    component counter_16_bit
        port (
            counter_in, RESET : in STD_LOGIC;
            counter_start : in STD_LOGIC_VECTOR(15 downto 0);
            counter_out : out STD_LOGIC_VECTOR(15 downto 0);
            LED17_R : out STD_LOGIC
            );
    end component;
    
    --component Multiplexer
    --    Port ( 
    --        SEL : in  STD_LOGIC;
    --        X   : out STD_LOGIC_VECTOR
    --        );
    --end component;
    
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
    --signal AN : STD_LOGIC_VECTOR (7 downto 0);
    
    -- Counter BCD values
--    signal count1 : STD_LOGIC_VECTOR(3 downto 0);
--    signal count2 : STD_LOGIC_VECTOR(3 downto 0);
--    signal count3 : STD_LOGIC_VECTOR(3 downto 0);
--    signal count4 : STD_LOGIC_VECTOR(3 downto 0);
    
    -- Counter overflow signals
--    signal count_over_1 : STD_LOGIC;
--    signal count_over_2 : STD_LOGIC;
--    signal count_over_3 : STD_LOGIC;
--    signal count_over_4 : STD_LOGIC;
    
    -- Default counter value
    signal count16bit : STD_LOGIC_VECTOR(15 downto 0) := X"8000";
    signal count16bitout : STD_LOGIC_VECTOR(15 downto 0);
--    signal count16bitpulse : STD_LOGIC;

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
    port map (counter_in => CLK1000HZ, RESET => RESET, counter_start => count16bit, counter_out => count16bitout, LED17_R => LED17_R);
--Counter1: counter_4_bit
--    port map (counter_in => CLK1000HZ, RESET => RESET, counter_start => count16bit(3 downto 0), counter_out => count1, pulse_out => count_over_1);
--Counter2: counter_4_bit
--    port map (counter_in => count_over_1, RESET => RESET, counter_start => count16bit(7 downto 4), counter_out => count2, pulse_out => count_over_2);
--Counter3: counter_4_bit
--    port map (counter_in => count_over_2, RESET => RESET, counter_start => count16bit(11 downto 8), counter_out => count3, pulse_out => count_over_3);
--Counter4: counter_4_bit
--    port map (counter_in => count_over_3, RESET => RESET, counter_start => count16bit(15 downto 12), counter_out => count4, pulse_out => count_over_4);

--U4: Multiplexer
--    port map (SEL => '0', X => AN);
--Disp1: segment_counter
--    port map (num => count1, CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG, AN_in => "11111110", AN => AN);
--Disp2: segment_counter
--    port map (num => count2, CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG, AN_in => "11111101", AN => AN);
--Disp3: segment_counter
--    port map (num => count3, CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG, AN_in => "11111011", AN => AN);
--Disp4: segment_counter
--    port map (num => count4, CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG, AN_in => "11110111", AN => AN);

--process(count1, count2, count3, count4)
--begin
--    count16bitout <= count4 & count3 & count2 & count1;
--end process;

-- Set counter reset
--process(count16bitout)
--begin
--    if (count16bitout = X"0000") then
--        RESET <= '1';
----        LED17_R <= '1';
--    else
--        RESET <= '0';
----        LED17_R <= '0';
--    end if;
--end process;

LED16_R <= CLK5HZ;

-- Flash LED(1) when counter reaches 0
--LED(1) <= count_over_1;
--process(count16bitout)
--begin
--    if (count16bitout = X"0000") then
--        LED(1) <= '1';
--    else
--        LED(1) <= '0';
--    end if;
--end process;

-- update counter start based on switch input
process(BTNC)
begin
    if (rising_edge(CLK100MHZ) and BTNC = '1') then
        count16bit <= SW;
        LED <= count16bit;
    end if;
end process;


end struct;
