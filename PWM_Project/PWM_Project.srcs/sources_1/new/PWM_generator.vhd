----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andy Everitt
-- 
-- Create Date: 18.04.2018 14:44:31
-- Design Name: 
-- Module Name: PWM_generator - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM_generator is
    Generic (N : integer := 16); -- number of bits used for the binary down counter.
    Port ( RESET : in STD_LOGIC;
           clk, clk1000hz : in STD_LOGIC; -- "clk" is used for the counter and can be changed by the user, clk1000hz is to syncronise processes.
           BTNU, BTNC : in STD_LOGIC; -- Buttons
           SW : in STD_LOGIC_VECTOR (15 downto 0); -- Switches
           LED : out STD_LOGIC_VECTOR (15 downto 0); -- LEDs
           LED16_R, LED16_G, LED16_B, LED17_R, LED17_G, LED17_B : out STD_LOGIC; -- RGB LEDs
           count_zero : out STD_LOGIC; -- pulses HIGH when counter = 0
           count_out : out STD_LOGIC_VECTOR (N-1 downto 0); -- current counter value output
           output : out STD_LOGIC; -- PWM output
           toggle_output : out STD_LOGIC -- Toggle output
           );
end PWM_generator;

architecture Behavioral of PWM_generator is

signal count : STD_LOGIC_VECTOR (N-1 downto 0); -- current counter value
signal period : STD_LOGIC_VECTOR (N-1 downto 0) := X"0009"; -- current counter period
signal duty : STD_LOGIC_VECTOR (N-1 downto 0) := X"004D"; -- 4D is roughly 30% duty cycle. X"00FF" = 100%, X"0000" = 0%
signal SW_State : STD_LOGIC; -- Used to program either period or duty using SW inputs
signal pwm : STD_LOGIC; -- PWM signal
signal toggle : STD_LOGIC; -- toggle signal

begin

    -- N bit continuous down counter that outputs the current count value, count_zero, and toggle_output. 
    clk4: process (clk, RESET)
    begin
        if RESET = '1' then
            count <= (others => '0'); -- sets the count value to 0 when RESET is HIGH
        elsif rising_edge(clk) then
            if count = 0 then
                count <= period; -- restarts counter after reaching 0
                count_zero <= '1'; -- HIGH only while count = 0
                toggle <= not toggle; -- T flip flop to output toggle waveform
            else
                count <= count - 1; -- decremment counter
                count_zero <= '0';
            end if;
        end if;
        count_out <= count; -- assign signals to outputs
        toggle_output <= toggle;
    end process clk4;
    
    -- Sets the period and duty signals for the counter when BTNC is HIGH.
    set_PWM: process(BTNC)
        begin
            if (rising_edge(clk1000hz) and BTNC = '1') then
                if SW_State = '0' then
                    period <= SW;
                elsif SW_State = '1' then
                    duty <= "00000000" & SW(7 downto 0);
                end if;
            end if;
        end process set_PWM;
    
    -- Changes SW_State when BTNU goes HIGH.
    state: process(BTNU)
        begin
            if (rising_edge(clk1000hz) and BTNU = '1') then
                SW_State <= not SW_State;
            end if;
        end process state;
        
    -- Shows the currently loaded period or duty on the LEDs above the switches.
    -- LED17_B is on when showing duty, and off when showing period.
    show_PWM: process(SW_State, BTNC)
        begin
            if (rising_edge(clk1000hz)) then
                if SW_State = '0' then
                    LED <= period;
                    LED17_B <= '0';
                elsif SW_State = '1' then
                    LED <= duty;
                    LED17_B <= '1';
                end if;
            end if;
        end process show_PWM;
        
    -- Calculate when PWM output should be HIGH based on current count value, period and duty cycle (as a percentage).
    -- Duty cycle is from 0-255, where 51 would be 100*51/255 % = 20%.
    pwm_out: process (count)
    begin
        if ("11111111" * count) < (period * duty(7 downto 0)) then
            pwm <= '1';
        else
            pwm <= '0';
        end if;
        output <= pwm;
    end process pwm_out;

end Behavioral;
