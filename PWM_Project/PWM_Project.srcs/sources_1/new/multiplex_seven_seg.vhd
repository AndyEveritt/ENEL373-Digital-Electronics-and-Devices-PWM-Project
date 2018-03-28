----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2018 14:16:45
-- Design Name: 
-- Module Name: multiplex_seven_seg - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multiplex_seven_seg is
    port(
        clk       : in STD_LOGIC;
        bcd    : in STD_LOGIC_VECTOR(19 downto 0);
--        DP      : in STD_LOGIC;
        CA    : out STD_LOGIC;
        CB    : out STD_LOGIC;
        CC    : out STD_LOGIC;
        CD    : out STD_LOGIC;
        CE    : out STD_LOGIC;
        CF    : out STD_LOGIC;
        CG    : out STD_LOGIC;
        AN  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end multiplex_seven_seg;

architecture Behavioral of multiplex_seven_seg is

    component clock_divider
        generic (OUTPUT_FREQUENCY : INTEGER := 1);
        port (
            in_clock, enable : in STD_LOGIC;
            out_clock : out STD_LOGIC
            );
    end component;
    
    signal counter: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal r_anodes: STD_LOGIC_VECTOR(7 downto 0);
    signal sevenseg    : STD_LOGIC_VECTOR(6 downto 0);
    signal bcd_reg  : STD_LOGIC_VECTOR(3 downto 0);
    
begin

    AN <= r_anodes;

    -- Given Binary Value print it
    multiplex: process(counter)
    begin
        -- Set anode correctly
        case counter(2 downto 0) is
            when "000" => 
                r_anodes <= "11111110"; -- AN 0;
                bcd_reg <= bcd(3 downto 0);
            when "001" =>
                r_anodes <= "11111101"; -- AN 1
                bcd_reg <= bcd(7 downto 4);
            when "010" =>
                r_anodes <= "11111011"; -- AN 2
                bcd_reg <= bcd(11 downto 8);
            when "011" =>
                r_anodes <= "11110111"; -- AN 3
                bcd_reg <= bcd(15 downto 12);
            when "100" =>
                r_anodes <= "11101111"; -- AN 4
                bcd_reg <= bcd(19 downto 16);
--            when "101" => r_anodes <= "11011111"; -- AN 5
--            when "110" => r_anodes <= "10111111"; -- AN 6
--            when "111" => r_anodes <= "01111111"; -- AN 7

            when others =>
                r_anodes <= "11111111"; -- nothing\
                bcd_reg <= "1111";
        end case;
    end process;
    
    process(bcd_reg)
    begin
        -- Set segments correctly
--        case r_anodes is
--            when "11111110" => 
                case bcd_reg is
                    when X"0" => sevenseg <= "0000001";
                    when X"1" => sevenseg <= "1001111";
                    when X"2" => sevenseg <= "0010010";
                    when X"3" => sevenseg <= "0000110";
                    when X"4" => sevenseg <= "1001100";
                    when X"5" => sevenseg <= "0100100";
                    when X"6" => sevenseg <= "1100000";
                    when X"7" => sevenseg <= "0001111";
                    when X"8" => sevenseg <= "0000000";
                    when X"9" => sevenseg <= "0001100";
                    when others => sevenseg <= "1111111";
                end case;
--            when "11111101" => 
--                case bcd(7 downto 4) is
--                    when X"0" => sevenseg <= "0000001";
--                    when X"1" => sevenseg <= "1001111";
--                    when X"2" => sevenseg <= "0010010";
--                    when X"3" => sevenseg <= "0000110";
--                    when X"4" => sevenseg <= "1001100";
--                    when X"5" => sevenseg <= "0100100";
--                    when X"6" => sevenseg <= "1100000";
--                    when X"7" => sevenseg <= "0001111";
--                    when X"8" => sevenseg <= "0000000";
--                    when X"9" => sevenseg <= "0001100";
--                end case;
--            when "11111011" => 
--                case bcd(11 downto 8) is
--                   when X"0" => sevenseg <= "0000001";
--                   when X"1" => sevenseg <= "1001111";
--                   when X"2" => sevenseg <= "0010010";
--                   when X"3" => sevenseg <= "0000110";
--                   when X"4" => sevenseg <= "1001100";
--                   when X"5" => sevenseg <= "0100100";
--                   when X"6" => sevenseg <= "1100000";
--                   when X"7" => sevenseg <= "0001111";
--                   when X"8" => sevenseg <= "0000000";
--                   when X"9" => sevenseg <= "0001100";
--               end case;
--            when "11110111" => 
--                case bcd(15 downto 12) is
--                   when X"0" => sevenseg <= "0000001";
--                   when X"1" => sevenseg <= "1001111";
--                   when X"2" => sevenseg <= "0010010";
--                   when X"3" => sevenseg <= "0000110";
--                   when X"4" => sevenseg <= "1001100";
--                   when X"5" => sevenseg <= "0100100";
--                   when X"6" => sevenseg <= "1100000";
--                   when X"7" => sevenseg <= "0001111";
--                   when X"8" => sevenseg <= "0000000";
--                   when X"9" => sevenseg <= "0001100";
--               end case;
--            when "11101111" => 
--                case bcd(19 downto 16) is
--                   when X"0" => sevenseg <= "0000001";
--                   when X"1" => sevenseg <= "1001111";
--                   when X"2" => sevenseg <= "0010010";
--                   when X"3" => sevenseg <= "0000110";
--                   when X"4" => sevenseg <= "1001100";
--                   when X"5" => sevenseg <= "0100100";
--                   when X"6" => sevenseg <= "1100000";
--                   when X"7" => sevenseg <= "0001111";
--                   when X"8" => sevenseg <= "0000000";
--                   when X"9" => sevenseg <= "0001100";
--               end case;

--            when others => sevenseg <= "1111111"; -- nothing
--        end case;
        
        CA <= sevenseg(6);
        CB <= sevenseg(5);
        CC <= sevenseg(4);
        CD <= sevenseg(3);
        CE <= sevenseg(2);
        CF <= sevenseg(1);
        CG <= sevenseg(0);
        
    end process;

    countClock: process(clk, counter)
    begin
        if rising_edge(clk) then
            -- Iterate
            counter <= counter + 1;
        end if;
    end process;


end Behavioral;