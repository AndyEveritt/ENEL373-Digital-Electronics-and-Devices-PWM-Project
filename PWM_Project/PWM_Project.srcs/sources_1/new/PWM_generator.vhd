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
           clk : in STD_LOGIC;
           BTNC, BTNU : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR(15 downto 0) := X"8000"; -- Switches
           LED : out STD_LOGIC_VECTOR (15 downto 0); -- LEDs above switches
           LED16_G : out STD_LOGIC;
--           duty : in STD_LOGIC_VECTOR (N-1 downto 0);
--           period : in STD_LOGIC_VECTOR (N-1 downto 0);
           out_state : in STD_LOGIC_VECTOR (1 downto 0);
           count_out : out STD_LOGIC_VECTOR (N-1 downto 0);
           output : out STD_LOGIC);
--           pwm : out STD_LOGIC;
--           toggle : inout STD_LOGIC;
--           high : out STD_LOGIC;
--           low : out STD_LOGIC);
end PWM_generator;

architecture Behavioral of PWM_generator is

signal count : STD_LOGIC_VECTOR (N-1 downto 0);
signal output_tmp : STD_LOGIC;
signal duty : STD_LOGIC_VECTOR (N-1 downto 0);
signal period : STD_LOGIC_VECTOR (N-1 downto 0);
signal SW_State : STD_LOGIC;

begin

    clk4: process (clk, RESET)
    begin
        if RESET = '1' then
            count <= (others => '0');
        elsif rising_edge(clk) then
            if count = 0 then
                count <= period;
            else
                count <= count - 1;
            end if;
        end if;
        count_out <= count;
    end process clk4;
    
    assign_output: process (count)
        begin
            case out_state is
                when "00" => 
                    if count < duty then
                        output <= '1';
                    else
                        output <= '0';
                    end if;
                when "01" => 
                    if count = 0 then
                        output_tmp <= not output_tmp;
                        output <= output_tmp;
                    end if;
                when "10" => 
                    if count = 0 then
                        output <= '1';
                    end if;
                when "11" => 
                    if count = 0 then
                        output <= '0';
                    end if;
            end case;
        end process assign_output;
    
    process(BTNC)
        begin
            if (rising_edge(CLK) and BTNC = '1') then
                if SW_State = '0' then
                    period <= SW;
                    LED <= period;
                elsif SW_State = '1' then
                    duty <= SW;
                    LED <= duty;
                end if;
            end if;
        end process;
    
    state: process(BTNU)
        begin
            if (rising_edge(CLK) and BTNU = '1') then
                SW_State <= not SW_State;
            end if;
            if SW_State = '0' then
                LED <= period;
            elsif SW_State = '1' then
                LED <= duty;
            end if;
            LED16_G <= SW_State;
        end process state;
        
--    pwm_out: process (count)
--    begin
--        if count < duty then
--            pwm <= '1';
--        else
--            pwm <= '0';
--        end if;
--    end process pwm_out;
    
--    toggle_out: process (count)
--    begin
--        if count = 0 then
--            toggle <= not toggle;
--        end if;
--    end process toggle_out;
    
--    high_out: process (count)
--    begin
--        if count = 0 then
--            high <= '1';

--        end if;
--    end process high_out;
    
--    low_out: process (count)
--    begin
--        if count = 0 then
--            lo
--        end if;
--    end process low_out;

end Behavioral;
