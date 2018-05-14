----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
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
    Generic (N : integer := 16);
    Port ( RESET : in STD_LOGIC;
           clk, clk1000hz : in STD_LOGIC;
           BTNC, BTNU : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR(15 downto 0) := X"8000"; -- Switches
           LED : out STD_LOGIC_VECTOR (15 downto 0); -- LEDs above switches
           LED16_R, LED16_G, LED16_B : out STD_LOGIC;
           out_state : in STD_LOGIC_VECTOR (1 downto 0);
           count_out : out STD_LOGIC_VECTOR (N-1 downto 0);
           output : out STD_LOGIC
           );
end PWM_generator;

architecture Behavioral of PWM_generator is

signal count : STD_LOGIC_VECTOR (N-1 downto 0);
signal output_tmp : STD_LOGIC;
signal period : STD_LOGIC_VECTOR (N-1 downto 0) := X"0009";
signal duty : STD_LOGIC_VECTOR (N-1 downto 0) := X"004D"; -- 4D is roughly 30% duty cycle. X"00FF" = 100%, X"0000" = 0%
signal SW_State : STD_LOGIC;
signal count_zero : STD_LOGIC := '0';
signal count_toggle : STD_LOGIC := '0';
signal pwm : STD_LOGIC;
signal toggle : STD_LOGIC;
signal high : STD_LOGIC;
signal low : STD_LOGIC;

begin

    clk4: process (clk, RESET)
    begin
        if RESET = '1' then
            count <= (others => '0');
        elsif rising_edge(clk) then
            if count = 0 then
                count <= period;
                count_zero <= '1';
                count_toggle <= not count_toggle;
            else
                count <= count - 1;
            end if;
        end if;
        count_out <= count;
    end process clk4;
    
    process (out_state)
    begin
        if rising_edge(clk) then
            if (out_state = "10" or out_state = "11") then
                count_zero <= '0';
            end if;
        end if;
    end process;
    
    assign_output: process (count)
    begin
        LED16_R <= '0';
        LED16_G <= '0';
        LED16_B <= '0';
        
        
        
-- This code works to assert output (LED17_R & JA(2)) high permenantly after counter reaches zero

--        if out_state = "10" then
--            if count = X"0000" then
--                output <= '1';
--            end if;
--        end if;
--        output <= output_tmp;


-- This code does not work
-- PWM output is ok
-- Toggle output does random assignments
-- Assert High only asserts high when count = 0 else asserts low?

--        case out_state is
--            when "00" => 
--                LED16_R <= '1';
--                if ("11111111" * count) < (period * duty(7 downto 0)) then
--                    output <= '1';
--                else
--                    output <= '0';
--                end if;
--            when "01" =>
--                LED16_G <= '1'; 
--                if count_toggle = '1' then
--                    output_tmp <= not output_tmp;
--                    output <= output_tmp;
--                end if;
--            when "10" =>
--                LED16_B <= '1';
--                output <= '0';
--                if count_zero = '1' then
--                    output <= '1';
--                end if;
--            when "11" =>
--                output <= '1';
--                if count_zero = '1' then
--                    output <= '0';
--                end if;
--        end case;


        case out_state is
            when "00" => 
                LED16_R <= '1';
                output <= pwm;
            when "01" =>
                LED16_G <= '1';
                output <= toggle;
            when "10" =>
                LED16_B <= '1';
                output <= high;
            when "11" =>
                output <= low;
            when others =>
                output <= '1';
        end case;


-- This code does not work
-- PWM output is ok
-- Toggle output does random assignments
-- Assert High only asserts high when count = 0 else asserts low?

--        if out_state = "00" then
--            LED16_R <= '1';
--            if ("11111111" * count) < (period * duty(7 downto 0)) then
--                output <= '1';
--            else
--                output <= '0';
--            end if;
--        end if;
--        if out_state = "01" then
--            LED16_G <= '1'; 
--            if count = X"0000" then
--                output_tmp <= not output_tmp;
--                output <= output_tmp;
--            end if;
--        end if;
--        if out_state = "10" then
--            LED16_B <= '1';
--            if count = X"0000" then
--                output <= '1';
--            end if;
--        end if;
--        if out_state = "11" then
--            if count = X"0000" then
--                output <= '0';
--            end if;
--        end if;
       
    end process assign_output;
    
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
    
    state: process(BTNU)
        begin
            if (rising_edge(clk1000hz) and BTNU = '1') then
                SW_State <= not SW_State;
            end if;
--            LED16_G <= SW_State;
        end process state;
        
    show_PWM: process(SW_State, BTNC)
        begin
            if (rising_edge(clk1000hz)) then
                if SW_State = '0' then
                    LED <= period;
                elsif SW_State = '1' then
                    LED <= duty;
                end if;
            end if;
        end process show_PWM;
        
        
    pwm_out: process (count)
    begin
        if ("11111111" * count) < (period * duty(7 downto 0)) then
            pwm <= '1';
        else
            pwm <= '0';
    end if;
    end process pwm_out;
    
    toggle_out: process (count)
    begin
        if count = 0 then
            toggle <= not toggle;
        end if;
    end process toggle_out;
    
    high_out: process (count)
    begin
        if count = 0 then
            high <= '1';
        end if;
    end process high_out;
    
    low_out: process (count)
    begin
        if count = 0 then
            low <= '0';
        end if;
    end process low_out;

end Behavioral;
